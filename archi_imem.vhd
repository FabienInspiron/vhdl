library IEEE;
use IEEE.numeric_bit.all;

ARCHITECTURE behavior_instruction_memory OF instruction_memory IS
  type instruction_list IS ARRAY (0 to 63) OF unsigned(15 downto 0);
BEGIN
  process(address)
    VARIABLE instructions : instruction_list := (
    -- Mise en place des valeurs dans les registres
    "0000000000001010",   --0   nop
    "0000000101011001",   --1   movi r5,#1
    "0000001000001001",   --2   movi r0,#2
    "0000010000011001",   --3   movi r1,#4
    "0000000000001010",   --4   nop
    "0000000000001010",   --5   nop
    
    -- Verification des valeurs
    "0000000000001011",   --6   out r0  r0=2 [1]
    "0001000000001011",   --7   out r1  r1=4 [2]
    "0101000000001011",   --8   out r5  r5=1 [3]
    
    -- Test de la soustraction
    "0101000000000001",   --9   sub r0,r0,r5   r0=1 
    -- Temps pour le WB
    "0000000000001010",   --10   nop
    "0000000000001010",   --11   nop
    "0000000000001010",   --12   nop
    "0000000000001011",   --13   out r0  r0=1 [4]
    
    -- Test du store
    "0001000100000011",   --14   st  r1,[r1] store à l'adresse 4
    "0001010100100000",   --15   add r2,r5,r1   r2=5
    "0000000000001010",   --16   nop
    "0000000000001010",   --17   nop
    "0000000000001010",   --18   nop
    "0010000000001011",   --19   out r2  r2=5 [5]
    "0001000000001011",   --20   out r1  r1=4 [6]
        
    -- Test du load et affichage de la valeur
    "0000000100110101",   --21   ld r4, [r1]
    "0000000000001010",   --22   nop
    "0000000000001010",   --23   nop
    "0000000000001010",   --24   nop
    "0011000000001011",   --25   out r3  r3=4 [7]
    
    -- Test du branchement
    "0000000000001010",   --26   nop
    "0000111000000111",   --27   beq r0,14 r0=1

	-- Le branchement n'a pas lieux, donc multiplication
    "0000000101100010",   --28   mul r6,r1,r0 r6=4
    "0000000000001010",   --29   nop
    "0000000000001010",   --30   nop
    "0000000000001010",   --31   nop
    "0001011001100000",   --32   add r6,r6,r1   r6=8
    "0000000000001010",   --33   nop
    "0000000000001010",   --34   nop
    "0000000000001010",   --35   nop
    "0110000000001011",   --36   out r6  r6=8 [8]
    
    -- Test du MOVI
    "0000101001111001",   --37   movi r7, #10
    "0000000000001010",   --38   nop
    "0000000000001010",   --39   nop
    "0000000000001010",   --40   nop
    "0111000000001011",   --41   out r7  r7=10 [9]

	-- Test du BEQ
	"0000000010001001",   --42   movi r8, #0
    "0000000000001010",   --43   nop
    "0000000000001010",   --44   nop
    "0000000000001010",   --45   nop
    "0011000010000111",   --46   beq r8,48 r8=0
    
    "0000000000001010",   --47   nop
    "0000000000001010",   --48   nop
    
    -- branchement inconditionel
    "0000001100000110",   --49   jmp 4
    "0000000000001010",   --48   nop
    "0111000000001011",   --49   out r7  r7=10 [10]
    
    -- Instruction jamais executée
    "0000000000001010",   --50   nop
    "0000000100000110",   --51   jmp 1
    "0000000000001010",   --52   nop
    
    others => "0000000000001010"   --   nop
    );
    
  begin
	 instruction <= instructions(to_integer(unsigned(address)));

  end process;
  
END behavior_instruction_memory;