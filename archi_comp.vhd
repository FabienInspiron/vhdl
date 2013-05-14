library IEEE;
use IEEE.numeric_bit.all;

architecture archi_comp of comp is
	
begin
	process (val_rs1)
	begin 
		-- Si la veleur est nulle
		IF  val_rs1 = "0000000000000000" then
			flagEQ <= '1';
		else
			flagEQ <= '0';
		end if;
		
		-- Pour les valeurs plus grande que 0
		IF val_rs1 > "0000000000000000" then
			flagGT <= '1';
		else
			flagGT <= '0';
		end if;
		
		-- Pour les valeurs inferieur à 0
		IF val_rs1(15) = '1' then 
			flagEQ <= '0';
			flagGT <= '0';
		end if;
		
	end process;
	
end architecture archi_comp;
