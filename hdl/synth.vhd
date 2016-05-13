library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity synth is
   port ( clk   : in    std_logic; 
          cs    : in    std_logic; 
          sck   : in    std_logic; 
          sdi   : in    std_logic; 
          l_out : out   std_logic; 
          r_out : out   std_logic);
end synth;

architecture BEHAVIORAL of synth is
   signal chan_1 : std_logic_vector(7 downto 0);
   signal chan_1_valid : std_logic;
   
   signal chan_2 : std_logic_vector(7 downto 0);
   signal chan_2_valid : std_logic;

   signal chan_3 : std_logic_vector(7 downto 0);
   signal chan_3_valid : std_logic;
   
   signal chan_4 : std_logic_vector(7 downto 0);
   signal chan_4_valid : std_logic;
   
--   signal chan_val_l_1  : std_logic;
--   signal chan_val_l_2  : std_logic;
--   signal chan_val_l_3  : std_logic;
--   signal chan_val_l_4  : std_logic;
--   signal chan_val_r_1  : std_logic;
--   signal chan_val_r_2  : std_logic;
--   signal chan_val_r_3  : std_logic;
--   signal chan_val_r_4  : std_logic;
--   signal chan_l_1      : std_logic_vector (7 downto 0);
--   signal chan_l_2      : std_logic_vector (7 downto 0);
--   signal chan_l_3      : std_logic_vector (7 downto 0);
--   signal chan_l_4      : std_logic_vector (7 downto 0);
--   signal chan_r_1      : std_logic_vector (7 downto 0);
--   signal chan_r_2      : std_logic_vector (7 downto 0);
--   signal chan_r_3      : std_logic_vector (7 downto 0);
--   signal chan_r_4      : std_logic_vector (7 downto 0);
   
   signal perc_sig      : std_logic_vector (7 downto 0);
   signal perc_val      : std_logic;
   
   signal data        : std_logic_vector (7 downto 0);
   signal l_dat       : std_logic_vector (9 downto 0);
   signal l_val       : std_logic;
   signal r_dat       : std_logic_vector (9 downto 0);
   signal r_val       : std_logic;
   signal sel         : std_logic_vector (31 downto 0);
   signal smp_clk     : std_logic;
   signal valid       : std_logic;
   
begin
-- SPI SLAVE AND ADDRESS DECODER
   slave : entity work.spi_slave
      port map (clk=>clk,
                cs=>cs,
                sck=>sck,
                sdi=>sdi,
                data=>data,
                wr=>valid);

   decoder : entity work.addr_decode
      port map (clk=>clk,
                cs=>cs,
                data=>data,
                valid=>valid,
                sel=>sel);

-- SAMPLE CLOCK
    smp_clock : entity work.smp_clkgen
        port map (clk=>clk,
                  smp_clk=>smp_clk);

    channel1 : entity work.channel
    port map ( clk => clk,
               cfgdata => data,
               cfg_valid => valid,
               notesel => sel(0),
               wavesel => sel(4),
               envsel => sel(8),
               smpclk => smp_clk,
               wave_out => chan_1,
               wave_out_val => chan_1_valid
    );

    channel2 : entity work.channel
    port map ( clk => clk,
               cfgdata => data,
               cfg_valid => valid,
               notesel => sel(1),
               wavesel => sel(5),
               envsel => sel(9),
               smpclk => smp_clk,
               wave_out => chan_2,
               wave_out_val => chan_2_valid
    );

    channel3 : entity work.channel
    port map ( clk => clk,
               cfgdata => data,
               cfg_valid => valid,
               notesel => sel(2),
               wavesel => sel(6),
               envsel => sel(10),
               smpclk => smp_clk,
               wave_out => chan_3,
               wave_out_val => chan_3_valid
    );
    
    channel4 : entity work.channel
    port map ( clk => clk,
               cfgdata => data,
               cfg_valid => valid,
               notesel => sel(3),
               wavesel => sel(7),
               envsel => sel(11),
               smpclk => smp_clk,
               wave_out => chan_4,
               wave_out_val => chan_4_valid
    );

   l_mix : entity work.mixer
      port map (clk=>clk,
                smp_clk=>smp_clk,
                smp_in_1=>chan_1,
                smp_in_2=>chan_2,
                smp_in_3=>chan_3,
                smp_in_4=>chan_4,
                smp_in_5=>perc_sig,
                smp_val_in_1=>chan_1_valid,
                smp_val_in_2=>chan_2_valid,
                smp_val_in_3=>chan_3_valid,
                smp_val_in_4=>chan_4_valid,
                smp_val_in_5=>perc_val,
                smp_out=>l_dat,
                smp_val_out=>l_val);
   
   l_pwm : entity work.pwm
      port map (clk=>clk,
                smp_in=>l_dat,
                smp_val_in=>l_val,
                wave_out=>l_out);

   r_mix : entity work.mixer
      port map (clk=>clk,
                smp_clk=>smp_clk,
                smp_in_1=>chan_1,
                smp_in_2=>chan_2,
                smp_in_3=>chan_3,
                smp_in_4=>chan_4,
                smp_in_5=>perc_sig,
                smp_val_in_1=>chan_1_valid,
                smp_val_in_2=>chan_2_valid,
                smp_val_in_3=>chan_3_valid,
                smp_val_in_4=>chan_4_valid,
                smp_val_in_5=>perc_val,
                smp_out=>r_dat,
                smp_val_out=>r_val);
   
   r_pwm : entity work.pwm
      port map (clk=>clk,
                smp_in=>r_dat,
                smp_val_in=>r_val,
                wave_out=>r_out);				

   
