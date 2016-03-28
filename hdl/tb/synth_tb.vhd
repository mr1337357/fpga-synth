-- Vhdl test bench created from schematic C:\Users\dconcors\projects\fpgasynth\synth.sch - Mon Mar 28 14:04:08 2016
--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Xilinx recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "Source->Add"
-- menu in Project Navigator to import the testbench. Then
-- edit the user defined section below, adding code to generate the 
-- stimulus for your design.
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
ENTITY synth_synth_sch_tb IS
END synth_synth_sch_tb;
ARCHITECTURE behavioral OF synth_synth_sch_tb IS 

   COMPONENT synth
   PORT( clk	:	IN	STD_LOGIC; 
          cs	:	IN	STD_LOGIC; 
          sck	:	IN	STD_LOGIC; 
          sdi	:	IN	STD_LOGIC; 
          l_out	:	OUT	STD_LOGIC);
   END COMPONENT;

   SIGNAL clk	:	STD_LOGIC := '0';
   SIGNAL cs	:	STD_LOGIC := '1';
   SIGNAL sck	:	STD_LOGIC := '0';
   SIGNAL sdi	:	STD_LOGIC := '0';
   SIGNAL l_out	:	STD_LOGIC;

BEGIN

   UUT: synth PORT MAP(
		clk => clk, 
		cs => cs, 
		sck => sck, 
		sdi => sdi, 
		l_out => l_out
   );

-- *** Test Bench - User Defined Section ***
   ck : PROCESS
   BEGIN
    clk <= not clk;
    wait for 5 ns;
   END PROCESS;
   
   tb : PROCESS
   BEGIN
   
   --start transaction(1, 85, 68)
cs <= '0';
wait for 30 ns;

--byte: 1
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '1';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;

--byte: 85
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '1';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '1';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '1';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '1';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;

--byte: 68
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '1';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '1';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
wait for 30 ns;
cs <= '1';
wait for 30 ns;
--end transaction

--start transaction(0, 0, 255)
cs <= '0';
wait for 30 ns;

--byte: 0
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;

--byte: 0
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '0';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;

--byte: 255
sdi <= '1';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '1';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '1';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '1';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '1';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '1';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '1';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
sdi <= '1';
sck <= '1';
wait for 30 ns;
sck <= '0';
wait for 30 ns;
wait for 30 ns;
cs <= '1';
wait for 30 ns;
--end transaction
   
      WAIT; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
