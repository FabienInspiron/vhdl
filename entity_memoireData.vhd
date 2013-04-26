library IEEE;
use IEEE.numeric_bit.all;

entity memoire_data is
	generic(N : integer :=16);
	port (
		data : in unsigned(15 downto 0);
		adresse : in unsigned(7 downto 0);
		write	: in bit;
		
		output : out unsigned(15 downto 0)
	);
end entity memoire_data;
