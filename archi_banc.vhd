library IEEE;
use IEEE.numeric_bit.all;

architecture archi_banc of banc is
	
	TYPE MyTableOfRegistre IS ARRAY (0 to 15) OF unsigned(15 downto 0);
	
begin
	
	PROCESS(clk, Adresse_ecriture, Adresse_lecture1, Adresse_lecture2)
		variable Adresse_ecriture_int : integer;
		variable Adresse_lecture1_int : integer;
		variable Adresse_lecture2_int : integer;
		VARIABLE mem_data : MyTableOfRegistre := ("0000000000000000", others => "0000000000000000");
		
	begin
		Adresse_ecriture_int := to_integer(Adresse_ecriture);
		Adresse_lecture1_int := to_integer(Adresse_lecture1);
		Adresse_lecture2_int := to_integer(Adresse_lecture2);
		
		if clk'event AND clk='1' THEN
			if r_w = '1' then
				mem_data(Adresse_ecriture_int) := data;
			end if;
		ELSIF clk'event AND clk ='0' then
			output1 <= mem_data(Adresse_lecture1_int);
			output2 <= mem_data(Adresse_lecture2_int);
		end if;
	
	END PROCESS;
	
end architecture archi_banc;
