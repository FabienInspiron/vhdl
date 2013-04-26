library IEEE;
use IEEE.numeric_bit.all;

ARCHITECTURE add_test_bench OF testbench IS
	-- décldéclare le composant à utiliser

	component adder
		port(A, B, Cin : IN  bit;
			 S, Cy     : OUT bit);
	end component adder;
	
	SIGNAL SA   : bit ;
	SIGNAL SB   : bit ;
	SIGNAL Scin : bit ;
	SIGNAL SS   : bit ;
	SIGNAL SCy  : bit ;

BEGIN
	-- instanciation de composants
	dut : adder
		PORT MAP(SA, SB, Scin, SS, SCy);

	PROCESS
	BEGIN
		SA <= '0';
		SB <= '1';
		Scin <= '0';

		WAIT FOR 50 ns;
		ASSERT SS = '1' REPORT "Erreur1" SEVERITY error;

		SA <= '1';
		SB <= '1';
		Scin <= '0';

		WAIT FOR 50 ns;
		ASSERT SS = '0' REPORT "Erreur2" SEVERITY error;
		ASSERT SCy = '1' REPORT "Erreur3" SEVERITY error;
		
		SA <= '1';
		SB <= '1';
		Scin <= '1';

		WAIT FOR 50 ns;
		ASSERT SS = '1' REPORT "Erreur4" SEVERITY error;
		ASSERT SS = '1' REPORT "Erreur5" SEVERITY error;
		
		WAIT;
	END PROCESS;

END add_test_bench;