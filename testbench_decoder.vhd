library IEEE;
use IEEE.numeric_bit.all;

architecture testbench_decoder of testbench is
	
	component decoder
		port(code_op        : IN  unsigned(3 downto 0);
			 flagEQ         : IN  bit;
			 flagGT         : IN  bit;
			 data_in_valid  : in  bit;
			 data_in_ack    : out bit;
			 incr_decr      : out bit;
			 sel_mux_data   : out bit;
			 code_alu       : OUT unsigned(2 downto 0);
			 r_w            : OUT bit;
			 en_reg_file    : OUT bit;
			 sel_alu_mux    : OUT unsigned(1 downto 0);
			 sel_mem_mux    : OUT bit;
			 sel_mux_rs1    : OUT bit;
			 sel_adr_mux    : OUT bit;
			 data_out_valid : OUT bit);
	end component decoder;
	
	 signal Scode_op        : unsigned(3 downto 0);
	 signal SflagEQ         : bit;
	 signal SflagGT         : bit; 
	 signal Sdata_in_valid  : bit;
	 signal Sdata_in_ack    : bit;
	 signal Sincr_decr      : bit;
	 signal Ssel_mux_data   : bit;
	 signal Scode_alu       : unsigned(2 downto 0);
	 signal Sr_w            : bit;
	 signal Sen_reg_file    : bit;
	 signal Ssel_alu_mux    : unsigned(1 downto 0);
	 signal Ssel_mem_mux    : bit;
	 signal Ssel_mux_rs1    : bit;
	 signal Ssel_adr_mux    : bit;
	 signal Sdata_out_valid : bit;
	
begin

	dec : decoder
		port map(code_op        => Scode_op,
			     flagEQ         => SflagEQ,
			     flagGT         => SflagGT,
			     
			     data_in_valid  => Sdata_in_valid,
			     data_in_ack    => Sdata_in_ack,
			     incr_decr      => Sincr_decr,
			     sel_mux_data   => Ssel_mux_data,
			     code_alu       => scode_alu,
			     r_w            => Sr_w,
			     en_reg_file    => Sen_reg_file,
			     sel_alu_mux    => Ssel_alu_mux,
			     sel_mem_mux    => Ssel_mem_mux,
			     sel_mux_rs1    => Ssel_mux_rs1,
			     sel_adr_mux    => Ssel_adr_mux,
			     data_out_valid => Sdata_out_valid);
	
	PROCESS
	BEGIN
	
		Scode_op <= "0000";
		SflagEQ <='0';
		SflagGT <= '0';
			
		WAIT FOR 50 ns;
		
		-- Vrerification du WB
		ASSERT Sen_reg_file = '1' REPORT "Erreur" SEVERITY error;
		
	WAIT;
END PROCESS;
	
end architecture testbench_decoder;
