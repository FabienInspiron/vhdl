library IEEE;
use IEEE.numeric_bit.all;

architecture testbench_processeur of testbench is
	
	component processeur
		port(Port_entree    : in  unsigned(15 downto 0);
			 data_in_valid  : in  bit;
			 RESET          : in  bit;
			 clock          : in  bit;
			 adresse        : in  unsigned(7 downto 0);
			 load           : in  bit;
			 stall          : in  bit;
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
			     load           => Sload,
			     stall          => Sstall,
			     
			     Port_sortie    => SPort_sortie,
			     data_out_valid => Sdata_out_valid,
			     data_in_ack    => Sdata_in_ack);
	
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
	
	PROCESS
		BEGIN
			Sadresse <= "00000000";
			Sload  <= '1';
			Sstall <= '0';
			SRESET <= '1';
			
		WAIT;
	END PROCESS;
	
	
end architecture testbench_processeur;
