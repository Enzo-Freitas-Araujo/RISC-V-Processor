LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY HazardDetectionUnit IS
	PORT(
		IF_ID_Instruction : IN STD_LOGIC_VECTOR(31 downto 0);
		
		Branch_ID         : IN STD_LOGIC;
		
		ID_EX_MemRead     : IN STD_LOGIC;
		ID_EX_RegWrite    : IN STD_LOGIC;
		ID_EX_Instruction  : IN STD_LOGIC_VECTOR(31 downto 0);
		
		PCWrite           : OUT STD_LOGIC;
		IF_ID_Write       : OUT STD_LOGIC;
		ControlMux        : OUT STD_LOGIC
	);
END HazardDetectionUnit;

ARCHITECTURE behavioral OF HazardDetectionUnit IS
	SIGNAL ID_EX_RegisterRd : STD_LOGIC_VECTOR(4 downto 0);
	SIGNAL IF_ID_Rs1 : STD_LOGIC_VECTOR(4 downto 0);
	SIGNAL IF_ID_Rs2 : STD_LOGIC_VECTOR(4 downto 0);
BEGIN
	ID_EX_RegisterRd <= ID_EX_Instruction(11 downto 7);
	IF_ID_Rs1 <= IF_ID_Instruction(19 downto 15);
	IF_ID_Rs2 <= IF_ID_Instruction(24 downto 20);
	
	PROCESS(IF_ID_Rs1, IF_ID_Rs2, Branch_ID, 
	        ID_EX_MemRead, ID_EX_RegWrite, ID_EX_RegisterRd)
		
		VARIABLE stall_load_use : BOOLEAN;
		VARIABLE stall_branch   : BOOLEAN;
		
	BEGIN
		stall_load_use := (ID_EX_MemRead = '1') AND 
		                  (ID_EX_RegisterRd /= "00000") AND 
		                  ((ID_EX_RegisterRd = IF_ID_Rs1) OR (ID_EX_RegisterRd = IF_ID_Rs2));

		stall_branch := (Branch_ID = '1') AND (
			((ID_EX_RegWrite = '1') AND (ID_EX_RegisterRd /= "00000") AND 
			 ((ID_EX_RegisterRd = IF_ID_Rs1) OR (ID_EX_RegisterRd = IF_ID_Rs2))));

		IF stall_load_use OR stall_branch THEN
			PCWrite     <= '0'; -- Congela o Program Counter (PC)
			IF_ID_Write <= '0'; -- Congela o Registrador IF/ID
			ControlMux  <= '1'; -- Injeta Bolha/NOP no registrador ID/EX
		ELSE
			PCWrite     <= '1'; -- Fluxo normal de execução
			IF_ID_Write <= '1';
			ControlMux  <= '0';
		END IF;
		
	END PROCESS;
END behavioral;