library IEEE;
use IEEE.numeric_bit.all;

ARCHITECTURE add_16_testbench OF testbench IS
-- décldéclare le composant à utiliser

component add_16
	port(input0 : IN  unsigned(15 downto 0);
		 input1 : IN  unsigned(15 downto 0);
		 carin  : IN  bit;
		 output : OUT unsigned(15 downto 0);
		 carout : OUT bit);
end component add_16;

SIGNAL Sinput0 : unsigned  ( 15 downto 0);
SIGNAL Sinput1 : unsigned  ( 15 downto 0);
SIGNAL Scarin : bit;
SIGNAL Soutput : unsigned  ( 15 downto 0);
SIGNAL Scarout : bit;

BEGIN
	-- instanciation de composants
	dut : add_16
	PORT MAP(Sinput0, Sinput1, Scarin, Soutput,Scarout);

PROCESS
	BEGIN
	Sinput0  <= "0000000000000001";
	Sinput1 <= "0000000000000000";
	Scarin  <= '0';
	WAIT FOR 50 ns;
	
	ASSERT Soutput = "0000000000000001" REPORT "Erreur1" SEVERITY error;
	ASSERT Scarout = '0' 				REPORT "Erreur2" SEVERITY error;
		
	Sinput0  <= "0000000000000001";
	Sinput1 <= "0000000000000000";
	Scarin  <= '1';
	WAIT FOR 50 ns;
	
	ASSERT Soutput = "0000000000000010" REPORT "Erreur3" SEVERITY error;
	ASSERT Scarout = '0' 				REPORT "Erreur4" SEVERITY error;
		
	Sinput0  <= "1111111111111111";
	Sinput1 <= "0000000000000000";
	Scarin  <= '1';
	WAIT FOR 50 ns;
	
	ASSERT Soutput = "0000000000000000" REPORT "Erreur5" SEVERITY error;
	ASSERT Scarout = '1' 				REPORT "Erreur6" SEVERITY error;	
		
	WAIT;
END PROCESS;

END add_16_testbench;