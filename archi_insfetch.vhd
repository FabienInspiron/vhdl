library IEEE;
use IEEE.numeric_bit.all;

architecture archi_inst_fetch of instruction_fetch is

	-- Inclusion du registre 16 bits
	--
	component registre_n
		generic(N : integer := 16);
		port(input   : IN  unsigned(N - 1 downto 0);
			 reset   : IN  bit;
			 horloge : in  bit;
			 output  : OUT unsigned(N - 1 downto 0));
	end component registre_n;

	-- Inclusion du instruction memory
	--
	component instruction_memory
		port(address     : in  unsigned (7 downto 0);
			 instruction : out unsigned (15 downto 0));
	end component instruction_memory;

	-- Inclusion du programme counter
	--
	component program_counter
		port(clk    : in  bit;
			 input  : in  unsigned(7 downto 0);
			 load   : in  bit;
			 stall  : in  bit;
			 reset  : in  bit;
			 output : out unsigned(7 downto 0));
	end component program_counter;

	-- Création des cables de liaison
	SIGNAL sig  : unsigned(7 downto 0);
	SIGNAL sig2 : unsigned(15 downto 0);

begin

	-- Instanciation des entitées
	--

	-- Program counter
	pc : program_counter
		port map(clk    => clock,
			     input  => sig,         -- Entré depuis le PC
			     load   => load,
			     stall  => stall,
			     reset  => reset,
			     output => sig);        -- Sortie vers Instruction memory

	-- Instruction memory
	instmem : instruction_memory
		port map(address     => sig,    -- entré depuis PC
			     instruction => sig2);  -- sortie vers instruction register

	-- Registre 16 bits
	reg : registre_n
		generic map(N => 16)
		port map(input   => sig2,
			     reset   => reset,
			     horloge => clock,
			     output  => instruction);

END archi_inst_fetch;
