library IEEE;
use IEEE.numeric_bit.all;

entity processeur is
	port (
		Port_entree : in  unsigned(15 downto 0);
		data_in_valid : in bit;
		
		Port_sortie : OUT  unsigned(15 downto 0);
		data_out_valid : bit;
		
		
		RESET : in bit;
		
		-- Tous les étages seront cadancés avec la même horloge
		clock : in bit
	);
end entity processeur;
