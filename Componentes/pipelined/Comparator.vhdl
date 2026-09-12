LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comparator IS
	PORT(
		rg1 : IN  STD_LOGIC_VECTOR(6 downto 0);
		rg2 : IN  STD_LOGIC_VECTOR(6 downto 0);
		result : OUT STD_LOGIC
	);
END comparator;

ARCHITECTURE behavioral OF comparator IS
BEGIN
	result <= '1' WHEN rg1 = rg2 ELSE
		'0';
END behavioral;