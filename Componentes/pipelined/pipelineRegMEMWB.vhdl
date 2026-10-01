LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY pipelineRegMEMWB IS
	PORT(
		instruction : IN STD_LOGIC_VECTOR(31 downto 0);
		MemInstruction : IN STD_LOGIC_VECTOR(31 downto 0);

		RegWrite : IN STD_LOGIC;
		MemToReg : IN STD_LOGIC;

		ALU : IN STD_LOGIC_VECTOR(31 downto 0);
		CLK : IN STD_LOGIC;
		RESET : IN STD_LOGIC;

		instructionOutput : OUT STD_LOGIC_VECTOR(31 downto 0);
		MemInstructionOut : OUT STD_LOGIC_VECTOR(31 downto 0);
		
		RegWriteOut : OUT STD_LOGIC;
		MemToRegOut : OUT STD_LOGIC;
	
		ALUOut : OUT STD_LOGIC_VECTOR(31 downto 0)
	);
END pipelineRegMEMWB;

ARCHITECTURE pipelineRegMEMWB_logic OF pipelineRegMEMWB IS
	BEGIN
	
		PROCESS(CLK, RESET)
			BEGIN
				IF RESET = '1' THEN
					instructionOutput <= X"00000000";
					MeminstructionOut <= X"00000000";
					RegWriteOut <= '0';
					memToRegOut <= '0';
					ALUOut <= X"00000000";
				ELSIF RISING_EDGE(CLK) THEN
					instructionOutput <= instruction;
					MeminstructionOut <= Meminstruction;

					RegWriteOut <= RegWrite;
					memToRegOut <= memToReg;

					ALUOut <= ALU;
					
				ELSE
					instructionOutput <= instructionOutput;
					MeminstructionOut <= MeminstructionOut;
					RegWriteOut <= RegWriteOut;
					memToRegOut <= memToRegOut;

					ALUOut <= ALUOut;
					
				END IF;
		END PROCESS;

	END pipelineRegMEMWB_logic;