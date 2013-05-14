library IEEE;
use IEEE.numeric_bit.all;

architecture testbench_banc of testbench is
	
component banc
	port(clk              : in  bit;
		 Adresse_ecriture : in  unsigned(3 downto 0);
		 Adresse_lecture1 : in  unsigned(3 downto 0);
		 Adresse_lecture2 : in  unsigned(3 downto 0);
		 data             : in  unsigned(15 downto 0);
		 r_w              : in  bit;
		 output1          : out unsigned(15 downto 0);
		 output2          : out unsigned(15 downto 0));
end component banc;
	
	signal Sclk : bit;
	signal SAdresse_ecriture : unsigned (3 downto 0);
	signal SAdresse_lecture1 : unsigned (3 downto 0);
	signal SAdresse_lecture2 : unsigned (3 downto 0);
	signal Sdata : unsigned(15 downto 0);
	signal Sr_w : bit;
	signal Soutput1 : unsigned(15 downto 0); 
	signal Soutput2 : unsigned(15 downto 0); 
	
begin
	
	testbanc : banc
		port map(clk              => Sclk,
			     Adresse_ecriture => SAdresse_ecriture,
			     Adresse_lecture1 => SAdresse_lecture1,
			     Adresse_lecture2 => SAdresse_lecture2,
			     data             => Sdata,
			     r_w              => Sr_w,
			     output1          => Soutput1,
			     output2          => Soutput2);
			     
	
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
	begin
	
		SAdresse_ecriture <= "0001";
	    SAdresse_lecture1 <= "0010";
	    SAdresse_lecture2 <= "0011";
	    Sdata <= "0101010101010101";
	    Sr_w <= '1';
	    
	    -- Ecriture de la donnée dans le registre 1
	    -- Les valeurs luent sont alors à 0.
	    -- Attention, on ne peut pas lire et ecrire en même temps.
	    Wait FOR 100 ns;
	    ASSERT Soutput1 = "0000000000000000" REPORT "Erreur1" SEVERITY error;
	    ASSERT Soutput2 = "0000000000000000" REPORT "Erreur2" SEVERITY error;
	   
	    -- Passage en mode lecture
	   	Sr_w <= '0';
	   	
	   	-- Lecture dans le registre 1, la valeur qui vient d'être ecrite
	   	SAdresse_lecture1 <= "0001";
	    Wait FOR 51 ns;
	    
	    -- La valeur de sortie de output 1 est egale à celle ecrite
	    ASSERT Soutput1 = "0101010101010101" REPORT "Erreur3" SEVERITY error;
	    ASSERT Soutput2 = "0000000000000000" REPORT "Erreur4" SEVERITY error;
	   	
	   	-- Ecriture dans le registre 3
	   	Sr_w <= '1';
	   	SAdresse_ecriture <= "0011";
	   	Sdata <= "1111111100000000";
	    Wait FOR 50 ns;
		
		-- Lecture dans le registre 3
	   	SAdresse_lecture2 <= "0011";
	    Wait FOR 50 ns;
	    ASSERT Soutput2 = "1111111100000000" REPORT "Erreur5" SEVERITY error;
		
		
		wait;
	end process;
	
end architecture testbench_banc;
