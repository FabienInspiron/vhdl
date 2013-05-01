library IEEE;
use IEEE.numeric_bit.all;

entity processeur is
	port (
		Port_entree : in  unsigned(15 downto 0);
		Port_sortie : OUT  unsigned(15 downto 0);
		RESET : in bit
	);
end entity processeur;
