library IEEE;
use IEEE.numeric_bit.all;

ENTITY multiplexeur_2 IS
	PORT (	
			sel : IN bit;
			
		  	ent1 : IN unsigned  ( 15 downto 0);
		  	ent2 : IN unsigned  ( 15 downto 0);
		  	
		  	sort : OUT unsigned ( 15 downto 0)
			);
END multiplexeur_2;