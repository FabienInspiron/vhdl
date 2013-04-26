library IEEE;
use IEEE.numeric_bit.all;

architecture archi_comp of comp is
	
begin
	process (val_rs1)
	begin 
		IF  val_rs1 = "0000000000000000" then
			flagEQ <= '1';
		else
			flagEQ <= '0';
		end if;
		
		IF val_rs1 > "0000000000000000" then
			flagGT <= '1';
		else
			flagGT <= '0';
		end if;
		
	end process;
	
end architecture archi_comp;
