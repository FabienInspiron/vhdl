library IEEE;
use IEEE.numeric_bit.all;

architecture processeur_archi of processeur is
	
	component instruction_fetch
		port(input       : in  unsigned(7 downto 0);
			 load        : in  bit;
			 clock       : in  bit;
			 stall       : in  bit;
			 reset       : in  bit;
			 instruction : out unsigned(15 downto 0));
	end component instruction_fetch;
	
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
	
	component execute
		port(iRD           : in  unsigned(3 downto 0);
			 iWRegFile     : in  bit;
			 iSeIMuxMem    : in  bit;
			 iWrMem        : in  bit;
			 selMuxALU     : in  unsigned(1 downto 0);
			 codeOp        : in  unsigned(2 downto 0);
			 operande1     : in  unsigned(15 downto 0);
			 operande2     : in  unsigned(15 downto 0);
			 ImmediateData : in  unsigned(15 downto 0);
			 iDataOutValid : in  bit;
			 clk           : in  bit;
			 oRD           : out unsigned(3 downto 0);
			 owrRegFile    : out bit;
			 oselMuxMem    : out bit;
			 owrMem        : out bit;
			 memAdress     : out unsigned(7 downto 0);
			 memData       : out unsigned(15 downto 0);
			 DataOut       : out unsigned(15 downto 0);
			 oDataOutValid : out bit);
	end component execute;
	
	component memory_access
		port(i_rd          : in  unsigned(3 downto 0);
			 i_wrRegFile   : in  bit;
			 i_selMuxMem   : in  bit;
			 i_wr_mem      : in  bit;
			 adresse       : in  unsigned(7 downto 0);
			 data          : in  unsigned(15 downto 0);
			 clk           : in  bit;
			 o_rd          : out unsigned(3 downto 0);
			 o_wr_regFile  : out bit;
			 dataWriteBack : out unsigned(15 downto 0));
	end component memory_access;
	
	signal Ssel_adr_mux_de_if : bit;
	signal Srd_de_ex : unsigned (3 downto 0);
	signal Sr_w_de_ex : bit;
	signal Sen_reg_file_de_ex : bit;
	signal infetch_to_decode : unsigned (15 downto 0);
	
		
	signal code_op_if_de :unsigned (3 downto 0);
	signal rd_if_de : unsigned (3 downto 0);
	signal rs1_if_de : unsigned (3 downto 0);
	signal rs2_if_de : unsigned  (3 downto 0);
	signal data_im_if_de : unsigned (7 downto 0);
	
	signal op1 : unsigned (15 downto 0);
	signal op2 : unsigned (15 downto 0);
	signal Sen_reg_file_mem_wb : bit;
	signal Srd_mem_wb : unsigned (3 downto 0);
	signal Sdata_mem_wb : unsigned (15 downto 0);
	signal Sdata_ex_mem : unsigned (15 downto 0);
	signal Sadr_ex_mem : unsigned (7 downto 0);
	signal Ssel_mem_mux_de_ex : bit;
	signal Ssel_alu_mux_de_ex : unsigned(1 downto 0);
	signal Sd_ex_mem : unsigned (3 downto 0);
	signal Ssel_mem_mux_ex_mem : bit;
	signal SowrRegFile : bit;
	signal Sr_w_ex_mem : bit;
	signal Sdata_out_valid_de_ex : bit;
	signal Sdata_im_de_ex : unsigned(15 downto 0);
	signal Scode_alu_de_ex : unsigned(2 downto 0);
	
	-- A completer
	signal Sincr_decr_de_if : bit;
	
begin
	
	instru : instruction_fetch
		port map(input       => adresse,
			     load        => load,
			     clock       => clock,
			     stall       => stall,
			     reset       => reset,
			     instruction => infetch_to_decode);
			     
	-- Affectation des valeurs de sortie    
	code_op_if_de <= infetch_to_decode (3 downto 0);
	rd_if_de <= infetch_to_decode (7 downto 4);
	rs1_if_de <= infetch_to_decode (11 downto 8);
	rs2_if_de <= infetch_to_decode (15 downto 12);
	data_im_if_de <= infetch_to_decode (15 downto 8);
			     
	dec : decode
		port map(rd_if_de            => rd_if_de,
			     code_op              => code_op_if_de,
			     rs1_if_de            => rs1_if_de,
			     rs2_if_de            => rs2_if_de,
			     data_im_if_de        => data_im_if_de,
			     
			     en_reg_file_mem_wb   => Sen_reg_file_mem_wb,
			     rd_mem_wb            => Srd_mem_wb,
			     data_in_valid        => data_in_valid,
			     port_entre           => Port_entree,
			     
			     data_mem_wb          => Sdata_mem_wb,
			     
			     clk                  => clock,
			     
			     sel_adr_mux_de_if    => Ssel_adr_mux_de_if,
			     incr_decr_de_if      => Sincr_decr_de_if,
			     rd_de_ex             => Srd_de_ex,
			     r_w_de_ex            => Sr_w_de_ex,
			     en_reg_file_de_ex    => Sen_reg_file_de_ex,
			     
			     sel_mem_mux_de_ex    => Ssel_mem_mux_de_ex,
			     sel_alu_mux_de_ex    => Ssel_alu_mux_de_ex,
			     code_alu_de_ex       => Scode_alu_de_ex,
			     data_out_valid_de_ex => Sdata_out_valid_de_ex,
			     data_in_ack          => data_in_ack,
			     data_im_de_ex        => Sdata_im_de_ex,
			     
			     val_rs1_de_ex        => op1,
			     val_rs2_de_ex        => op2);
	
	exec : execute
		port map(iRD           => Srd_de_ex,
			     iWRegFile     => Sen_reg_file_de_ex,
			     
			     iSeIMuxMem    => Ssel_mem_mux_de_ex,
			     iWrMem        => Sr_w_de_ex,
			     
			     selMuxALU     => Ssel_alu_mux_de_ex,
			     codeOp        => Scode_alu_de_ex,
			     
			     operande1     => op1,
			     operande2     => op2,
			     
			     ImmediateData => Sdata_im_de_ex,
			     iDataOutValid => Sdata_out_valid_de_ex,
			     
			     clk           => clock,
			     
			     oRD           => Sd_ex_mem,
			     owrRegFile    => SowrRegFile,
			     oselMuxMem    => Ssel_mem_mux_ex_mem,
			     owrMem        => Sr_w_ex_mem,
			     memAdress     => Sadr_ex_mem,
			     memData       => Sdata_ex_mem,
			     DataOut       => Port_sortie,
			     oDataOutValid => data_out_valid);
			     
	mem : memory_access
		port map(i_rd          => Sd_ex_mem,
			     i_wrRegFile   => SowrRegFile,
			     i_selMuxMem   => Ssel_mem_mux_ex_mem,
			     i_wr_mem      => Sr_w_ex_mem,
			     adresse       => Sadr_ex_mem,
			     data          => Sdata_ex_mem,
			     
			     clk           => clock,
			     
			     o_rd          => Srd_mem_wb,
			     o_wr_regFile  => Sen_reg_file_mem_wb,
			     dataWriteBack => Sdata_mem_wb);
			     
end architecture processeur_archi;
