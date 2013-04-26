library IEEE;
use IEEE.numeric_bit.all;

entity extension_signe is
	port (
		input : in unsigned (7 downto 0);
		output : out unsigned (15 downto 0)
	);
	
end entity extension_signe;
