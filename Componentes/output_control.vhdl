LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY output_control IS
	PORT(
		opcode : IN STD_LOGIC_VECTOR(6 downto 0);
		CLK : IN STD_LOGIC;
		RST : IN STD_LOGIC;
		IRWrite : OUT STD_LOGIC;
		MemtoReg : OUT STD_LOGIC;
		MemWrite : OUT STD_LOGIC;
		MemRead : OUT STD_LOGIC;
		IorD : OUT STD_LOGIC;
		PCWrite : OUT STD_LOGIC;
		PCWriteCond : OUT STD_LOGIC;
		PCSource : OUT STD_LOGIC;
		ALUOp : OUT STD_LOGIC_VECTOR (1 downto 0);
		ALUSrcB : OUT STD_LOGIC_VECTOR (1 downto 0);
		ALUSrcA : OUT STD_LOGIC;
		RegWrite : OUT STD_LOGIC
	);
END output_control;

ARCHITECTURE output_control_logic OF output_control IS

	CONSTANT opAritmetica : STD_LOGIC_VECTOR(6 downto 0) := "0110011";
	CONSTANT LW : STD_LOGIC_VECTOR(6 downto 0) := "0000011";
	CONSTANT SW : STD_LOGIC_VECTOR(6 downto 0) := "0100011";
	CONSTANT BRANCH : STD_LOGIC_VECTOR(6 downto 0) := "1100111";

	TYPE state_type IS (s_fetch, s_decode, s_addressComp, s_MemoryAccessLoad, s_MemoryAccessStore, s_MemoryReadLoad, 
	s_Execution, s_RtypeComp, s_Branch);

	SIGNAL state_next : state_type;
	SIGNAL state_reg : state_type := s_fetch;

	BEGIN
	PROCESS(clk)
		BEGIN
			IF RST = '1' THEN
				state_reg <= s_fetch;
			ELSIF rising_edge(CLK) THEN
				state_reg <= state_next;
			END IF;
		END PROCESS;

	PROCESS(state_reg, opcode)
		BEGIN
			CASE state_reg IS
				WHEN s_fetch =>
					state_next <= s_decode;

				WHEN s_decode =>
					IF opcode = LW OR opcode = SW THEN
						state_next <= s_addressComp;
					ELSIF opcode = opAritmetica THEN
						state_next <= s_Execution;
					ELSIF opcode = BRANCH THEN
						state_next <= s_Branch;
					ELSE
						state_next <= s_fetch; -- Opcode desconhecido reinicia a busca
					END IF;

				WHEN s_addressComp =>
					IF opcode = LW THEN
						state_next <= s_MemoryAccessLoad;
					ELSIF opcode = SW THEN
						state_next <= s_MemoryAccessStore;
					ELSE
						state_next <= s_fetch;
					END IF;

				WHEN s_MemoryAccessLoad =>
					state_next <= s_MemoryReadLoad;

				WHEN s_MemoryReadLoad | s_MemoryAccessStore | s_RtypeComp | s_Branch =>
					state_next <= s_fetch;

				WHEN s_Execution =>
					state_next <= s_RtypeComp;

				WHEN OTHERS =>
					state_next <= s_fetch;
			END CASE;
		END PROCESS;
				

		PROCESS(state_reg)
		BEGIN
			IRWrite     <= '0';
			MemtoReg    <= '0';
			MemWrite    <= '0';
			MemRead     <= '0';
			IorD        <= '0';
			PCWrite     <= '0';
			PCWriteCond <= '0';
			PCSource    <= '0';
			ALUOp       <= "00";
			ALUSrcB     <= "00";
			ALUSrcA     <= '0';
			RegWrite    <= '0';
			CASE state_reg IS
				WHEN s_fetch =>
					MemRead <= '1';
					ALUSrcA <= '0';
					IorD <= '0';
					IRWrite <= '1';
					ALUSrcB <= "01";
					ALUOp <= "00";
					PCWrite <= '1';
					PCSource <= '0';
				WHEN s_decode =>
					ALUSrcA <= '0';
					ALUSrcB <= "10";
					ALUOp <= "00";
				WHEN s_addressComp =>
					ALUSrcA <= '1';
					ALUSrcB <= "10";
					ALUOp <= "00";
				WHEN s_MemoryAccessLoad =>
					MemRead <= '1';
					IorD <= '1';
				WHEN s_MemoryReadLoad =>
					RegWrite <= '1';
					MemtoReg <= '1';
				WHEN s_MemoryAccessStore =>
					MemWrite <= '1';
					IorD <= '1';
				WHEN s_Execution =>
					ALUSrcA <= '1';
					ALUSrcB <= "00";
					ALUOp <= "10";
				WHEN s_RtypeComp =>
					RegWrite <= '1';
					MemtoReg <= '0';
				WHEN s_Branch =>
					ALUSrcA <= '1';
					ALUSrcB <= "00";
					ALUOp <= "01";
					PCWriteCond <= '1';
					PCSource <= '1';
				END CASE;
			END PROCESS;
	END output_control_logic;