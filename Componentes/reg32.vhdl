LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY reg32 IS
	PORT(
		memData : IN STD_LOGIC_VECTOR(31 downto 0);
		CLK : IN STD_LOGIC;
		memOutput : OUT STD_LOGIC_VECTOR(31 downto 0)
	);
END reg32;

ARCHITECTURE reg32_logic OF reg32 IS
	BEGIN
	
		PROCESS(CLK)
			BEGIN
				IF (CLK'event AND CLK='1') THEN
					memOutput <= memData;
				ELSE
					memOutput <= memOutput;
				END IF;
		END PROCESS;

	END reg32_logic;