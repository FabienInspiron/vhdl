library IEEE;
use IEEE.numeric_bit.all;

architecture testbench_extension of testbench is
	
	component extension_signe
		port(input  : in  unsigned(7 downto 0);
			 output : out unsigned(15 downto 0));
	end component extension_signe;
	
	signal Sinput :unsigned(7 downto 0);
	signal Soutput : unsigned(15 downto 0);
	
begin
	
	ext : extension_signe
		port map(input  => Sinput,
			     output => Soutput);
			     
	PROCESS
		BEGIN
			-- Extension du 0
			Sinput <= "00000000";
			WAIT FOR 100 ns;
			ASSERT Soutput = "0000000000000000" REPORT "Erreur1" SEVERITY error;
			
			-- Extension du 1
			Sinput <= "10000000";
			WAIT FOR 100 ns;
			ASSERT Soutput = "1111111110000000" REPORT "Erreur2" SEVERITY error;
			
			-- Extension du 1
			Sinput <= "11111111";
			WAIT FOR 100 ns;
			ASSERT Soutput = "1111111111111111" REPORT "Erreur3" SEVERITY error;
		
			-- Extension du 0
			Sinput <= "01111111";
			WAIT FOR 100 ns;
			ASSERT Soutput = "0000000001111111" REPORT "Erreur4" SEVERITY error;
			
		WAIT;
	END PROCESS;
	
end architecture testbench_extension;
