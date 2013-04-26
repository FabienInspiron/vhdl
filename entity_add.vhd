library IEEE;
use IEEE.numeric_bit.all;

ENTITY adder IS
	PORT(A, B, Cin : IN  bit;
		 S, Cy     : OUT bit);
END adder;
