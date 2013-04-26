library IEEE;
use IEEE.numeric_bit.all;

ARCHITECTURE architecture_add16 OF add_16 IS
	COMPONENT adder IS
		PORT(a, b, cin : IN  bit;
			 s, cy     : OUT bit);
	END COMPONENT;
	
	SIGNAL sig : unsigned (16 downto 0);
	
BEGIN
	-- Création du premier additionneur
	adder1 : adder
		PORT MAP(input0(0), input1(0), carin, output(0), sig(1));

	boucleGenerate : FOR i IN 1 TO 15 GENERATE
		adders : adder
			PORT MAP(input0(i),input1(i),sig(i),output(i),sig(i + 1));
	END GENERATE boucleGenerate;

	-- Mettre la cable dans la sortie	
	carout <= sig(16);

END architecture_add16;