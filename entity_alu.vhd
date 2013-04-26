library IEEE;
use IEEE.numeric_bit.all;

entity alu is
	port (
		code_op : in unsigned (2 downto 0); -- 3 bits pour le code op
		op1		: in unsigned (15 downto 0); -- 16 octets pour op1
		op2		: in unsigned (15 downto 0); -- 16 octets pour op2
		output	: out unsigned (15 downto 0) 
	);
end entity alu;
