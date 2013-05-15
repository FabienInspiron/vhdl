library IEEE;
use IEEE.numeric_bit.all;

architecture pc_testbench of testbench is
	component program_counter
		port(clk    : in  bit;
			 input  : in  unsigned(7 downto 0);
			 load   : in  bit;
			 stall  : in  bit;
			 reset  : in  bit;
			 output : out unsigned(7 downto 0));
	end component program_counter;

	signal Sclk    : bit;
	signal Sinput  : unsigned(7 downto 0);
	signal Sload   : bit;
	signal Sreset  : bit;
	signal Sstall  : bit;
	signal Soutput : unsigned(7 downto 0);

begin
	dut : program_counter
		port map(clk    => Sclk,
			     input  => Sinput,
			     load   => Sload,
			     stall  => Sstall,
			     reset  => Sreset,
			     output => Soutput);

	-- Generation d'une horloge
	horloge : PROCESS                   -- signal périodique
	BEGIN                               -- exécution séquentielle dans le corps
		boucle : FOR i IN 0 TO 10 LOOP
			Sclk <= '1';
			WAIT FOR 50 ns; 
			
			Sclk <= '0';
			WAIT FOR 50 ns; 
		END LOOP boucle;
		wait;
	END PROCESS;

	process
	BEGIN
		-- Faire un reset
		Sinput <= "00000100";
		Sload  <= '1';
		Sreset <= '0';
		Sstall <= '1';

		WAIT FOR 50 ns;
		ASSERT Soutput = "00000000" REPORT "Erreur1" SEVERITY error;

		-- Faire un load
		Sinput <= "00000001";
		Sload  <= '0';
		Sreset <= '1';
		Sstall <= '1';

		WAIT FOR 150 ns;
		ASSERT Soutput = "00000001" REPORT "Erreur2" SEVERITY error;

		-- Faire un stall
		Sinput <= "00011111";
		Sload  <= '1';
		Sstall <= '0';
		WAIT FOR 0 ns;
		ASSERT Soutput = "00000001" REPORT "Erreur3" SEVERITY error;

		-- Verifier que la valeur n'est pas modifiée
		WAIT FOR 100 ns;
		ASSERT Soutput = "00000001" REPORT "Erreur4" SEVERITY error;

		Sstall <= '1';
		
		-- Verification d'incrementation de la valeur
		WAIT FOR 101 ns;
		ASSERT Soutput = "00000010" REPORT "Erreur5" SEVERITY error;

		wait;
	end process;

end architecture pc_testbench;