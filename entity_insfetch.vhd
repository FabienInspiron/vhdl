library IEEE;
use IEEE.numeric_bit.all;

-- Cette entité recoit en entrée une adresse
-- et retourne un l'instruction se trouvant 
-- a cette valeur
entity instruction_fetch is
	port(
		input       : in  unsigned(7 downto 0);
		load        : in  bit;
		clock       : in  bit;
		stall       : in  bit;
		reset       : in  bit;
		
		sel_adr_mux_de_if : in bit;
		incr_decr_de_if : in bit;
		
		
		rd_if_de : out unsigned (3 downto 0);
		code_op_if_de : out unsigned (3 downto 0);
		rs1_if_de : out unsigned (3 downto 0);
		rs2_if_de : out unsigned (3 downto 0);
		data_im_if_de : out unsigned (7 downto 0);
		
		instruction : out unsigned (15 downto 0)
	);
end instruction_fetch;
