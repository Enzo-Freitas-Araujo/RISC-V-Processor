LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY splitter IS
	PORT(
		address_in : IN  STD_LOGIC_VECTOR(31 downto 0);
		address_out : OUT STD_LOGIC_VECTOR(11 downto 0)
	);
END splitter;

ARCHITECTURE behavioral OF splitter IS
BEGIN
	address_out <= address_in(13 downto 2);
END behavioral;