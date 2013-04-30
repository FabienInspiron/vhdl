library IEEE;
use IEEE.numeric_bit.all;

architecture archi_decode of decode is
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

	component comp
		port(val_rs1 : IN  unsigned(15 downto 0);
			 flagEQ  : OUT bit;
			 flagGT  : OUT bit);
	end component comp;

	component registre_n
		generic(N : integer := 16);
		port(input   : IN  unsigned(N - 1 downto 0);
			 reset   : IN  bit;
			 horloge : in  bit;
			 output  : OUT unsigned(N - 1 downto 0));
	end component registre_n;

	component multiplexeur
		port(sel  : IN  unsigned(1 downto 0);
			 ent1 : IN  unsigned(15 downto 0);
			 ent2 : IN  unsigned(15 downto 0);
			 ent3 : IN  unsigned(15 downto 0);
			 ent4 : IN  unsigned(15 downto 0);
			 sort : OUT unsigned(15 downto 0));
	end component multiplexeur;

	component multiplexeur_2
		port(sel  : IN  bit;
			 ent1 : IN  unsigned(15 downto 0);
			 ent2 : IN  unsigned(15 downto 0);
			 sort : OUT unsigned(15 downto 0));
	end component multiplexeur_2;

	component extension_signe
		port(input  : in  unsigned(7 downto 0);
			 output : out unsigned(15 downto 0));
	end component extension_signe;

	component banc
		port(clk             : in  bit;
			 Adresse_ecriture : in  unsigned(3 downto 0);
			 Adresse_lecture1 : in  unsigned(3 downto 0);
			 Adresse_lecture2 : in  unsigned(3 downto 0);
			 data             : in  unsigned(15 downto 0);
			 r_w              : in  bit;
			 output1          : out unsigned(15 downto 0);
			 output2          : out unsigned(15 downto 0));
	end component banc;

	signal comp_to_decoder_EQ             : bit;
	signal comp_to_decoder_GT             : bit;
	signal registre_file_to_comp          : unsigned(15 downto 0);
	signal from_registre_file_to_registre : unsigned(15 downto 0);
	signal from_signe_exp_to_mux          : unsigned(15 downto 0);
	signal from_sortie_multi_to_reg       : unsigned(15 downto 0);
	signal from_decodeur_to_mux           : bit;
	signal from_mux_to_register_file      : unsigned(3 downto 0);
	signal from_decoder_to_mux_rs1		: bit;
	signal signaux_to_execute			: unsigned(12 downto 0);
	signal register_to_execute			: unsigned(12 downto 0);
	
	signal Scode_alu : unsigned(2 downto 0);
	signal Sr_w : bit;
	signal Sen_reg_file :bit;
	signal Ssel_alu_mux : unsigned (1 downto 0);
	signal Ssel_mem_mux :bit;
	signal Sdata_out_valid :bit;
	
	signal convert1 : unsigned(15 downto 0);
	signal convert2 : unsigned(15 downto 0);
	signal convert3 : unsigned(15 downto 0);

begin
	comparator : comp
		port map(val_rs1 => registre_file_to_comp,
			     flagEQ  => comp_to_decoder_EQ,
			     flagGT  => comp_to_decoder_GT);

	registre_file : banc
		port map(clk              => clk,
			     Adresse_ecriture => rd_mem_wb,
			     Adresse_lecture1 => from_mux_to_register_file,
			     Adresse_lecture2 => rs2_if_de,
			     data             => data_mem_wb,
			     r_w              => en_reg_file_mem_wb,
			     output1          => registre_file_to_comp,
			     output2          => from_registre_file_to_registre);

	signe_ext : extension_signe
		port map(input  => data_im_if_de,
			     output => from_signe_exp_to_mux);

	-- Multiplexeur de séléction du port d'entré
	mux1 : multiplexeur_2
		port map(sel  => from_decodeur_to_mux,
			     ent1 => from_signe_exp_to_mux,
			     ent2 => port_entre,
			     sort => from_sortie_multi_to_reg);

	registre1 : registre_n
		generic map(N => 16)
		port map(input   => registre_file_to_comp,
			     reset   => '1',
			     horloge => clk,
			     output  => val_rs1_de_ex
		);

	registre2 : registre_n
		generic map(N => 16)
		port map(input   => from_registre_file_to_registre,
			     reset   => '1',
			     horloge => clk,
			     output  => val_rs2_de_ex
		);

	registre3 : registre_n
		generic map(N => 16)
		port map(input   => from_sortie_multi_to_reg,
			     reset   => '1',
			     horloge => clk,
			     output  => data_im_de_ex
		);

	decod : decoder
		port map(code_op        => code_op,
			     flagEQ         => comp_to_decoder_EQ,
			     flagGT         => comp_to_decoder_GT,
			     data_in_valid  => data_in_valid,
			     data_in_ack    => data_in_ack,
			     incr_decr      => incr_decr_de_if,
			     sel_mux_data   => from_decodeur_to_mux,
			     code_alu       => Scode_alu,
			     r_w            => Sr_w,
			     en_reg_file    => Sen_reg_file,
			     sel_alu_mux    => Ssel_alu_mux,
			     sel_mem_mux    => Ssel_mem_mux,
			     sel_mux_rs1    => from_decoder_to_mux_rs1,
			     sel_adr_mux    => sel_adr_mux_de_if,
			     data_out_valid => Sdata_out_valid);

	signaux_to_execute <= rd_if_de & Scode_alu & Sr_w & Sen_reg_file & Ssel_alu_mux & Ssel_mem_mux & Sdata_out_valid;
	
	registre_10 : registre_n
		generic map(N => 13)
		port map(input   => signaux_to_execute,
			     reset   => '1',
			     horloge => clk,
			     output  => register_to_execute);
			     
	rd_de_ex <= register_to_execute(12 downto 9);
	code_alu_de_ex <= register_to_execute(8 downto 6);
	r_w_de_ex <= register_to_execute(5);
	en_reg_file_de_ex <= register_to_execute(4);
	sel_alu_mux_de_ex <= register_to_execute(3 downto 2);
	sel_mem_mux_de_ex <= register_to_execute(1);
	data_out_valid_de_ex <= register_to_execute(0);

	convert1 <= ("000000000000" & rd_if_de);
	convert2 <= ("000000000000" & rs1_if_de);
	
	mux2 : multiplexeur_2
		port map(sel  => from_decoder_to_mux_rs1,
			     ent1 => convert1,
			     ent2 => convert2,
			     sort => convert3);
			     
	from_mux_to_register_file <= convert3(3 downto 0);

end architecture archi_decode;
