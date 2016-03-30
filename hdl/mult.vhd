library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mult is
   Port (     
            a : in STD_LOGIC_VECTOR(7 downto 0);
            b : in STD_LOGIC_VECTOR(4 downto 0);
            o : out STD_LOGIC_VECTOR(7 downto 0)
        );
end mult;

architecture Behavioral of mult is
   
   signal shift0 : STD_LOGIC_VECTOR(12 downto 0);
   signal shift1 : STD_LOGIC_VECTOR(12 downto 0);
   signal shift2 : STD_LOGIC_VECTOR(12 downto 0);
   signal shift3 : STD_LOGIC_VECTOR(12 downto 0);
   signal shift4 : STD_LOGIC_VECTOR(12 downto 0);

   signal mul0 : STD_LOGIC_VECTOR(12 downto 0);
   signal mul1 : STD_LOGIC_VECTOR(12 downto 0);
   signal mul2 : STD_LOGIC_VECTOR(12 downto 0);
   signal mul3 : STD_LOGIC_VECTOR(12 downto 0);
   signal mul4 : STD_LOGIC_VECTOR(12 downto 0);

begin

   shift0 <= "00000" & a;
   shift1 <= "0000" & a & "0";
   shift2 <= "000" & a & "00";
   shift3 <= "00" & a & "000";
   shift4 <= "0" & a & "0000";

   mul0 <= shift0 when b(0) = '1' else
           "0000000000000";
   mul1 <= shift1 + mul0 when b(1) = '1' else
           mul0;
   mul2 <= shift2 + mul1 when b(2) = '1' else
           mul1;
   mul3 <= shift3 + mul2 when b(3) = '1' else
           mul2;
   mul4 <= shift4 + mul3 when b(4) = '1' else
           mul3;

   o <= mul4(12 downto 5);

end Behavioral;
