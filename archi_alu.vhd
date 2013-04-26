library IEEE;
use IEEE.numeric_bit.all;

architecture archi_alu of alu is
	
begin

	association : with code_op select
		output <=
			op1 + op2 when "000", -- addition
			op1 - op2 when "001", -- soustraction
			not(op1) when "010",  -- not
			resize(op1*op2, 16) when "011", -- multiplication
			op1 when others;
			
end architecture archi_alu;
