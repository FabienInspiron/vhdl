library IEEE;
use IEEE.numeric_bit.all;

ARCHITECTURE archi_multiplexeur OF multiplexeur IS
	
BEGIN
	sort <= ent1 WHEN (sel='0') ElSE
			ent2 WHEN (sel='1') ELSE
			ent3 WHEN (sel="10") ELSE
			ent4 WHEN (sel="11");
	
END archi_multiplexeur;
