LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY output_control IS
	PORT(
		instruction : IN STD_LOGIC_VECTOR(31 downto 0);
		MemtoReg : OUT STD_LOGIC;
		MemWrite : OUT STD_LOGIC;
		MemRead : OUT STD_LOGIC;
		Branch : OUT STD_LOGIC;
		ALUOp : OUT STD_LOGIC_VECTOR (1 downto 0);
		ALUSrcB : OUT STD_LOGIC;
		ALUSrcA : OUT STD_LOGIC;
		RegWrite : OUT STD_LOGIC
	);
END output_control;

ARCHITECTURE output_control_logic OF output_control IS

	CONSTANT opAritmetica : STD_LOGIC_VECTOR(6 downto 0) := "0110011";
	CONSTANT LW : STD_LOGIC_VECTOR(6 downto 0) := "0000011";
	CONSTANT SW : STD_LOGIC_VECTOR(6 downto 0) := "0100011";
	CONSTANT beq : STD_LOGIC_VECTOR(6 downto 0) := "1100011";
	CONSTANT arit_im : STD_LOGIC_VECTOR(6 downto 0) := "0010011";
	CONSTANT auipc : STD_LOGIC_VECTOR(6 downto 0) := "0010111";
	SIGNAL opcode : STD_LOGIC_VECTOR(6 downto 0);

	BEGIN
		opcode <= instruction(6 downto 0);
		PROCESS(Opcode)
		BEGIN
		CASE Opcode IS
            		WHEN opAritmetica =>
                		ALUSrcB <= '0'; ALUSrcA <= '0'; ALUOp <= "10"; MemRead <= '0'; MemWrite <= '0'; Branch <= '0'; RegWrite <= '1'; MemtoReg <= '0';

            		WHEN LW =>
                		ALUSrcB <= '1'; ALUSrcA <= '0'; ALUOp <= "00"; MemRead <= '1'; MemWrite <= '0'; Branch <= '0'; RegWrite <= '1'; MemtoReg <= '1';

            		WHEN SW =>
                		ALUSrcB <= '1'; ALUSrcA <= '0'; ALUOp <= "00"; MemRead <= '0'; MemWrite <= '1'; Branch <= '0'; RegWrite <= '0'; MemtoReg <= '0';

            		WHEN beq =>
                		ALUSrcB <= '0'; ALUSrcA <= '0'; ALUOp <= "01"; MemRead <= '0'; MemWrite <= '0'; Branch <= '1'; RegWrite <= '0'; MemtoReg <= '0';

			WHEN arit_im =>
				ALUSrcB <= '1'; ALUSrcA <= '0'; ALUOp <= "10"; MemRead <= '0'; MemWrite <= '0'; Branch <= '0'; RegWrite <= '1'; MemtoReg <= '0';
			WHEN auipc =>
				ALUSrcB <= '1'; ALUSrcA <= '1'; ALUOp <= "00"; MemRead <= '0'; MemWrite <= '0'; Branch <= '0'; RegWrite <= '1'; MemtoReg <= '0';
            		WHEN OTHERS =>
                		ALUSrcB <= '0'; ALUSrcA <= '0'; ALUOp <= "00"; MemRead <= '0'; MemWrite <= '0'; Branch <= '0'; RegWrite <= '0'; MemtoReg <= '0';
        		END CASE;
    		END PROCESS;
	END output_control_logic;