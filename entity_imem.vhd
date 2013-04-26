library IEEE;
use IEEE.numeric_bit.all;

entity instruction_memory is
	port(
	  address : in unsigned(7 downto 0);
	  instruction : out unsigned(15 downto 0)
	);
end instruction_memory;
