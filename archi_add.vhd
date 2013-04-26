library IEEE;
use IEEE.numeric_bit.all;

ARCHITECTURE archi_add OF adder IS
	-- signaux locaux = fils
	SIGNAL i1, i2, i3 : bit;
BEGIN
	i1 <= A xor B;
	i3 <= i1 and Cin;
	i2 <= A and B;
	S  <= i1 xor Cin;
	Cy <= i2 or i3;
END archi_add;
