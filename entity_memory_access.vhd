library IEEE;
use IEEE.numeric_bit.all;

entity memory_access is
	port (
		i_rd : in unsigned(3 downto 0);
		i_wrRegFile : in bit;
		i_selMuxMem : in bit;
		i_wr_mem	: in bit;
		
		adresse : in unsigned (7 downto 0);
		data : in unsigned (15 downto 0);
		
		clk : in bit;
		
		o_rd : out unsigned(3 downto 0);
		o_wr_regFile : out bit;
		dataWriteBack : out unsigned (15 downto 0)
	);
	
end entity memory_access;
