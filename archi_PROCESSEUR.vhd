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
	
		
begin
	
	instru : instruction_fetch
		port map(input       => input,
			     load        => load,
			     clock       => clock,
			     stall       => stall,
			     reset       => reset,
			     instruction => instruction);
			     
	dec : decode
		port map(rd_if_de             => rd_if_de,
			     code_op              => code_op,
			     rs1_if_de            => rs1_if_de,
			     rs2_if_de            => rs2_if_de,
			     data_im_if_de        => data_im_if_de,
			     en_reg_file_mem_wb   => en_reg_file_mem_wb,
			     rd_mem_wb            => rd_mem_wb,
			     data_in_valid        => data_in_valid,
			     port_entre           => port_entre,
			     data_mem_wb          => data_mem_wb,
			     clk                  => clk,
			     sel_adr_mux_de_if    => Ssel_adr_mux_de_if,
			     incr_decr_de_if      => incr_decr_de_if,
			     rd_de_ex             => Srd_de_ex,
			     r_w_de_ex            => Sr_w_de_ex,
			     en_reg_file_de_ex    => Sen_reg_file_de_ex,
			     sel_mem_mux_de_ex    => sel_mem_mux_de_ex,
			     sel_alu_mux_de_ex    => sel_alu_mux_de_ex,
			     code_alu_de_ex       => code_alu_de_ex,
			     data_out_valid_de_ex => data_out_valid_de_ex,
			     data_in_ack          => data_in_ack,
			     data_im_de_ex        => data_im_de_ex,
			     val_rs1_de_ex        => val_rs1_de_ex,
			     val_rs2_de_ex        => val_rs2_de_ex);
	
	exec : execute
		port map(iRD           => Srd_de_ex,
			     iWRegFile     => Sr_w_de_ex,
			     iSeIMuxMem    => iSeIMuxMem,
			     iWrMem        => iWrMem,
			     selMuxALU     => selMuxALU,
			     codeOp        => codeOp,
			     operande1     => operande1,
			     operande2     => operande2,
			     ImmediateData => ImmediateData,
			     iDataOutValid => iDataOutValid,
			     clk           => clk,
			     oRD           => oRD,
			     owrRegFile    => owrRegFile,
			     oselMuxMem    => oselMuxMem,
			     owrMem        => owrMem,
			     memAdress     => memAdress,
			     memData       => memData,
			     DataOut       => DataOut,
			     oDataOutValid => oDataOutValid);
			     
	mem : memory_access
		port map(i_rd          => i_rd,
			     i_wrRegFile   => i_wrRegFile,
			     i_selMuxMem   => i_selMuxMem,
			     i_wr_mem      => i_wr_mem,
			     adresse       => adresse,
			     data          => data,
			     clk           => clk,
			     o_rd          => o_rd,
			     o_wr_regFile  => o_wr_regFile,
			     dataWriteBack => dataWriteBack);
			     
end architecture processeur_archi;
