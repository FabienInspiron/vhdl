library IEEE;
use IEEE.numeric_bit.all;

architecture archi_memory of memory_access is
	component memoire_data
		generic(N : integer := 16);
		port(data    : in  unsigned(15 downto 0);
			 adresse : in  unsigned(7 downto 0);
			 write   : in  bit;
			 output  : out unsigned(15 downto 0));
	end component memoire_data;
	
	component multiplexeur
		port(sel  : IN  unsigned(1 downto 0);
			 ent1 : IN  unsigned(15 downto 0);
			 ent2 : IN  unsigned(15 downto 0);
			 ent3 : IN  unsigned(15 downto 0);
			 ent4 : IN  unsigned(15 downto 0);
			 sort : OUT unsigned(15 downto 0));
	end component multiplexeur;
	
	component registre_n
		generic(N : integer := 16);
		port(input   : IN  unsigned(N - 1 downto 0);
			 reset   : IN  bit;
			 horloge : in  bit;
			 output  : OUT unsigned(N - 1 downto 0));
	end component registre_n;
	
	signal mem_data_to_mux : unsigned(15 downto 0);
	signal from_mux_to_reg : unsigned(15 downto 0);
	signal tmp_read : unsigned (4 downto 0);
	signal tmp_out : unsigned (4 downto 0);
	signal tmp : unsigned (1 downto 0);
	
begin

	mem_data : memoire_data
		generic map(N => 8)
		port map(data    => data,
			     adresse => adresse,
			     write   => i_wr_mem,
			     output  => mem_data_to_mux);
			     
	tmp_read <= i_rd & i_wrRegFile;
	
	reg5 : registre_n
		generic map(N => 5)
		port map(input   => tmp_read,
			     reset   => '1',
			     horloge => clk,
			     output  => tmp_out);
			     
	o_rd <= tmp_out(4 downto 1);
	o_wr_regFile <= tmp_out(0);
	
	tmp <= "0"&i_selMuxMem;
	
	mux : multiplexeur
		port map(sel  => tmp,
			     ent1 => mem_data_to_mux,
			     ent2 => data,
			     ent3 => data,
			     ent4 => data,
			     sort => from_mux_to_reg);
			     
	reg16 : registre_n
		generic map(N => 16)
		port map(input   => from_mux_to_reg,
			     reset   => '1',
			     horloge => clk,
			     output  => dataWriteBack);
			     
end architecture archi_memory;
