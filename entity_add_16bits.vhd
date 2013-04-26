library IEEE;
use IEEE.numeric_bit.all;

ENTITY add_16 IS
	PORT (	
			input0 : IN unsigned  ( 15 downto 0);
		  	input1 : IN unsigned  ( 15 downto 0);
		  	carin  : IN bit;
		  	output : OUT unsigned ( 15 downto 0);
		  	carout : OUT bit
		  );
END add_16;