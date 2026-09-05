LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY IR_block IS
	PORT(
		memData : IN STD_LOGIC_VECTOR(31 downto 0);
		CLK : IN STD_LOGIC;
		opcode : OUT STD_LOGIC_VECTOR(6 downto 0);
		rs1 : OUT STD_LOGIC_VECTOR(4 downto 0);
		rs2 : OUT STD_LOGIC_VECTOR(4 downto 0);
		rd : OUT STD_LOGIC_VECTOR(4 downto 0)
	);
END IR_block;

ARCHITECTURE IR_logic OF IR_block IS
	BEGIN
	
		PROCESS(CLK)
			BEGIN
				IF (CLK'event AND CLK='1') THEN
					opcode <= memData(6 downto 0);
					rs1 <= memData(19 downto 15);
					rs2 <= memData(24 downto 20);
					rd <= memData(11 downto 7);
				ELSE
					opcode <= opcode;
					rs1 <= rs1;
					rs2 <= rs2;
					rd <= rd;
				END IF;
		END PROCESS;

	END IR_logic;