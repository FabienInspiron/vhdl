library IEEE;
use IEEE.numeric_bit.all;

architecture archi_execute of execute is
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

	component alu
		port(code_op : in  unsigned(2 downto 0);
			 op1     : in  unsigned(15 downto 0);
			 op2     : in  unsigned(15 downto 0);
			 output  : out unsigned(15 downto 0));
	end component alu;

	signal alu_to_mux   : unsigned(15 downto 0);
	signal mux_to_reg16 : unsigned(15 downto 0);

	signal sortie_reg7	   : unsigned(7 downto 0);
	signal tmp			   : unsigned(7 downto 0);

begin
	reg16 : registre_n
		generic map(N => 16)
		port map(input   => mux_to_reg16,
			     reset   => '1',
			     horloge => clk,
			     output  => memData);

	reg16_2 : registre_n
		generic map(N => 16)
		port map(input   => mux_to_reg16,
			     reset   => '1',
			     horloge => clk,
			     output  => DataOut);

	reg8 : registre_n
		generic map(N => 8)
		port map(input   => operande1 (7 downto 0),
			     reset   => '1',
			     horloge => clk,
			     output  => memAdress);

	tmp <= (iRD & iWRegFile & iSeIMuxMem & iwrMem & iDataOutValid);
	
	reg7 : registre_n
		generic map(N => 8)
		port map(input  => tmp,
			     reset   => '1',
			     horloge => clk,
			     output  => (sortie_reg7));

	oRD 			<= sortie_reg7(7 downto 4);
	owrRegFile 		<= sortie_reg7(3);
	oselMuxMem 		<= sortie_reg7(2);
	owrMem			<= sortie_reg7(1);
	oDataOutValid 	<= sortie_reg7(0);

	inst_alu : alu
		port map(code_op => codeOp,     
			     op1     => operande1,
			     op2     => operande2,
			     output  => alu_to_mux);

	mult : multiplexeur
		port map(sel  => selMuxALU,
			     ent1 => alu_to_mux,
			     ent2 => operande2,
			     ent3 => ImmediateData,
			     ent4 => ImmediateData,
			     sort => mux_to_reg16);

end architecture archi_execute;