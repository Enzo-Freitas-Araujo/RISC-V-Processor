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
		ALUSrcB : IN STD_LOGIC;

		Rg1 : IN STD_LOGIC_VECTOR(31 downto 0);
		Rg2 : IN STD_LOGIC_VECTOR(31 downto 0);
		CLK : IN STD_LOGIC;
		Flush : IN STD_LOGIC;
		PC : IN STD_LOGIC_VECTOR(31 downto 0);
		ALUSrcA : IN STD_LOGIC_VECTOR(1 downto 0);
		instructionOutput : OUT STD_LOGIC_VECTOR(31 downto 0);
		ImmOut : OUT STD_LOGIC_VECTOR(31 downto 0);
		eqOut: OUT STD_LOGIC;
		
		RegWriteOut : OUT STD_LOGIC;
		MemToRegOut : OUT STD_LOGIC;
		
		memReadOut : OUT STD_LOGIC;
		memWriteOut : OUT STD_LOGIC;
		BranchOut : OUT STD_LOGIC;

		ALUOpOUT : OUT STD_LOGIC_VECTOR (1 downto 0);
		ALUSrcBOUT : OUT STD_LOGIC;

		Rg1Out : OUT STD_LOGIC_VECTOR(31 downto 0);
		Rg2Out : OUT STD_LOGIC_VECTOR(31 downto 0);
		PCOut : OUT STD_LOGIC_VECTOR(31 downto 0);
		ALUSrcAOUT : OUT STD_LOGIC_VECTOR(1 downto 0)
	);
END pipelineRegIDEX;

ARCHITECTURE pipelineRegIDEX_logic OF pipelineRegIDEX IS
	BEGIN
	
		PROCESS(CLK)
			BEGIN
				IF(Flush = '1') THEN
					instructionOutput <= x"00000013";
					RegWriteOut <= '0';
					memToRegOut <= '0';

					BranchOut <= '0';
					MemWriteOut <= '0';
					MemReadOut <= '0';
					
					AluOpOut <= (others => '0');
					AluSrcBOut <= '0';
					AluSrcAOut <= "00";

					ImmOut <= (others => '0');
					Rg1Out <= (others => '0');
					Rg2Out <= (others => '0');
					PCOut <= (others => '0');
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
					eqOut <= eq;
					ImmOut <= ImmOut;
				END IF;
		END PROCESS;

	END pipelineRegIDEX_logic;