--generated from ISE Schematic tool
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
          led  : out   std_logic_vector(15 downto 0)
         );
end synth;

architecture BEHAVIORAL of synth is
   signal sel     : std_logic_vector (7 downto 0);
   signal XLXN_4  : std_logic;
   signal phase  : std_logic_vector (7 downto 0);
   signal XLXN_7  : std_logic;
   signal wave  : std_logic_vector (7 downto 0);
   signal XLXN_10 : std_logic;
   signal XLXN_11 : std_logic;
   signal post_amp : std_logic_vector (7 downto 0);
   signal data : std_logic_vector (7 downto 0);
   signal valid : std_logic;
   
   component addr_decode
      port ( clk   : in    std_logic; 
             cs    : in    std_logic; 
             valid : in    std_logic; 
             data  : in    std_logic_vector (7 downto 0); 
             sel   : out   std_logic_vector (7 downto 0));
   end component;
   
   component spi_slave
      port ( clk  : in    std_logic; 
             sck  : in    std_logic; 
             sdi  : in    std_logic; 
             cs   : in    std_logic; 
             wr   : out   std_logic; 
             data : out   std_logic_vector (7 downto 0));
   end component;
   
   component lut
      port ( clk         : in    std_logic; 
             smp_val_in  : in    std_logic; 
             cs          : in    std_logic; 
             ctl_val     : in    std_logic; 
             smp_in      : in    std_logic_vector (7 downto 0); 
             ctl_in      : in    std_logic_vector (7 downto 0); 
             smp_val_out : out   std_logic; 
             smp_out     : out   std_logic_vector (7 downto 0));
   end component;
   
   component pwm
      port ( clk        : in    std_logic; 
             smp_val_in : in    std_logic; 
             smp_in     : in    std_logic_vector (7 downto 0); 
             wave_out   : out   std_logic);
   end component;
   
   component smp_clkgen
      port ( clk     : in    std_logic; 
             smp_clk : out   std_logic);
   end component;
   
   component volctl
      port ( clk         : in    std_logic; 
             smp_val_in  : in    std_logic; 
             cs          : in    std_logic; 
             ctl_val     : in    std_logic; 
             smp_in      : in    std_logic_vector (7 downto 0); 
             ctl_in      : in    std_logic_vector (7 downto 0); 
             smp_val_out : out   std_logic; 
             smp_out     : out   std_logic_vector (7 downto 0));
   end component;
   
   component phase_acc
      port ( clk         : in    std_logic; 
             smp_val_in  : in    std_logic; 
             cs          : in    std_logic; 
             ctl_val     : in    std_logic; 
             ctl_in      : in    std_logic_vector (7 downto 0); 
             smp_val_out : out   std_logic; 
             smp_out     : out   std_logic_vector (7 downto 0));
   end component;
   
   component leds
      port (
           clk : in STD_LOGIC;
           --control
           cs : in STD_LOGIC;
           ctl_val : in STD_LOGIC;
           ctl_in : in STD_LOGIC_VECTOR(7 downto 0);
		   --misc
		   leds : out STD_LOGIC_VECTOR(15 downto 0));
   end component;
   
begin
   XLXI_1 : addr_decode
      port map (clk=>clk,
                cs=>cs,
                data(7 downto 0)=>data(7 downto 0),
                valid=>valid,
                sel(7 downto 0)=>sel(7 downto 0));
   
   XLXI_2 : spi_slave
      port map (clk=>clk,
                cs=>cs,
                sck=>sck,
                sdi=>sdi,
                data(7 downto 0)=>data(7 downto 0),
                wr=>valid);
   
   XLXI_3 : lut
      port map (clk=>clk,
                cs=>sel(1),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_in(7 downto 0)=>phase(7 downto 0),
                smp_val_in=>XLXN_7,
                smp_out(7 downto 0)=>wave(7 downto 0),
                smp_val_out=>XLXN_10);
   
   XLXI_4 : pwm
      port map (clk=>clk,
                smp_in(7 downto 0)=>post_amp(7 downto 0),
                smp_val_in=>XLXN_11,
                wave_out=>l_out);
   
   XLXI_5 : smp_clkgen
      port map (clk=>clk,
                smp_clk=>XLXN_4);
   
   XLXI_7 : volctl
      port map (clk=>clk,
                cs=>sel(2),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_in(7 downto 0)=>wave(7 downto 0),
                smp_val_in=>XLXN_10,
                smp_out(7 downto 0)=>post_amp(7 downto 0),
                smp_val_out=>XLXN_11);
   
   XLXI_8 : phase_acc
      port map (clk=>clk,
                cs=>sel(0),
                ctl_in(7 downto 0)=>data(7 downto 0),
                ctl_val=>valid,
                smp_val_in=>XLXN_4,
                smp_out(7 downto 0)=>phase(7 downto 0),
                smp_val_out=>XLXN_7);

   led_ctl : leds
	  port map (clk=>clk,
			    cs=>sel(3),
				ctl_in=>data,
				ctl_val=>valid,
				leds=>led);
   
end BEHAVIORAL;


