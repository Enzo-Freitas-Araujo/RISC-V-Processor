LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ALU_control IS
	PORT(
		instruction : IN  STD_LOGIC_VECTOR(31 downto 0);
		ALUOp  : IN STD_LOGIC_VECTOR(1 downto 0);
		selector : OUT STD_LOGIC_VECTOR(2 downto 0)
	);
END ALU_control;

ARCHITECTURE behavioral OF ALU_control IS
	SIGNAL opcode : STD_LOGIC_VECTOR(6 downto 0);
	SIGNAL funct3 : STD_LOGIC_VECTOR(14 downto 12);
	SIGNAL funct7 : STD_LOGIC_VECTOR(31 downto 25);
BEGIN

	opcode <= instruction(6 downto 0);
	funct3 <= instruction(14 downto 12);
	funct7 <= instruction(31 downto 25);

	PROCESS(ALUOp, opcode, funct3, funct7)
		BEGIN
			selector <= "000";
			IF(ALUOp = "00" OR opcode = "0000011" OR opcode = "0100011") THEN
				selector <= "000";
			ELSIF(ALUOp = "01" OR opcode = "1100011") THEN
				selector <= "001";
			ELSE
				IF(opcode = "0110011" OR opcode = "0010011") THEN
					IF(funct7 = "0000000" OR opcode = "0010011") THEN
						IF(funct3 = "000") THEN
							selector <= "000";
						ELSIF(funct3 = "111") THEN
							selector <= "010";
						ELSIF(funct3 = "110") THEN
							selector <= "011";
						ELSIF(funct3 = "100") THEN
							selector <= "100";
						ELSIF(funct3 = "001") THEN
							selector <= "101";
						ELSIF(funct3 = "101") THEN
							selector <= "110";
						END IF;
					ELSIF(funct7 = "0100000") THEN
						selector <= "001";
					END IF;
				END IF;
			END IF;
		END PROCESS;
END behavioral;