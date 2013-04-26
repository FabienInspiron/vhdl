library IEEE;
use IEEE.numeric_bit.all;

ENTITY multiplexeur IS
	PORT (	
			sel : IN unsigned   ( 1 downto 0);
			
		  	ent1 : IN unsigned  ( 15 downto 0);
		  	ent2 : IN unsigned  ( 15 downto 0);
		  	ent3 : IN unsigned  ( 15 downto 0);
		  	ent4 : IN unsigned  ( 15 downto 0);
		  	
		  	sort : OUT unsigned ( 15 downto 0)
			);
END multiplexeur;