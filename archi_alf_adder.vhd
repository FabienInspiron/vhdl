library IEEE;
use IEEE.numeric_bit.all;

-- vue interne: flot de données
ARCHITECTURE archi_half OF halfAdder IS
BEGIN
	S <= A xor B;
	Cy <= A and B;
END archi_half;
