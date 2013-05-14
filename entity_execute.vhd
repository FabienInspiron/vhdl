library IEEE;
use IEEE.numeric_bit.all;

entity execute is
	port (
		iRD 		: in unsigned (3 downto 0);
		iWRegFile 	: in bit;
		iSeIMuxMem	: in bit;
		iWrMem		: in bit;
		selMuxALU	: in unsigned (1 downto 0);
		codeOp		: in unsigned (2 downto 0);
		operande1	: in unsigned (15 downto 0);
		operande2 	: in unsigned (15 downto 0);
		ImmediateData : in unsigned (15 downto 0);
		iDataOutValid : in bit;
		clk 		  : in bit;
		
		oRD			: out unsigned (3 downto 0);
		owrRegFile	: out bit;
		oselMuxMem	: out bit;
		owrMem		: out bit;
		memAdress 	: out unsigned (7 downto 0);
		memData		: out unsigned (15 downto 0);
		
		-- Sortie à l'exterieure du processeur
		DataOut		: out unsigned (15 downto 0);
		oDataOutValid : out bit
	);
	
end entity execute;
