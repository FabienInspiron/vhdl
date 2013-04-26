library IEEE;
use IEEE.numeric_bit.all;

architecture execute_testbench of testbench is
	
	component execute
		port(iRD           : in  unsigned(3 downto 0);
			 iWRegFile     : in  bit;
			 iSeIMuxMem    : in  bit;
			 iWrMem        : in  bit;
			 selMuxALU     : in  unsigned(1 downto 0);
			 codeOp        : in  unsigned(2 downto 0);
			 operande1     : in  unsigned(15 downto 0);
			 operande2     : in  unsigned(15 downto 0);
			 ImmediateData : in  unsigned(15 downto 0);
			 iDataOutValid : in  bit;
			 clk           : in  bit;
			 
			 oRD           : out unsigned(3 downto 0);
			 owrRegFile    : out bit;
			 oselMuxMem    : out bit;
			 owrMem        : out bit;
			 memAdress     : out unsigned(7 downto 0);
			 memData       : out unsigned(15 downto 0);
			 DataOut       : out unsigned(15 downto 0);
			 oDataOutValid : out bit);
	end component execute;
	
	signal 		 SiRD           :  unsigned(3 downto 0);
	signal		 SiWRegFile     :  bit;
	signal		 SiSeIMuxMem    :  bit;
	signal	 	 SiWrMem        :  bit;
	signal		 SselMuxALU     :  unsigned(1 downto 0);
	signal		 ScodeOp        :  unsigned(2 downto 0);
	signal		 Soperande1     :   unsigned(15 downto 0);
	signal		 Soperande2     :   unsigned(15 downto 0);
	signal		 SImmediateData :   unsigned(15 downto 0);
	signal		 SiDataOutValid :   bit;
	signal		 Sclk           :   bit;
	signal		 SoRD           :  unsigned(3 downto 0);
	signal		 SowrRegFile    :  bit;
	signal		 SoselMuxMem    :  bit;
	signal		 SowrMem        :  bit;
	signal		 SmemAdress     :  unsigned(7 downto 0);
	signal		 SmemData       :  unsigned(15 downto 0);
	signal		 SDataOut       :  unsigned(15 downto 0);
	signal		 SoDataOutValid :  bit;
	
begin
	
	dut : execute
		port map(iRD          => SiRD,
			     iWRegFile     => SiWRegFile,
			     iSeIMuxMem    => SiSeIMuxMem,
			     iWrMem        => SiWrMem,
			     selMuxALU     => SselMuxALU,
			     codeOp        => ScodeOp,
			     operande1     => Soperande1,
			     operande2     => Soperande2,
			     ImmediateData => SImmediateData,
			     iDataOutValid => SiDataOutValid,
			     clk           => Sclk,
			     
			     oRD           => SoRD,
			     owrRegFile    => SowrRegFile,
			     oselMuxMem    => SoselMuxMem,
			     owrMem        => SowrMem,
			     memAdress     => SmemAdress,
			     memData       => SmemData,
			     DataOut       => SDataOut,
			     oDataOutValid => SoDataOutValid);
	
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
	
	PROCESS
		BEGIN
			Soperande1      <= "0000000000000010";
	        Soperande2      <= "0000000000000011";
	        ScodeOp         <= "001";
	        SselMuxALU      <= "01";
	        SiDataOutValid 	<= '1';
	        SImmediateData  <= "1111111111111111";
	        SiRD           	<= "0001";
	        SiWRegFile    	<= '1';
	        SiSeIMuxMem    	<= '1';
	        SiWrMem        	<= '1';
		WAIT;
	END PROCESS;
	
end architecture execute_testbench;
