LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Add IS
	PORT(
		A, B: IN STD_LOGIC_VECTOR(31 downto 0);
		Result : OUT STD_LOGIC_VECTOR(31 downto 0)
	);
END Add;

ARCHITECTURE Add_logic OF Add IS
	BEGIN
    		Result <= std_logic_vector(unsigned(A) + unsigned(B));

	END Add_logic;