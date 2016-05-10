library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity drum is
    Port ( clk : in STD_LOGIC;
           cfgdata : in STD_LOGIC_VECTOR (7 downto 0);
           smp_clk : in STD_LOGIC;
           load : in STD_LOGIC;
           cs : in STD_LOGIC;
           sample : out STD_LOGIC_VECTOR(7 downto 0);
           sample_valid : out STD_LOGIC);
end drum;

architecture Behavioral of drum is
    type table is array(0 to 255) of std_logic_vector(7 downto 0);
    constant noise : table := 
    (
        x"7E",x"92",x"38",x"3A",x"2A",x"ED",x"7B",x"72",x"6E",x"F2",x"68",x"D8",x"00",x"FC",x"6F",x"C0",
        x"89",x"84",x"12",x"20",x"EC",x"E6",x"AF",x"F3",x"71",x"A2",x"3B",x"BE",x"1B",x"DB",x"19",x"89",
        x"BB",x"B1",x"1C",x"B3",x"78",x"3F",x"51",x"A2",x"84",x"67",x"67",x"91",x"C1",x"1D",x"F6",x"0F",
        x"2B",x"F3",x"52",x"90",x"83",x"EA",x"67",x"F1",x"EC",x"4C",x"88",x"C0",x"42",x"AF",x"0A",x"FC",
        x"CB",x"EE",x"AE",x"D9",x"DA",x"02",x"08",x"CB",x"9B",x"80",x"D4",x"84",x"E7",x"A1",x"BB",x"83",
        x"00",x"E0",x"FA",x"AE",x"B6",x"D2",x"85",x"A7",x"87",x"50",x"CA",x"DE",x"84",x"ED",x"B3",x"E2",
        x"21",x"0C",x"C9",x"0C",x"47",x"4B",x"FD",x"66",x"56",x"49",x"38",x"F1",x"40",x"17",x"DB",x"28",
        x"60",x"7B",x"38",x"AB",x"C6",x"02",x"EB",x"0F",x"4C",x"D7",x"81",x"0B",x"28",x"89",x"13",x"AC",
        x"37",x"6C",x"A7",x"E7",x"F2",x"13",x"5D",x"9A",x"BB",x"01",x"A3",x"55",x"55",x"AA",x"69",x"69",
        x"4D",x"4A",x"FC",x"81",x"F3",x"03",x"06",x"33",x"BA",x"BE",x"F2",x"41",x"99",x"2B",x"49",x"B2",
        x"29",x"3A",x"1A",x"CC",x"CC",x"DA",x"60",x"CA",x"E3",x"B4",x"B2",x"33",x"1A",x"4D",x"24",x"D9",
        x"B9",x"EE",x"CB",x"A6",x"BC",x"52",x"65",x"EC",x"BF",x"6B",x"B8",x"0A",x"31",x"BC",x"5E",x"B6",
        x"9E",x"AD",x"D5",x"C9",x"F7",x"DF",x"BF",x"11",x"AC",x"DF",x"03",x"B7",x"99",x"E3",x"5B",x"BD",
        x"87",x"00",x"EB",x"B7",x"6E",x"83",x"D3",x"35",x"CF",x"49",x"17",x"F2",x"B5",x"18",x"16",x"7D",
        x"05",x"07",x"3A",x"C8",x"51",x"56",x"F9",x"EB",x"54",x"21",x"D0",x"7E",x"9E",x"65",x"2A",x"77",
        x"73",x"68",x"E4",x"3A",x"F6",x"E1",x"61",x"83",x"1D",x"2D",x"A4",x"0D",x"CD",x"1A",x"80",x"FB"
    );

    signal phase : std_logic_vector(7 downto 0);
    signal phase_valid : std_logic;
    signal drum_sound : std_logic_vector(7 downto 0);
    signal noteval : std_logic_vector(23 downto 0);
    signal note_ready : std_logic;
    signal cs_old : std_logic;
begin
    drum_sound <= noise(to_integer(unsigned(phase)));
    
    drum_phaser : entity work.oneshot_phaser
    port map(
        clk => clk,
        smp_val_in => smp_clk,
        smp_out => phase,
        smp_val_out => phase_valid,
        ctl_val => note_ready,
        ctl_in => noteval(23 downto 8)
    );
    
    volume : entity work.volctl
    port map(
        clk => clk,
        smp_in => drum_sound,
        smp_val_in => phase_valid,
        smp_out => sample,
        smp_val_out => sample_valid,
        cs => '0',
        ctl_val => note_ready,
        ctl_in => noteval(7 downto 0)
    );
    process(clk)
    begin
        if(rising_edge(clk))
        then
            if(load = '1')
            then
                noteval <= noteval(15 downto 0) & cfgdata;
            end if;
            if(cs_old = '0' and cs = '1')
            then
                note_ready <= '1';
            end if;
            cs_old <= cs;
        end if;
    end process;

end Behavioral;
