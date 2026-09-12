LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MUX_2inputs IS
	PORT(
		enter1, enter2 : IN STD_LOGIC_VECTOR (31 downto 0);
		selector : IN STD_LOGIC;
		output : OUT STD_LOGIC_VECTOR (31 downto 0)
	);
END MUX_2inputs;

ARCHITECTURE MUX_logic OF MUX_2inputs IS
	BEGIN
		output <= enter1 WHEN selector = '0' ELSE
			enter2;

	END MUX_logic;
--------------------------------------------------------------------------------