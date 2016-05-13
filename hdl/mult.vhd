library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mult is
   Port (     
            a : in STD_LOGIC_VECTOR(7 downto 0);
            b : in STD_LOGIC_VECTOR(7 downto 0);
            o : out STD_LOGIC_VECTOR(7 downto 0)
        );
end mult;

architecture Behavioral of mult is

	signal neg : STD_LOGIC;
	signal abs_a : STD_LOGIC_VECTOR(7 downto 0);
   
   signal shift0 : STD_LOGIC_VECTOR(15 downto 0);
   signal shift1 : STD_LOGIC_VECTOR(15 downto 0);
   signal shift2 : STD_LOGIC_VECTOR(15 downto 0);
   signal shift3 : STD_LOGIC_VECTOR(15 downto 0);
   signal shift4 : STD_LOGIC_VECTOR(15 downto 0);
   signal shift5 : STD_LOGIC_VECTOR(15 downto 0);
   signal shift6 : STD_LOGIC_VECTOR(15 downto 0);
   signal shift7 : STD_LOGIC_VECTOR(15 downto 0);

   signal mul0 : STD_LOGIC_VECTOR(15 downto 0);
   signal mul1 : STD_LOGIC_VECTOR(15 downto 0);
   signal mul2 : STD_LOGIC_VECTOR(15 downto 0);
   signal mul3 : STD_LOGIC_VECTOR(15 downto 0);
   signal mul4 : STD_LOGIC_VECTOR(15 downto 0);
   signal mul5 : STD_LOGIC_VECTOR(15 downto 0);
   signal mul6 : STD_LOGIC_VECTOR(15 downto 0);
   signal mul7 : STD_LOGIC_VECTOR(16 downto 0); 

begin
	neg <= a(7);
	abs_a <= "01111111" when a = "100000000" else
				"00000000" - a when neg = '1' else
				a;

   shift0 <= "00000000" & abs_a;
   shift1 <= "0000000" & abs_a & "0";
   shift2 <= "000000" & abs_a & "00";
   shift3 <= "00000" & abs_a & "000";
   shift4 <= "0000" & abs_a & "0000";
   shift5 <= "000" & abs_a & "00000";
   shift6 <= "00" & abs_a & "000000";
   shift7 <= "0" & abs_a & "0000000";

   mul0 <= shift0 when b(0) = '1' else
           (others => '0');
   mul1 <= shift1 + mul0 when b(1) = '1' else
           mul0;
   mul2 <= shift2 + mul1 when b(2) = '1' else
           mul1;
   mul3 <= shift3 + mul2 when b(3) = '1' else
           mul2;
   mul4 <= shift4 + mul3 when b(4) = '1' else
           mul3;
   mul5 <= shift5 + mul4 when b(5) = '1' else
           mul4;
   mul6 <= shift6 + mul5 when b(6) = '1' else
           mul5;
   mul7 <= ('0' & shift7) + ('0' & mul6) when b(7) = '1' else
           '0' & mul6;

   o <= "00000000" - mul7(16 downto 9) when neg = '1' else
		  mul7(16 downto 9);

end Behavioral;
