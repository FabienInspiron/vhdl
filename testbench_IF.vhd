library IEEE;
use IEEE.numeric_bit.all;

architecture testbench_IF of testbench is
	
	component instruction_fetch
		port(input       : in  unsigned(7 downto 0);
			 load        : in  bit;
			 clock       : in  bit;
			 stall       : in  bit;
			 reset       : in  bit;
			 instruction : out unsigned(15 downto 0));
	end component instruction_fetch;

	signal Sinput : unsigned(7 downto 0);      
	signal	Sload  : bit;
	signal	Sclock : bit;      
	signal	Sstall : bit;      
	signal	Sreset  : bit;     
	signal	Sinstruction : unsigned(15 downto 0);
	
begin
	horloge : PROCESS                   -- signal périodique
	BEGIN                               -- exécution séquentielle dans le corps
		boucle : FOR i IN 0 TO 10 LOOP
			Sclock <= '1';
			WAIT FOR 50 ns; 
			
			Sclock <= '0';
			WAIT FOR 50 ns; 
		END LOOP boucle;
		wait;
	END PROCESS;
	
	dut : instruction_fetch
		port map(input       => Sinput,
			     load        => Sload,
			     clock       => Sclock,
			     stall       => Sstall,
			     reset       => Sreset,
			     instruction => Sinstruction);
			     
	PROCESS
	BEGIN
		Sinput <= "00000001";
		Sload  <= '1';
		Sreset <= '1';
		Sstall <= '0';
		
		WAIT FOR 50 ns;
		ASSERT Sinstruction = "0000000000001010" REPORT "Erreur1" SEVERITY error;
	
		WAIT FOR 100 ns;
		ASSERT Sinstruction = "0000000101011001" REPORT "Erreur2" SEVERITY error;
	
		WAIT FOR 100 ns;
		ASSERT Sinstruction = "0000001000001001" REPORT "Erreur3" SEVERITY error;
	
		WAIT FOR 100 ns;
		ASSERT Sinstruction = "0000010000011001" REPORT "Erreur4" SEVERITY error;
	
		Sreset <= '0';
		WAIT FOR 100 ns;
		ASSERT Sinstruction = "0000000000000000" REPORT "Erreur5" SEVERITY error;
	
		Sreset <= '1';
		WAIT FOR 150 ns;
		ASSERT Sinstruction = "0000000000001010" REPORT "Erreur6" SEVERITY error;
		
	WAIT;
	END PROCESS;
	
end architecture ;
