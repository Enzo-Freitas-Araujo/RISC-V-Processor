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

		ALU : IN STD_LOGIC_VECTOR(31 downto 0);
		Op2 : IN STD_LOGIC_VECTOR(31 downto 0);
		CLK : IN STD_LOGIC;
		RESET : IN STD_LOGIC;

		instructionOutput : OUT STD_LOGIC_VECTOR(31 downto 0);
		
		RegWriteOut : OUT STD_LOGIC;
		MemToRegOut : OUT STD_LOGIC;
		
		memReadOut : OUT STD_LOGIC;
		memWriteOut : OUT STD_LOGIC;
	
		ALUOut : OUT STD_LOGIC_VECTOR(31 downto 0);
		Op2Out : OUT STD_LOGIC_VECTOR(31 downto 0)
	);
END pipelineRegEXMEM;

ARCHITECTURE pipelineRegMEMWB_logic OF pipelineRegEXMEM IS
	BEGIN
	
		PROCESS(CLK, RESET)
			BEGIN
				IF RESET = '1' THEN
					instructionOutput <= X"00000000";
					RegWriteOut <= '0';
					memToRegOut <= '0';
					MemWriteOut <= '0';
					MemReadOut <= '0';
					ALUOut <= X"00000000";
					Op2Out <= X"00000000";
				ELSIF RISING_EDGE(CLK) THEN
					instructionOutput <= instruction;

					RegWriteOut <= RegWrite;
					memToRegOut <= memToReg;

					MemWriteOut <= MemWrite;
					MemReadOut <= MemRead;
					ALUOut <= ALU;
					Op2Out <= Op2;
					
				ELSE
					instructionOutput <= instructionOutput;
					RegWriteOut <= RegWriteOut;
					memToRegOut <= memToRegOut;

					MemWriteOut <= MemWriteOut;
					MemReadOut <= MemReadOut;
					ALUOut <= ALUOut;
					Op2Out <= Op2Out;
					
				END IF;
		END PROCESS;

	END pipelineRegMEMWB_logic;LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY pipelineRegEXMEM IS
	PORT(
		instruction : IN STD_LOGIC_VECTOR(31 downto 0);

		RegWrite : IN STD_LOGIC;
		MemToReg : IN STD_LOGIC;

		memRead : IN STD_LOGIC;
		memWrite : IN STD_LOGIC;

		ALU : IN STD_LOGIC_VECTOR(31 downto 0);
		Op2 : IN STD_LOGIC_VECTOR(31 downto 0);
		CLK : IN STD_LOGIC;
		RESET : IN STD_LOGIC;

		instructionOutput : OUT STD_LOGIC_VECTOR(31 downto 0);
		
		RegWriteOut : OUT STD_LOGIC;
		MemToRegOut : OUT STD_LOGIC;
		
		memReadOut : OUT STD_LOGIC;
		memWriteOut : OUT STD_LOGIC;
	
		ALUOut : OUT STD_LOGIC_VECTOR(31 downto 0);
		Op2Out : OUT STD_LOGIC_VECTOR(31 downto 0)
	);
END pipelineRegEXMEM;

ARCHITECTURE pipelineRegMEMWB_logic OF pipelineRegEXMEM IS
	BEGIN
	
		PROCESS(CLK, RESET)
			BEGIN
				IF RESET = '1' THEN
					instructionOutput <= X"00000000";
					RegWriteOut <= '0';
					memToRegOut <= '0';
					MemWriteOut <= '0';
					MemReadOut <= '0';
					ALUOut <= X"00000000";
					Op2Out <= X"00000000";
				ELSIF RISING_EDGE(CLK) THEN
					instructionOutput <= instruction;

					RegWriteOut <= RegWrite;
					memToRegOut <= memToReg;

					MemWriteOut <= MemWrite;
					MemReadOut <= MemRead;
					ALUOut <= ALU;
					Op2Out <= Op2;
					
				ELSE
					instructionOutput <= instructionOutput;
					RegWriteOut <= RegWriteOut;
					memToRegOut <= memToRegOut;

					MemWriteOut <= MemWriteOut;
					MemReadOut <= MemReadOut;
					ALUOut <= ALUOut;
					Op2Out <= Op2Out;
					
				END IF;
		END PROCESS;

	END pipelineRegMEMWB_logic;