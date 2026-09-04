LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MUX_3inputs IS
	PORT(
		enter1, enter2, enter3 : IN STD_LOGIC_VECTOR (31 downto 0);
		selector: IN STD_LOGIC_VECTOR (1 downto 0);
		output : OUT STD_LOGIC_VECTOR (31 downto 0)
	);
END MUX_3inputs;

ARCHITECTURE MUX_logic OF MUX_3inputs IS
	BEGIN
		output <= enter1 WHEN selector = "00" ELSE
			enter2 WHEN selector = "01" ELSE
			enter3;

	END MUX_logic;
--------------------------------------------------------------------------------