LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY pipelineRegIDEX IS
	PORT(
		instruction : IN STD_LOGIC_VECTOR(31 downto 0);
		Imm : IN STD_LOGIC_VECTOR(31 downto 0);
		eq: IN STD_LOGIC;
		RegWrite : IN STD_LOGIC;
		MemToReg : IN STD_LOGIC;

		memRead : IN STD_LOGIC;
		memWrite : IN STD_LOGIC;
		Branch : IN STD_LOGIC;

		ALUOp : IN STD_LOGIC_VECTOR (1 downto 0);
		ALUSrcB : IN STD_LOGIC_VECTOR (1 downto 0);

		Rg1 : IN STD_LOGIC_VECTOR(31 downto 0);
		Rg2 : IN STD_LOGIC_VECTOR(31 downto 0);
		CLK : IN STD_LOGIC;
		Flush : IN STD_LOGIC;
		PC : IN STD_LOGIC_VECTOR(31 downto 0);
		ALUSrcA : IN STD_LOGIC_VECTOR(1 downto 0);
		RESET : IN STD_LOGIC;
		instructionOutput : OUT STD_LOGIC_VECTOR(31 downto 0);
		ImmOut : OUT STD_LOGIC_VECTOR(31 downto 0);
		eqOut: OUT STD_LOGIC;
		
		RegWriteOut : OUT STD_LOGIC;
		MemToRegOut : OUT STD_LOGIC;
		
		memReadOut : OUT STD_LOGIC;
		memWriteOut : OUT STD_LOGIC;
		BranchOut : OUT STD_LOGIC;

		ALUOpOUT : OUT STD_LOGIC_VECTOR (1 downto 0);
		ALUSrcBOUT : OUT STD_LOGIC_VECTOR(1 downto 0);

		Rg1Out : OUT STD_LOGIC_VECTOR(31 downto 0);
		Rg2Out : OUT STD_LOGIC_VECTOR(31 downto 0);
		PCOut : OUT STD_LOGIC_VECTOR(31 downto 0);
		ALUSrcAOUT : OUT STD_LOGIC_VECTOR(1 downto 0)
	);
END pipelineRegIDEX;

ARCHITECTURE pipelineRegIDEX_logic OF pipelineRegIDEX IS
	SIGNAL opcode : STD_LOGIC_VECTOR(6 downto 0);
	BEGIN
		opcode <= instruction(6 downto 0);
		PROCESS(CLK, RESET)
			BEGIN
				IF((Flush = '1') OR (RESET = '1')) THEN
					IF RESET = '1' THEN
						instructionOutput <= X"00000000";
						BranchOut <= '0';
						AluOpOut <= "00";
						AluSrcBOut <= "00";
						AluSrcAOut <= "00";
						ImmOut <= X"00000000";
						Rg1Out <= X"00000000";
						Rg2Out <= X"00000000";
						PCOut <= X"00000000";
					ELSE
						instructionOutput <= instructionOutput;
						BranchOut <= BranchOut;
						AluOpOut <= AluOpOut;
						AluSrcBOut <= AluSrcBOut;
						AluSrcAOut <= AluSrcAOut;
						ImmOut <= ImmOut;
						Rg1Out <= Rg1Out;
						Rg2Out <= Rg2Out;
						PCOut <= PCOut;
						IF(opcode = "1101111") THEN
							RegWriteOut <= RegWrite;
						ELSE
							RegWriteOut <= '0';
						END IF;
					END IF;

					memToRegOut <= '0';
					MemWriteOut <= '0';
					MemReadOut <= '0';
					eqOut <= '0';

				ELSIF RISING_EDGE(CLK) THEN
					instructionOutput <= instruction;

					RegWriteOut <= RegWrite;
					memToRegOut <= memToReg;

					BranchOut <= Branch;
					MemWriteOut <= MemWrite;
					MemReadOut <= MemRead;
					
					AluOpOut <= AluOp;
					AluSrcBOut <= AluSrcB;
					AluSrcAOut <= AluSrcA;

					Rg1Out <= Rg1;
					Rg2Out <= Rg2;
					PCOut <= PC;
					eqOut <= eq;
					ImmOut <= Imm;
				ELSE
					instructionOutput <= instructionOutput;
					RegWriteOut <= RegWriteOut;
					memToRegOut <= memToRegOut;

					BranchOut <= BranchOut;
					MemWriteOut <= MemWriteOut;
					MemReadOut <= MemReadOut;
					
					AluOpOut <= AluOpOut;
					AluSrcBOut <= AluSrcBOut;
					AluSrcAOut <= AluSrcAOut;
					ImmOut <= ImmOut;
					Rg1Out <= Rg1Out;
					Rg2Out <= Rg2Out;
					PCOut <= PCOut;
					eqOut <= eqOut;
					ImmOut <= ImmOut;
				END IF;
		END PROCESS;

	END pipelineRegIDEX_logic;