--   vol_l_1 : entity work.volctl
--      port map (clk=>clk,
--                cs=>sel(12),
--                ctl_in=>data,
--                ctl_val=>valid,
--                smp_in=>chan_1,
--                smp_val_in=>chan_1_valid,
--                smp_out=>chan_l_1,
--                smp_val_out=>chan_val_l_1);
   
--   vol_l_2 : entity work.volctl
--      port map (clk=>clk,
--                cs=>sel(13),
--                ctl_in=>data,
--                ctl_val=>valid,
--                smp_in=>chan_2,
--                smp_val_in=>chan_2_valid,
--                smp_out=>chan_l_2,
--                smp_val_out=>chan_val_l_2);
   
--   vol_l_3 : entity work.volctl
--      port map (clk=>clk,
--                cs=>sel(14),
--                ctl_in=>data,
--                ctl_val=>valid,
--                smp_in=>chan_3,
--                smp_val_in=>chan_3_valid,
--                smp_out=>chan_l_3,
--                smp_val_out=>chan_val_l_3);
   
--   vol_l_4 : entity work.volctl
--      port map (clk=>clk,
--                cs=>sel(15),
--                ctl_in=>data,
--                ctl_val=>valid,
--                smp_in=>chan_4,
--                smp_val_in=>chan_4_valid,
--                smp_out=>chan_l_4,
--                smp_val_out=>chan_val_l_4);
                

--   vol_r_1 : entity work.volctl
--      port map (clk=>clk,
--                cs=>sel(16),
--                ctl_in=>data,
--                ctl_val=>valid,
--                smp_in=>chan_1,
--                smp_val_in=>chan_1_valid,
--                smp_out=>chan_r_1,
--                smp_val_out=>chan_val_r_1);

--   vol_r_2 : entity work.volctl
--      port map (clk=>clk,
--                cs=>sel(17),
--                ctl_in=>data,
--                ctl_val=>valid,
--                smp_in=>chan_2,
--                smp_val_in=>chan_2_valid,
--                smp_out=>chan_r_2,
--                smp_val_out=>chan_val_r_2);
   
--   vol_r_3 : entity work.volctl
--      port map (clk=>clk,
--                cs=>sel(18),
--                ctl_in=>data,
--                ctl_val=>valid,
--                smp_in=>chan_3,
--                smp_val_in=>chan_3_valid,
--                smp_out=>chan_r_3,
--                smp_val_out=>chan_val_r_3);
   
--   vol_r_4 : entity work.volctl
--      port map (clk=>clk,
--                cs=>sel(19),
--                ctl_in=>data,
--                ctl_val=>valid,
--                smp_in=>chan_4,
--                smp_val_in=>chan_4_valid,
--                smp_out=>chan_r_4,
--                smp_val_out=>chan_val_r_4);

    perc : entity work.drum
        Port map ( clk => clk,
               cfgdata => data,
               smp_clk => smp_clk,
               load => valid,
               cs => sel(20),
               sample => perc_sig,
               sample_valid => perc_val
           );

   
end BEHAVIORAL;