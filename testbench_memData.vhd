library IEEE;
use IEEE.numeric_bit.all;

architecture mem_data_testbench of testbench is
	
	component memoire_data
		generic(N : integer := 16);
		port(data    : in  unsigned(15 downto 0);
			 adresse : in  unsigned(7 downto 0);
			 write   : in  bit;
			 output  : out unsigned(15 downto 0));
	end component memoire_data;
	
	signal Sdata : unsigned(15 downto 0);
	signal Sadresse : unsigned(7 downto 0);
	signal Swrite : bit;
	signal Soutput  : unsigned(15 downto 0);
	
begin
	mem : memoire_data
		generic map(N => 8)
		port map(data    => Sdata,
			     adresse => Sadresse,
			     write   => Swrite,
			     output  => Soutput);
	PROCESS
		BEGIN
			Sdata <= "0000000000000111";
			Sadresse <= "00000001";
			Swrite <= '0';
			
		WAIT FOR 50 ns;
		ASSERT Soutput = "0000000000000000" REPORT "Erreur1" SEVERITY error;

			Swrite <= '1';
			
		WAIT FOR 50 ns;
		ASSERT Soutput = "0000000000000111" REPORT "Erreur2" SEVERITY error;

			Sdata <= "0000000000111111";
			Sadresse <= "00000011";
			Swrite <= '0';
			
		WAIT FOR 50 ns;
		ASSERT Soutput = "0000000000000111" REPORT "Erreur2" SEVERITY error;

			Swrite <= '1';
			
		WAIT FOR 50 ns;
		ASSERT Soutput = "0000000000111111" REPORT "Erreur2" SEVERITY error;
		
		WAIT;
	END PROCESS;
	
end architecture mem_data_testbench;
