library IEEE;
use IEEE.numeric_bit.all;

architecture reg_testbench of testbench is

	-- Importation du composant registre
	--
	component registre_n
		generic(N : integer := 16);
		port(input   : IN  unsigned(N - 1 downto 0);
			 reset   : IN  bit;
			 horloge : in  bit;
			 output  : OUT unsigned(N - 1 downto 0));
	end component registre_n;
	
	signal Sinput : unsigned (15 downto 0);
	signal Sreset : bit;
	signal Shorloge : bit;
	signal Soutput : unsigned (15 downto 0);
	
begin

	dut : registre_n
		generic map(N => 16)
		port map(Sinput,Sreset,Shorloge,Soutput);
	
		-- Generation d'une horloge
	horloge : PROCESS                   -- signal périodique
	BEGIN                               -- exécution séquentielle dans le corps
		boucle : FOR i IN 0 TO 10 LOOP
			Shorloge <= '1';
			WAIT FOR 50 ns; 
			
			Shorloge <= '0';
			WAIT FOR 50 ns; 
		END LOOP boucle;
		wait;
	END PROCESS;
	
	process
	BEGIN
		Sinput <= "1111000011110000";
		Sreset  <= '1';

		WAIT FOR 51 ns;
		ASSERT Soutput = "1111000011110000" REPORT "Erreur1" SEVERITY error;
		
		Sreset  <= '1';
		WAIT FOR 50 ns;
		ASSERT Soutput = "1111000011110000" REPORT "Erreur2" SEVERITY error;
		
		Sinput <= "1111111100000000";
		Sreset  <= '1';
		WAIT FOR 100 ns;
		ASSERT Soutput = "1111111100000000" REPORT "Erreur3" SEVERITY error;
		
		Sreset  <= '1';
		WAIT FOR 100 ns;
		ASSERT Soutput = "1111111100000000" REPORT "Erreur4" SEVERITY error;
		
		Sreset <= '0';
		WAIT FOR 100 ns;
		ASSERT Soutput = "0000000000000000" REPORT "Erreur5" SEVERITY error;
		
		wait;
	end process;
	
end architecture reg_testbench;
