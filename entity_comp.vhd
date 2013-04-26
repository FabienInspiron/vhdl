library IEEE;
use IEEE.numeric_bit.all;

ENTITY comp IS
	PORT(
		val_rs1 : IN  unsigned(15 downto 0);
		
		flagEQ  : OUT bit;
		flagGT  : OUT bit
	);
END comp;
