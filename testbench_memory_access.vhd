library IEEE;
use IEEE.numeric_bit.all;

architecture testbench_mem_acc of testbench is
	component memory_access
		port(i_rd          : in  unsigned(3 downto 0);
			 i_wrRegFile   : in  bit;
			 i_selMuxMem   : in  bit;
			 i_wr_mem      : in  bit;
			 adresse       : in  unsigned(7 downto 0);
			 data          : in  unsigned(15 downto 0);
			 clk           : in  bit;
			 o_rd          : out unsigned(3 downto 0);
			 o_wr_regFile  : out bit;
			 dataWriteBack : out unsigned(15 downto 0));
	end component memory_access;
	
	signal Si_rd         : unsigned(3 downto 0);
	signal Si_wrRegFile  : bit;
	signal Si_selMuxMem  : bit;
	signal Si_wr_mem     : bit;
	signal Sadresse      : unsigned(7 downto 0);
	signal Sdata         : unsigned(15 downto 0);
	signal Sclk          : bit;
	signal So_rd         : unsigned(3 downto 0);
	signal So_wr_regFile : bit;
	signal SdataWriteBack :  unsigned(15 downto 0); 
	
begin

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
	
	mem : memory_access
		port map(i_rd          => Si_rd,
			     i_wrRegFile   => Si_wrRegFile,
			     i_selMuxMem   => Si_selMuxMem,
			     i_wr_mem      => Si_wr_mem,
			     adresse       => Sadresse,
			     data          => Sdata,
			     clk           => Sclk,
			     o_rd          => So_rd,
			     o_wr_regFile  => So_wr_regFile,
			     dataWriteBack => SdataWriteBack);
	
	Si_rd <=  "0001";      
	Si_wrRegFile <= '1';
	Si_selMuxMem <= '1';
	Si_wr_mem  <= '1';
	Sadresse <= "00000001";   
	Sdata   <=  "0101010101010101";
	
end architecture testbench_mem_acc;
