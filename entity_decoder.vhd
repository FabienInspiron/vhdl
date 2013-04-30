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
		
		data_in_valid  : in  bit; --ok
		-- Indique donnée sur port entrée est valide
		
		data_in_ack    : out bit; --ok
		-- Indique que donnée sur port entrée a été lue
		
		incr_decr      : out bit; --ok
		-- incrémentation ou décrementation du PC
		
		sel_mux_data   : out bit; --ok
		-- selection valeur immediate ou port entrée
		
		-- code pour ALU
		code_alu       : OUT unsigned (2 downto 0); --ok

		-- ecriture data memory
		r_w            : OUT bit; --ok

		-- autorisation ecriture register file lors du wb
		en_reg_file    : OUT bit; --ok

		-- selection
		sel_alu_mux    : OUT unsigned(1 downto 0); 
		
		-- donnee sortie etage EX
		-- selection donnee en sortie etage WB
		sel_mem_mux    : OUT bit; --ok
		
		sel_mux_rs1    : OUT bit; --ok
		
		-- selection numero rs1 a
		sel_adr_mux    : OUT bit; --ok
		
		-- selection adresse prochaine instr.
		-- la donnée sur le port de sortie est valide
		data_out_valid : OUT bit  --ok
	);
	
END decoder;
