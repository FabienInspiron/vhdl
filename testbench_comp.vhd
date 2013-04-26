library IEEE;
use IEEE.numeric_bit.all;

architecture testbench_comp of testbench is
	component comp
		port(val_rs1 : IN  unsigned(15 downto 0);
			 flagEQ  : OUT bit;
			 flagGT  : OUT bit);
	end component comp;
	
	signal Sval_rs1 : unsigned(15 downto 0);
	signal SflagEQ : bit;
	signal SflagGT : bit;
	
begin
	
	compar : comp
		port map(val_rs1 => Sval_rs1,
			     flagEQ  => SflagEQ,
			     flagGT  => SflagGT);
			     
	PROCESS
		BEGIN
			Sval_rs1 <= "0000000000000000";
			WAIT FOR 100 ns;
			ASSERT SflagEQ = '1' REPORT "Erreur1" SEVERITY error;
			ASSERT SflagGT = '0' REPORT "Erreur2" SEVERITY error;

			Sval_rs1 <= "0000000000000001";
			WAIT FOR 100 ns;
			ASSERT SflagEQ = '0' REPORT "Erreur3" SEVERITY error;
			ASSERT SflagGT = '1' REPORT "Erreur4" SEVERITY error;
			
		WAIT;
	END PROCESS;		   
	
end architecture testbench_comp;
