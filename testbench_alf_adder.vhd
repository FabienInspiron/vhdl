library IEEE;
use IEEE.numeric_bit.all;

ARCHITECTURE adder_tb OF testbench IS

	component halfAdder
		port(A, B  : IN  bit;
			 S, Cy : OUT bit);
	end component halfAdder;
	
	SIGNAL  si1: bit;
	SIGNAL  si2: bit;
	
	SIGNAL 	Ss : bit;
	SIGNAL 	Sc : bit;
	
	BEGIN
	
		dut : halfAdder
		PORT MAP(si1, si2, Ss, Sc);
	
	PROCESS
	BEGIN
		si1 <= '0';
		si2 <= '0';
			
		WAIT FOR 50 ns;
		ASSERT Ss = '0'	REPORT "Erreur1"	SEVERITY error;
		ASSERT Sc = '0'	REPORT "Erreur2"	SEVERITY error;
		
		si1 <= '1';
		si2 <= '0';
			
		WAIT FOR 50 ns;
		ASSERT Ss = '1'	REPORT "Erreur1"	SEVERITY error;
		ASSERT Sc = '0'	REPORT "Erreur2"	SEVERITY error;
		
		si1 <= '1';
		si2 <= '1';
			
		WAIT FOR 50 ns;
		ASSERT Ss = '0'	REPORT "Erreur1"	SEVERITY error;
		ASSERT Sc = '1'	REPORT "Erreur2"	SEVERITY error;
			
		WAIT;
	END PROCESS;
	
END adder_tb;