library IEEE;
use IEEE.numeric_bit.all;

ENTITY halfAdder IS
	PORT (	A,B : IN bit;
			S,Cy : OUT bit);
END halfAdder;
