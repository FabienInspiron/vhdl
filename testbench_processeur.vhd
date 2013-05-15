library IEEE;
use IEEE.numeric_bit.all;

architecture testbench_processeur of testbench is
	
	component processeur
		port(Port_entree    : in  unsigned(15 downto 0);
			 data_in_valid  : in  bit;
			 RESET          : in  bit;
			 clock          : in  bit;
			 adresse        : in  unsigned(7 downto 0);
			 Port_sortie    : OUT unsigned(15 downto 0);
			 data_out_valid : out bit;
			 data_in_ack    : out bit);
	end component processeur;
	
	 signal SPort_entree    : unsigned(15 downto 0);
	 signal Sdata_in_valid  : bit;
	 signal SRESET          : bit;
	 signal Sclock          : bit;
	 signal Sadresse        : unsigned(7 downto 0);
	 signal Sload           : bit;
	 signal Sstall          : bit;
	 signal SPort_sortie    : unsigned(15 downto 0);
	 signal Sdata_out_valid : bit;
	 signal Sdata_in_ack    : bit;
	
begin
	proces : processeur
		port map(Port_entree    => SPort_entree,
			     data_in_valid  => Sdata_in_valid,
			     RESET          => SRESET,
			     clock          => Sclock,
			     adresse        => Sadresse,
			     Port_sortie    => SPort_sortie,
			     data_out_valid => Sdata_out_valid,
			     data_in_ack    => Sdata_in_ack);
	
	horloge : PROCESS                   -- signal périodique
	BEGIN                               -- exécution séquentielle dans le corps
		boucle : FOR i IN 0 TO 63 LOOP
			Sclock <= '0';
			WAIT FOR 50 ns; 
			
			Sclock <= '1';
			WAIT FOR 50 ns; 
		END LOOP boucle;
		wait;
	END PROCESS;
	
	PROCESS
		BEGIN
			Sadresse <= "00000000";
			Sload  <= '1';
			Sstall <= '0';
			SRESET <= '1';
			
			-- Verification des valeurs de sortie
			--
			-- [1]
			WAIT FOR 951 ns;
			ASSERT Sdata_out_valid = '1' REPORT "Erreur1" SEVERITY error;
			ASSERT SPort_sortie = "0000000000000010" REPORT "Erreur2" SEVERITY error;
			
			-- [2]
			WAIT FOR 100 ns;
			ASSERT Sdata_out_valid = '1' REPORT "Erreur3" SEVERITY error;
			ASSERT SPort_sortie = "0000000000000100" REPORT "Erreur4" SEVERITY error;
			
			-- [3]
			WAIT FOR 100 ns;
			ASSERT Sdata_out_valid = '1' REPORT "Erreur5" SEVERITY error;
			ASSERT SPort_sortie = "0000000000000001" REPORT "Erreur6" SEVERITY error;
	
			-- [4]
			WAIT FOR 500 ns;
			ASSERT Sdata_out_valid = '1' REPORT "Erreur7" SEVERITY error;
			ASSERT SPort_sortie = "0000000000000001" REPORT "Erreur8" SEVERITY error;

			-- [5]
			WAIT FOR 600 ns;
			ASSERT Sdata_out_valid = '1' REPORT "Erreur9" SEVERITY error;
			ASSERT SPort_sortie = "0000000000000101" REPORT "Erreur10" SEVERITY error;
			
			-- [6]
			WAIT FOR 100 ns;
			ASSERT Sdata_out_valid = '1' REPORT "Erreur9" SEVERITY error;
			ASSERT SPort_sortie = "0000000000000100" REPORT "Erreur10" SEVERITY error;
			
			-- [7]
			WAIT FOR 500 ns;
			ASSERT Sdata_out_valid = '1' REPORT "Erreur9" SEVERITY error;
			ASSERT SPort_sortie = "0000000000000100" REPORT "Erreur10" SEVERITY error;

			-- [8]
			WAIT FOR 1100 ns;
			ASSERT Sdata_out_valid = '1' REPORT "Erreur9" SEVERITY error;
			ASSERT SPort_sortie = "0000000000001000" REPORT "Erreur10" SEVERITY error;
			
			-- [9]
			WAIT FOR 500 ns;
			ASSERT Sdata_out_valid = '1' REPORT "Erreur9" SEVERITY error;
			ASSERT SPort_sortie = "0000000000001010" REPORT "Erreur10" SEVERITY error;
			
			-- test du fonctionnement du JMP
			-- Verification de la valeur de r1
			WAIT FOR 1100 ns;
			ASSERT Sdata_out_valid = '1' REPORT "Erreur9" SEVERITY error;
			ASSERT SPort_sortie = "0000000000000100" REPORT "Erreur10" SEVERITY error;
			
		WAIT;
	END PROCESS;
	
	
end architecture testbench_processeur;
