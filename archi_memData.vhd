library IEEE;
use IEEE.numeric_bit.all;

ARCHITECTURE archi_memeData OF memoire_data IS

	TYPE liste_data IS array (0 to N) of unsigned (15 downto 0);
	
BEGIN                                   --
	process(adresse, write)
	VARIABLE mem_data : liste_data := ("0000000000000000", others => "0000000000000000");
	VARIABLE int_adr : integer;
	
		begin
			-- Conversion obligatoire de l'adresse en entier
			int_adr := to_integer(adresse);
			
			IF (write = '1') THEN
				output <= mem_data(int_adr);
			elsif write = '0' then
				mem_data(int_adr) := data;
			END IF;
	end process;
END archi_memeData;
