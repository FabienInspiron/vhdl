library IEEE;
use IEEE.numeric_bit.all;

architecture archi_decoder of decoder is
	
	signal s1 : bit;
	variable ADD  : unsigned(3 downto 0) := "0000";
	variable SUB  : unsigned(3 downto 0) := "0001";
	variable vNOT : unsigned(3 downto 0) := "1100";
	variable MUL  : unsigned(3 downto 0) := "0010";
	variable JMP  : unsigned(3 downto 0) := "0110";
	variable BEQ  : unsigned(3 downto 0) := "0111";
	variable BGT  : unsigned(3 downto 0) := "1000";
	variable LD   : unsigned(3 downto 0) := "0101";
	variable MOVI : unsigned(3 downto 0) := "1001";
	variable ST   : unsigned(3 downto 0) := "0011";
	variable NOP  : unsigned(3 downto 0) := "1010";
	variable MOV  : unsigned(3 downto 0) := "0100";
	variable vIN  : unsigned(3 downto 0) := "1101";
	variable vOUT : unsigned(3 downto 0) := "1011";
	
begin

	
	sel_mux_rs1 <=  '0' WHEN (code_op=BEQ) OR (code_op=BGT)
					ELSE '1';
						
	-- Code pour l'alu
	--
	code_alu <= "000" WHEN (code_op=ADD) ELSE -- addition
				"001" WHEN (code_op=SUB) ELSE -- soustraction
				"011" WHEN (code_op=MUL) ELSE -- mult
				"010" WHEN (code_op=vNOT) ; -- not
				
	-- Choix entre la donnée immediate et le port d'entrée
	sel_mux_data <= '1' WHEN (code_op=vIN) ELSE '0'; -- in			
	
	sel_mux_rs1 <= '0' WHEN (code_op = BEQ) OR 	     -- BEQ
							(code_op = BGT) ELSE	'1'; -- BGT
	
	s1 <= '0';		
	data_out_valid <= '1' WHEN (code_op = vOUT) ELSE '0';
	-- Attention ------ remettre a 0 ensuite, au prochain tour
	data_out_valid <= s1;

	data_in_ack <= '1' WHEN (data_in_valid = '1') AND (code_op=vIN) ELSE '0';
	
	-- On decrement PC pour entendre une donnée en entrée
	incr_decr <= '0' WHEN (data_in_valid = '0') AND (code_op=vIN) ELSE '1';
					
	-- Si on decide de lire les données provenant de la mémoire
	-- Se fait uniquement lors d'un LD ou STORE
	sel_mem_mux <= '0' WHEN (code_op = LD) OR (code_op=ST) ELSE '1';
	
	-- cas du JUMP
	sel_adr_mux <= '0' WHEN (code_op = JMP) ELSE
						'0' WHEN (code_op = BEQ) AND (flagEQ = '1') ELSE
						'0' WHEN (code_op = BGT) AnD (flagGT = '1')
						ELSE '1';
	
	-- Donne le droit d'ecrire dans le register file lors du wb
	en_reg_file <= '1'  WHEN (code_op = ADD) OR -- add
						 (code_op = SUB) OR --sub
						 (code_op = vNOT) OR --not
						 (code_op = MUL) OR --mul
						 (code_op = LD) OR --ld
						 (code_op = MOVI) OR --movi
						 (code_op = MOV) OR -- mov
						 (code_op = vIN) ELSE '0'; --in
	
	r_w <= '0' WHEN (code_op = ST) ELSE '1'; -- store
	
	-- Code pour sel_alu_mux
	-- Il faut faire le choix entre valeur immédiate,
	-- operande2 ou resultat de l'alu
	sel_alu_mux <= 
					-- On choisi l'alu lors d'un 
					-- add, sub, not,mul.
					"00" WHEN (code_op=ADD) OR --add
							 (code_op=SUB) OR -- sub
							 (code_op=vNOT) OR -- NOT
							 (code_op=MUL) ELSE -- mul
				   
				   "10" WHEN (code_op=MOVI) OR (code_op =vIN )ELSE -- MOVI valeur immediate
				   "01" WHEN (code_op=MOV) OR (code_op=vOUT) ; -- MOV ou OUT pour ne prendre que RS2
	
	
end architecture archi_decoder;
