library IEEE;
use IEEE.numeric_bit.all;

entity decode is
	port(
		rd_if_de             : in  unsigned(3 downto 0);
		code_op              : in  unsigned(3 downto 0);
		rs1_if_de            : in  unsigned(3 downto 0);
		rs2_if_de            : in  unsigned(3 downto 0);
		data_im_if_de        : in  unsigned(7 downto 0);
		en_reg_file_mem_wb   : in  bit;
		rd_mem_wb            : in  unsigned(3 downto 0);
		data_in_valid        : in  bit;
		port_entre           : in  unsigned(15 downto 0);
		data_mem_wb          : in  unsigned(15 downto 0);
		clk                  : in  bit;

		sel_adr_mux_de_if    : out bit;
		incr_decr_de_if      : out bit;
		rd_de_ex             : out unsigned (3 downto 0);
		r_w_de_ex            : out bit;
		en_reg_file_de_ex    : out bit;
		sel_mem_mux_de_ex    : out bit;
		sel_alu_mux_de_ex    : out unsigned (1 downto 0);
		code_alu_de_ex       : out unsigned (2 downto 0);
		data_out_valid_de_ex : out bit;
		data_in_ack          : out bit;
		data_im_de_ex        : out unsigned(15 downto 0);
		val_rs1_de_ex        : out unsigned(15 downto 0);
		val_rs2_de_ex        : out unsigned(15 downto 0)
	);

end entity decode;
