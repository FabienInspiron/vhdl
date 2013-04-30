library IEEE;
use IEEE.numeric_bit.all;

architecture testbench_decode of testbench is
	component decode
		port(rd_if_de             : in  unsigned(3 downto 0);
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
			 rd_de_ex             : out unsigned(3 downto 0);
			 r_w_de_ex            : out bit;
			 en_reg_file_de_ex    : out bit;
			 sel_mem_mux_de_ex    : out bit;
			 sel_alu_mux_de_ex    : out unsigned(1 downto 0);
			 code_alu_de_ex       : out unsigned(2 downto 0);
			 data_out_valid_de_ex : out bit;
			 data_in_ack          : out bit;
			 data_im_de_ex        : out unsigned(15 downto 0);
			 val_rs1_de_ex        : out unsigned(15 downto 0);
			 val_rs2_de_ex        : out unsigned(15 downto 0));
	end component decode;
	
	signal Srd_if_de             : unsigned(3 downto 0);
	signal Scode_op              : unsigned(3 downto 0);
	signal Srs1_if_de            : unsigned(3 downto 0);
	signal Srs2_if_de            : unsigned(3 downto 0);
	signal Sdata_im_if_de        : unsigned(7 downto 0);
	signal Sen_reg_file_mem_wb   : bit;
	signal Srd_mem_wb            : unsigned(3 downto 0);
	signal Sdata_in_valid        : bit;
	signal Sport_entre           : unsigned(15 downto 0);
	signal Sdata_mem_wb          : unsigned(15 downto 0);
	signal Sclk                  : bit;
	signal Ssel_adr_mux_de_if    : bit;
	signal Sincr_decr_de_if      : bit;
	signal Srd_de_ex             : unsigned(3 downto 0);
	signal Sr_w_de_ex            : bit;
	signal Sen_reg_file_de_ex    : bit;
	signal Ssel_mem_mux_de_ex    : bit;
	signal Ssel_alu_mux_de_ex    :  unsigned(1 downto 0);
	signal Scode_alu_de_ex       :  unsigned(2 downto 0);
	signal Sdata_out_valid_de_ex : bit;
	signal Sdata_in_ack          : bit;
	signal Sdata_im_de_ex        : unsigned(15 downto 0);
	signal Sval_rs1_de_ex        : unsigned(15 downto 0);
	signal Sval_rs2_de_ex        : unsigned(15 downto 0);
	
begin
	
	deco : decode
		port map(rd_if_de             => Srd_if_de,
			     code_op              => Scode_op,
			     rs1_if_de            => Srs1_if_de,
			     rs2_if_de            => Srs2_if_de,
			     data_im_if_de        => Sdata_im_if_de,
			     en_reg_file_mem_wb   => Sen_reg_file_mem_wb,
			     rd_mem_wb            => Srd_mem_wb,
			     data_in_valid        => Sdata_in_valid,
			     port_entre           => Sport_entre,
			     data_mem_wb          => Sdata_mem_wb,
			     clk                  => Sclk,
			     sel_adr_mux_de_if    => Ssel_adr_mux_de_if,
			     incr_decr_de_if      => Sincr_decr_de_if,
			     rd_de_ex             => Srd_de_ex,
			     r_w_de_ex            => Sr_w_de_ex,
			     en_reg_file_de_ex    => Sen_reg_file_de_ex,
			     sel_mem_mux_de_ex    => Ssel_mem_mux_de_ex,
			     sel_alu_mux_de_ex    => Ssel_alu_mux_de_ex,
			     code_alu_de_ex       => Scode_alu_de_ex,
			     data_out_valid_de_ex => Sdata_out_valid_de_ex,
			     data_in_ack          => Sdata_in_ack,
			     data_im_de_ex        => Sdata_im_de_ex,
			     val_rs1_de_ex        => Sval_rs1_de_ex,
			     val_rs2_de_ex        => Sval_rs2_de_ex);
			     
	PROCESS
	BEGIN
	
		Scode_op <= "0000";
			
		WAIT FOR 50 ns;
		
		-- Vrerification du WB
		ASSERT Ssel_adr_mux_de_if = '1' REPORT "Erreur" SEVERITY error;
		
		WAIT;
	END PROCESS;		
			
end architecture testbench_decode;
