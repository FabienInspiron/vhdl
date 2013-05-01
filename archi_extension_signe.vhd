library IEEE;
use IEEE.numeric_bit.all;

architecture archi_extension_signe of extension_signe is
	
begin

process (input)

	begin
	IF input(7) = '1' then
		output <= "11111111" & input;
	else
		output <= "00000000" & input;
	end if;
	
	end process;
end architecture archi_extension_signe;
