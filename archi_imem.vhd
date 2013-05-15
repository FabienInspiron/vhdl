library IEEE;
use IEEE.numeric_bit.all;

ARCHITECTURE behavior_instruction_memory OF instruction_memory IS
  type instruction_list IS ARRAY (0 to 63) OF unsigned(15 downto 0);
BEGIN
  process(address)
    VARIABLE instructions : instruction_list := (
    -- Mise en place des valeurs dans les registres
    "0000000000001010",   --   nop
    "0000000101011001",   --   movi r5,#1
    "0000001000001001",   --   movi r0,#2
    "0000010000011001",   --   movi r1,#4
    "0000000000001010",   --   nop
    "0000000000001010",   --   nop
    
    -- Verification des valeurs
    "0000000000001011",   --   out r0  r0=2
    "0001000000001011",   --   out r1  r1=4
    "0101000000001011",   --   out r5  r5=1
    
    -- Test de la soustraction
    "0101000000000001",   --   sub r0,r0,r5   r0=1 
    -- Temps pour le WB
    "0000000000001010",   --   nop
    "0000000000001010",   --   nop
    "0000000000001010",   --   nop
    "0000000000001011",   --   out r0  r0=1
    
    -- Test du store
    "0001000100000011",   --   st  r1,[r1] store à l'adresse 4
    "0001010100100000",   --   add r2,r5,r1   r2=5
    "0000000000001010",   --   nop
    "0000000000001010",   --   nop
    "0000000000001010",   --   nop
    "0010000000001011",   --   out r2  r2=5
    "0001000000001011",   --   out r1  r1=4
        
    -- Test du load et affichage de la valeur
    "0000000100110101",   --   ld r4, [r1]
    "0000000000001010",   --   nop
    "0000000000001010",   --   nop
    "0000000000001010",   --   nop
    "0011000000001011",   --   out r3  r3=4
    
    -- Test du branchement
    "0000000000001010",   --   nop
    "0000111000000111",   --   beq r0,14 r0=1

	-- Le branchement n'a pas lieux, donc multiplication
--    "0000000101100010",   --   mul r6,r1,r0 r6=4
--    "0000000000001010",   --   nop
--    "0000000000001010",   --   nop
--    "0000000000001010",   --   nop
--    "0001011001100000",   --   add r6,r6,r1   r6=8
--    "0000000000001010",   --   nop
--    "0000000000001010",   --   nop
--    "0000000000001010",   --   nop
--    "0110000000001011",   --   out r6  r6=4
    
    -- Test du MOVI
    "0000101001111001",   --   movi r7, #10
    "0000000000001010",   --   nop
    "0000000000001010",   --   nop
    "0000000000001010",   --   nop
    "0111000000001011",   --   out r7  r6=4

    -- branchement inconditionel
    "0000010000000110",   --   jmp 4
    
    -- Instruction jamais executée
    "0000000000001010",   --   nop
    "0000000100000110",   --   jmp 1
    "0000000000001010",   --   nop
    
    others => "0000000000001010"   --   nop
    );
    
  begin
	 instruction <= instructions(to_integer(unsigned(address)));

  end process;
  
END behavior_instruction_memory;