library IEEE;
use IEEE.numeric_bit.all;

-- Cette entité recoit en entrée une adresse
-- et retourne un l'instruction se trouvant 
-- a cette valeur
entity instruction_fetch is
	port(
		input       : in  unsigned(7 downto 0);
		load        : in  bit;
		clock       : in  bit;
		stall       : in  bit;
		reset       : in  bit;
		
		instruction : out unsigned(15 downto 0)
	);
end instruction_fetch;
