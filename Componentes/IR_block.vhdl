LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY IR_block IS
	PORT(
		memData : IN STD_LOGIC_VECTOR(31 downto 0);
		CLK : IN STD_LOGIC;
		IRWrite : IN STD_LOGIC;
		instruction : OUT STD_LOGIC_VECTOR(31 downto 0)
	);
END IR_block;

ARCHITECTURE IR_logic OF IR_block IS
	BEGIN
	
		PROCESS(CLK)
			BEGIN
				IF (RISING_EDGE(CLK) AND IRWrite = '1') THEN
					instruction <= memData;
				ELSE
					instruction <= instruction;
				END IF;
		END PROCESS;

	END IR_logic;