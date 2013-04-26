library IEEE;
use IEEE.numeric_bit.all;

entity banc is
	port (
		clk : in bit;
		Adresse_ecriture  : in unsigned (3 downto 0);
		Adresse_lecture1  : in unsigned (3 downto 0);
		Adresse_lecture2  : in unsigned (3 downto 0);
		data 			  : in unsigned (15 downto 0);
		r_w 			  : in bit;
		
		output1 : out unsigned (15 downto 0);
		output2 : out unsigned (15 downto 0)
	);
end entity banc;
