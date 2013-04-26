library IEEE;
use IEEE.numeric_bit.all;

ENTITY decoder IS
	PORT(
		 -- depuis instruction
		code_op        : IN  unsigned (3 downto 0);

		-- issu du comparateur
		flagEQ         : IN  bit;
		
		-- issu du comparateur
		flagGT         : IN  bit;
		
		data_in_valid  : in  bit;
		-- Indique donnée sur port entrée est valide
		
		data_in_ack    : out bit;
		-- Indique que donnée sur port entrée a été lue
		
		incr_decr      : out bit;
		-- incrémentation ou décrementation du PC
		
		sel_mux_data   : out bit;
		-- selection valeur immediate ou port entrée
		
		-- code pour ALU
		code_alu       : OUT unsigned (2 downto 0); 

		-- ecriture data memory
		r_w            : OUT bit; 

		-- autorisation ecriture register file
		en_reg_file    : OUT bit; 

		-- selection
		sel_alu_mux    : OUT unsigned(1 downto 0); 
		
		-- donnee sortie etage EX
		-- selection donnee en sortie etage WB
		sel_mem_mux    : OUT bit; 
		sel_mux_rs1    : OUT bit;
		
		-- selection numero rs1 a l’entree du reg_file
		sel_adr_mux    : OUT bit;
		
		-- selection adresse prochaine instr.
		data_out_valid : OUT bit  -- la donnée sur le port de sortie est valide
	);
	
END decoder;
