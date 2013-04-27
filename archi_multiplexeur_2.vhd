library IEEE;
use IEEE.numeric_bit.all;

ARCHITECTURE archi_multiplexeur_2 OF multiplexeur_2 IS
	
BEGIN
	sort <= ent1 WHEN (sel="00") ElSE
			ent2 WHEN (sel="01") ;
	
END archi_multiplexeur_2;
