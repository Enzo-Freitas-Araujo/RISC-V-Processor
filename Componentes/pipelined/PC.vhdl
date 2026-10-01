LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY reg32 IS
	PORT(
		memData : IN STD_LOGIC_VECTOR(31 downto 0);
		PCWrite : IN STD_LOGIC;
		CLK : IN STD_LOGIC;
		RESET : IN STD_LOGIC;
		memOutput : OUT STD_LOGIC_VECTOR(31 downto 0)
	);
END reg32;

ARCHITECTURE reg32_logic OF reg32 IS
	BEGIN
	
		PROCESS(CLK, RESET)
			BEGIN
				IF(Reset = '1') THEN
					memOutput <= x"00000000";
				ELSIF (RISING_EDGE(CLK) AND (PCWrite = '1')) THEN
					memOutput <= memData;
				ELSE
					memOutput <= memOutput;
				END IF;
		END PROCESS;

	END reg32_logic;