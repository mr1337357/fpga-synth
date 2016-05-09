library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity channel is
    Port ( clk : in STD_LOGIC;
           cfgdata : in STD_LOGIC_VECTOR (7 downto 0);
           cfg_valid : in STD_LOGIC;
           notesel : in STD_LOGIC;
           wavesel : in STD_LOGIC;
           envsel : in STD_LOGIC;
           smpclk : in STD_LOGIC;
           --WAVE OUT
           wave_out : out STD_LOGIC_VECTOR(7 downto 0);
           wave_out_val : out STD_LOGIC);
end channel;

architecture Behavioral of channel is

    signal configdata : std_logic_vector(47 downto 0);
    signal loadnote : std_logic;
    signal notesel_old : std_logic;

    signal phase : std_logic_vector(7 downto 0);
    signal phase_valid : std_logic;
    
    signal raw_wave : std_logic_vector(7 downto 0);
    signal raw_wave_valid : std_logic;
    
    signal env_phase : std_logic_vector(7 downto 0);
    signal env_phase_valid : std_logic;
    
    signal env_value : std_logic_vector(7 downto 0);
    signal env_value_valid : std_logic;
    
    signal enveloped : std_logic_vector(7 downto 0);
    signal enveloped_valid : std_logic;
    
    signal fuzzed : std_logic_vector(7 downto 0);
    signal fuzzed_valid : std_logic;

begin

    process(clk,notesel)
    begin
        if(clk'event and clk = '1')
        then
            if(notesel = '1' and notesel_old = '0')
            then
                loadnote <= '1';
            else
                loadnote <= '0';
            end if;
            notesel_old <= notesel;
        end if;
    end process;

    process(clk,configdata)
    begin
        if(clk'event and clk = '1')
        then
            if(notesel = '0' and cfg_valid = '1')
            then
                configdata <= configdata(39 downto 0) & cfgdata;
            end if;
        end if;
    end process;

    wave_phase : entity work.phase_acc
    port map(
        clk => clk,
        smp_val_in => smpclk,
        smp_out => phase,
        smp_val_out => phase_valid,
        ctl_val => loadnote,
        ctl_in => configdata(47 downto 32)
    );
    
    wave_lookup : entity work.lut
    port map(
        clk => clk,
        smp_in => phase,
        smp_val_in => phase_valid,
        smp_out => raw_wave,
        smp_val_out => raw_wave_valid,
        cs => wavesel,
        ctl_val => cfg_valid,
        ctl_in => cfgdata
    );
    
    env_phaser : entity work.oneshot_phaser
    port map(
        clk => clk,
        smp_val_in => smpclk,
        smp_out => env_phase,
        smp_val_out => env_phase_valid,
        ctl_val => loadnote,
        ctl_in => configdata(31 downto 16)
    );
    
    env_lookup : entity work.lut
    port map(
        clk => clk,
        smp_in => env_phase,
        smp_val_in => env_phase_valid,
        smp_out => env_value,
        smp_val_out => env_value_valid,
        cs => envsel,
        ctl_val => cfg_valid,
        ctl_in => cfgdata
    );
    
    enveloper : entity work.volctl
    port map(
        clk => clk,
        smp_in => raw_wave,
        smp_val_in => raw_wave_valid,
        smp_out => enveloped,
        smp_val_out => enveloped_valid,
        cs => '0',
        ctl_val => env_value_valid,
        ctl_in => env_value
    );
    
    fuzzer : entity work.distortion
    port map(
        clk => clk,
        smp_in => enveloped,
        smp_val_in => enveloped_valid,
        smp_out => fuzzed,
        smp_val_out => fuzzed_valid,
        ctl_val => loadnote,
        ctl_in => configdata(15 downto 8)
    );
    
    wave_out <= fuzzed;
    wave_out_val <= fuzzed_valid;

end Behavioral;
