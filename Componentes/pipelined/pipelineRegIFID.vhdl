LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY pipelineReg IS
	PORT(
		instruction : IN STD_LOGIC_VECTOR(31 downto 0);
		PC : IN STD_LOGIC_VECTOR(31 downto 0);
		IFFlush : IN STD_LOGIC;
		IFIDWrite : IN STD_LOGIC;
		CLK : IN STD_LOGIC;
		instructionOutput : OUT STD_LOGIC_VECTOR(31 downto 0);
		PCOut : OUT STD_LOGIC_VECTOR(31 downto 0)
	);
END pipelineReg;

ARCHITECTURE pipelineReg_logic OF pipelineReg IS
	BEGIN
	
		PROCESS(CLK)
			BEGIN
				IF(IFFlush = '1') THEN
						instructionOutput <= "00000000000000000000000000010011";
						PCOut <= PCOut;
				ELSIF RISING_EDGE(CLK) THEN
					IF IFIDWrite = '1' THEN
						instructionOutput <= instruction;
						PCOut <= PC;
					ELSE
						instructionOutput <= instructionOutput;
						PCOut <= PCOut;
					END IF;
				ELSE
					instructionOutput <= instructionOutput;
					PCOut <= PCOut;
				END IF;
		END PROCESS;

	END pipelineReg_logic;