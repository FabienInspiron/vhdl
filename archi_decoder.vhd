library IEEE;
use IEEE.numeric_bit.all;

architecture archi_decoder of decoder is

	signal s1 : bit;

begin
	sel_mux_rs1 <= '0' WHEN (code_op="0111") OR (code_op="1000")
						ELSE '1';

	-- Code pour l'alu
	--
	code_alu <= "000" WHEN (code_op="0000") ELSE -- addition
				"001" WHEN (code_op="0001") ELSE -- soustraction
				"011" WHEN (code_op="0010") ELSE -- mult
				"010" WHEN (code_op="1100") ; -- not

	-- Choix entre la donnée immediate et le port d'entrée
	sel_mux_data <= '1' WHEN (code_op="1101") ELSE '0'; -- in			

	sel_mux_rs1 <= '0' WHEN (code_op = "0111") OR 	     -- BEQ
							(code_op = "1000") ELSE	'1'; -- BGT

	s1 <= '0';		
	data_out_valid <= '1' WHEN (code_op = "1011") ELSE '0';
	-- Attention ------ remettre a 0 ensuite
	data_out_valid <= s1;

	data_in_ack <= '1' WHEN (data_in_valid = '1') AND (code_op="1101") ELSE '0';

	-- On decrement PC pour entendre une donnée en entrée
	incr_decr <= '0' WHEN (data_in_valid = '0') AND (code_op="1101") ELSE '1';

	-- Si on decide de lire les données provenant de la mémoire
	-- Se fait uniquement lors d'un LD ou STORE
	sel_mem_mux <= '0' WHEN (code_op = "0101") OR (code_op="0011") ELSE '1';

	-- cas du JUMP
	sel_adr_mux <= '0' WHEN (code_op = "0110") ELSE
						'0' WHEN (code_op = "0111") AND (flagEQ = '1') ELSE
						'0' WHEN (code_op = "1000") AnD (flagGT = '1')
						ELSE '1';

	-- Donne le droit d'ecrire dans le register file lors du wb
	en_reg_file <= '1'  WHEN (code_op = "0000") OR -- add
						 (code_op = "0001") OR --sub
						 (code_op = "1100") OR --not
						 (code_op = "0010") OR --mul
						 (code_op = "0101") OR --ld
						 (code_op = "1001") OR --movi
						 (code_op = "0100") OR -- mov
						 (code_op = "1101") ELSE '0'; --in

	r_w <= '0' WHEN (code_op = "0011") ELSE '1'; -- store

	-- Code pour sel_alu_mux
	-- Il faut faire le choix entre valeur immédiate,
	-- operande2 ou resultat de l'alu
	sel_alu_mux <= 
					-- On choisi l'alu lors d'un 
					-- add, sub, not,mul.
					"00" WHEN (code_op="0000") OR --add
							 (code_op="0001") OR -- sub
							 (code_op="1100") OR -- NOT
							 (code_op="0010") ELSE -- mul

				   "10" WHEN (code_op="1001") OR (code_op ="1101" )ELSE -- MOVI valeur immediate
				   "01" WHEN (code_op="0100") OR (code_op="1011") ; -- MOV ou OUT pour ne prendre que RS2

end architecture archi_decoder;