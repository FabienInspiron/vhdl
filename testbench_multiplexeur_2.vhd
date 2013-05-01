library IEEE;
use IEEE.numeric_bit.all;

ARCHITECTURE multiplexeur_text_bench OF testbench IS
-- décldéclare le composant à utiliser

component multiplexeur_2
	port(sel  : IN  bit;
		 ent1 : IN  unsigned(15 downto 0);
		 ent2 : IN  unsigned(15 downto 0);
		 sort : OUT unsigned(15 downto 0));
end component multiplexeur_2;

SIGNAL Ssel :  bit;
SIGNAL Sent1 : unsigned  ( 15 downto 0);
SIGNAL Sent2 : unsigned  ( 15 downto 0);
SIGNAL Ssort : unsigned  ( 15 downto 0);

BEGIN
	dut : multiplexeur_2
		port map(sel  => Ssel,
			     ent1 => Sent1,
			     ent2 => Sent2,
			     sort => Ssort);

PROCESS
	BEGIN
	Sent1 <= "0000000011111111";
	Sent2 <= "0000000010111111";
	
	Ssel  <= '0'; 
	WAIT FOR 50 ns;
	ASSERT Ssort = "0000000011111111" REPORT "Erreur1" SEVERITY error;
		
	Ssel  <= '1'; 
	WAIT FOR 50 ns;
	ASSERT Ssort = "0000000010111111" REPORT "Erreur2" SEVERITY error;		
	WAIT;
END PROCESS;

END multiplexeur_text_bench;