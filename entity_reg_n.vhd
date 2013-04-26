library IEEE;
use IEEE.numeric_bit.all;

ENTITY registre_n IS
	generic(N : integer :=16);
	PORT(input 	  	: IN unsigned (N-1 downto 0);
		 reset 		: IN bit;
		 horloge	: in bit;
		 output    	: OUT unsigned (N-1 downto 0));
		 
END registre_n;