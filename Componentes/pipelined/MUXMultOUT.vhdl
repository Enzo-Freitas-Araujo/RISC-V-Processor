LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MUX_2inputs_multOUT IS
	PORT(
		enter1, enter2, enter3, 
		enter4 , enter5 : IN STD_LOGIC;
		enter6 : IN STD_LOGIC_VECTOR (1 downto 0);
		enter7  : IN STD_LOGIC;
		selector : IN STD_LOGIC;
		output1, output2, output3,
		output4, output5 : OUT STD_LOGIC;
		output6 : OUT STD_LOGIC_VECTOR (1 downto 0);
		output7 : OUT STD_LOGIC
	);
END MUX_2inputs_multOUT;

ARCHITECTURE MUX_logic OF MUX_2inputs_multOUT IS
	BEGIN
		output1 <= '0' WHEN selector = '1' ELSE
			enter1;
		output2 <= '0' WHEN selector = '1' ELSE
			enter2;
		output3 <= '0' WHEN selector = '1' ELSE
			enter3;
		output4 <= '0' WHEN selector = '1' ELSE
			enter4;
		output5 <= '0' WHEN selector = '1' ELSE
			enter5;
		output6 <= "00" WHEN selector = '1' ELSE
			enter6;
		output7 <= '0' WHEN selector = '1' ELSE
			enter7;

	END MUX_logic;
--------------------------------------------------------------------------------