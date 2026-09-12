LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY pipelineRegEXMEM IS
	PORT(
		instruction : IN STD_LOGIC_VECTOR(31 downto 0);

		RegWrite : IN STD_LOGIC;
		MemToReg : IN STD_LOGIC;

		memRead : IN STD_LOGIC;
		memWrite : IN STD_LOGIC;
		Branch : IN STD_LOGIC;

		ALU : IN STD_LOGIC_VECTOR(31 downto 0);
		Op2 : IN STD_LOGIC_VECTOR(31 downto 0);
		Zero : IN STD_LOGIC;
		CLK : IN STD_LOGIC;

		instructionOutput : OUT STD_LOGIC_VECTOR(31 downto 0);
		
		RegWriteOut : OUT STD_LOGIC;
		MemToRegOut : OUT STD_LOGIC;
		
		memReadOut : OUT STD_LOGIC;
		memWriteOut : OUT STD_LOGIC;
		BranchOut : OUT STD_LOGIC;
	
		ALUOut : OUT STD_LOGIC_VECTOR(31 downto 0);
		Op2Out : OUT STD_LOGIC_VECTOR(31 downto 0);
		ZeroOUT : OUT STD_LOGIC
	);
END pipelineRegEXMEM;

ARCHITECTURE pipelineRegMEMWB_logic OF pipelineRegEXMEM IS
	BEGIN
	
		PROCESS(CLK)
			BEGIN
				IF RISING_EDGE(CLK) THEN
					instructionOutput <= instruction;

					RegWriteOut <= RegWrite;
					memToRegOut <= memToReg;

					BranchOut <= Branch;
					MemWriteOut <= MemWrite;
					MemReadOut <= MemRead;
					ALUOut <= ALU;
					Op2Out <= Op2;

					ZeroOUT <= zero;
					
				ELSE
					instructionOutput <= instructionOutput;
					RegWriteOut <= RegWriteOut;
					memToRegOut <= memToRegOut;

					BranchOut <= BranchOut;
					MemWriteOut <= MemWriteOut;
					MemReadOut <= MemReadOut;
					ALUOut <= ALUOut;
					Op2Out <= Op2Out;
					ZeroOUT <= ZeroOUT;
					
				END IF;
		END PROCESS;

	END pipelineRegMEMWB_logic;