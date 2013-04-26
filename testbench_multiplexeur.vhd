library IEEE;
use IEEE.numeric_bit.all;

ARCHITECTURE multiplexeur_text_bench OF testbench IS
-- décldéclare le composant à utiliser

component multiplexeur
	port(sel  : IN  unsigned(1 downto 0);
		 ent1 : IN  unsigned(15 downto 0);
		 ent2 : IN  unsigned(15 downto 0);
		 ent3 : IN  unsigned(15 downto 0);
		 ent4 : IN  unsigned(15 downto 0);
		 sort : OUT unsigned(15 downto 0));
end component multiplexeur;

SIGNAL Ssel : unsigned   ( 1  downto 0);
SIGNAL Sent1 : unsigned  ( 15 downto 0);
SIGNAL Sent2 : unsigned  ( 15 downto 0);
SIGNAL Sent3 : unsigned  ( 15 downto 0);
SIGNAL Sent4 : unsigned  ( 15 downto 0);
SIGNAL Ssort : unsigned  ( 15 downto 0);

BEGIN
	-- instanciation de composants
	dut : multiplexeur
	PORT MAP(Ssel, Sent1, Sent2,Sent3,Sent4,Ssort);

PROCESS
	BEGIN
	Sent1 <= "0000000011111111";
	Sent2 <= "0000000010111111";
	Sent3 <= "0000000011011111";
	Sent4 <= "0000000011110111";
	
	Ssel  <= "00"; 
	WAIT FOR 50 ns;
	ASSERT Ssort = "0000000011111111" REPORT "Erreur1" SEVERITY error;
		
	Ssel  <= "01"; 
	WAIT FOR 50 ns;
	ASSERT Ssort = "0000000010111111" REPORT "Erreur2" SEVERITY error;
	
	Ssel  <= "10"; 
	WAIT FOR 50 ns;
	ASSERT Ssort = "0000000011011111" REPORT "Erreur3" SEVERITY error;
	
	Ssel  <= "11"; 	
	WAIT FOR 50 ns;
	ASSERT Ssort = "0000000011110111" REPORT "Erreur4" SEVERITY error;
		
	WAIT;
END PROCESS;

END multiplexeur_text_bench;