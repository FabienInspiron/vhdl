library IEEE;
use IEEE.numeric_bit.all;

architecture alu_test_bench of testbench is
	
	component alu
		port(code_op : in  unsigned(2 downto 0);
			 op1     : in  unsigned(15 downto 0);
			 op2     : in  unsigned(15 downto 0);
			 output  : out unsigned(15 downto 0));
	end component alu;
	
	SIGNAL Scode_op : unsigned(2 downto 0);
	SIGNAL Sop1     : unsigned(15 downto 0);
	SIGNAL Sop2     : unsigned(15 downto 0);
	SIGNAL Soutput  : unsigned(15 downto 0);
	
begin

	dut : alu
		port map(code_op => Scode_op,
			     op1     => Sop1,
			     op2     => Sop2,
			     output  => Soutput);
	
	PROCESS
		BEGIN
			-- Test de l'addition
			--
			Scode_op <= "000";
			Sop1 <= "0000000000000001";
			Sop2 <= "0000000000000001";
			
			WAIT FOR 50 ns;
			ASSERT Soutput = "0000000000000010" REPORT "Erreur1" SEVERITY error;
			
			-- Test de la soustraction
			--
			Scode_op <= "001";
			Sop1 <= "0000000000000001";
			Sop2 <= "0000000000000001";
			
			WAIT FOR 50 ns;
			ASSERT Soutput = "0000000000000000" REPORT "Erreur2" SEVERITY error;
		
			-- Test du not
			Scode_op <= "010";
			Sop2 <= "0000000000000001";
			Sop1 <= "0000000011111111";
			
			WAIT FOR 50 ns;
			ASSERT Soutput = "1111111100000000" REPORT "Erreur3" SEVERITY error;
		
			-- Test de la multiplication
			Scode_op <= "011";
			Sop1 <= "0000000000000001";
			Sop2 <= "0000000000000010";
			
			WAIT FOR 50 ns;
			ASSERT Soutput = "0000000000000010" REPORT "Erreur4" SEVERITY error;
			
			-- Test de la multiplication 2
			Scode_op <= "011";
			Sop1 <= "0000000000000010";
			Sop2 <= "0000000000000010";
			
			WAIT FOR 50 ns;
			ASSERT Soutput = "0000000000000100" REPORT "Erreur5" SEVERITY error;
		
		WAIT;
	END PROCESS;
	
end architecture alu_test_bench;
