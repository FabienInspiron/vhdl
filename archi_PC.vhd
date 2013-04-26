library IEEE;
use IEEE.numeric_bit.all;

architecture archi_pc of program_counter is

-- Signal mémoire
signal save : unsigned (7 downto 0);

begin
			     
	PROCESS (clk, reset)
	BEGIN
	
		IF reset = '0' THEN
			save <= (others => '0');
			output <= (others => '0');
			
		ELSIF clk'event AND clk='1' THEN
			if load='0' then
				output <= input;
				save <= input;
			else
				-- Le stall ne fait rien, l'adresse de sortie n'est
				-- pas modifiée
			if stall='0' then
				output <= save;
			end if;
			end if;
		ELSE
			save <= save + 1;
		END IF;
	
	END PROCESS;
	
end archi_pc;
