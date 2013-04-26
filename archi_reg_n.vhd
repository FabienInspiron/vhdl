library IEEE;
use IEEE.numeric_bit.all;

ARCHITECTURE archi_registre OF registre_n IS

BEGIN
	PROCESS(horloge, reset)
	BEGIN
		IF horloge'event AND horloge = '0' AND reset = '0' THEN
			output <= (others => '0');
		ElSE
			-- Maintenir le reset
			IF horloge'event AND horloge = '1' and reset = '1' THEN
				output <= input;
			END IF;
		END IF;

	END PROCESS;

END archi_registre;