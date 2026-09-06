LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ALU_control IS
	PORT(
		opcode : IN  STD_LOGIC_VECTOR(6 downto 0);
		funct3 : IN  STD_LOGIC_VECTOR(2 downto 0);
		funct7 : IN  STD_LOGIC_VECTOR(6 downto 0);
		ALUOp  : IN STD_LOGIC_VECTOR(1 downto 0);
		selector : OUT STD_LOGIC_VECTOR(1 downto 0)
	);
END ALU_control;

ARCHITECTURE behavioral OF ALU_control IS
	
BEGIN
	PROCESS(ALUOp, opcode, funct3, funct7)
		BEGIN
			selector <= "00";
			IF(ALUOp = "00" OR opcode = "0000011" OR opcode = "0100011") THEN
				selector <= "00";
			ELSIF(ALUOp = "01" OR opcode = "1100111") THEN
				selector <= "01";
			ELSE
				IF(opcode = "0110011") THEN
					IF(funct7 = "0000000") THEN
						IF(funct3 = "000") THEN
							selector <= "00";
						ELSIF(funct3 = "111") THEN
							selector <= "10";
						ELSIF(funct3 = "110") THEN
							selector <= "11";
						END IF;
					ELSIF(funct7 = "0100000") THEN
						selector <= "01";
					END IF;
				END IF;
			END IF;
		END PROCESS;
END behavioral;