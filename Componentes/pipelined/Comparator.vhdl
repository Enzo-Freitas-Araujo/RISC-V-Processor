LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comparator IS
	PORT(
		rg1 : IN  STD_LOGIC_VECTOR(31 downto 0);
		rg2 : IN  STD_LOGIC_VECTOR(31 downto 0);
		instruction : IN  STD_LOGIC_VECTOR(31 downto 0);
		result : OUT STD_LOGIC
	);
END comparator;

ARCHITECTURE behavioral OF comparator IS
	SIGNAL funct3 : STD_LOGIC_VECTOR(2 downto 0);
	SIGNAL opcode : STD_LOGIC_VECTOR(6 downto 0);
BEGIN
	opcode <= instruction(6 downto 0);
	funct3 <= instruction(14 downto 12);
	result <= '1' WHEN (((opcode = "1100011") AND ((rg1 = rg2 AND funct3 = "000") OR (rg1 /= rg2 AND funct3 = "001"))) OR
			(opcode = "1101111") OR (opcode = "1100111")) ELSE
		'0';
END behavioral;