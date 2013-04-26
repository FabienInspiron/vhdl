library IEEE;
use IEEE.numeric_bit.all;

entity program_counter is
	port (
		clk : 		in bit;
		input : 	in unsigned (7 downto 0);
		load : 		in bit;
		stall : 	in bit;
		reset : 	in bit;
		
		output : 	out unsigned (7 downto 0)
	);
end entity program_counter;
