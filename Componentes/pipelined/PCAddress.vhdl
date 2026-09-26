LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY PCAddress IS
	PORT(
		A, B, C: IN STD_LOGIC_VECTOR(31 downto 0);
		instruction : IN STD_LOGIC_VECTOR(31 downto 0);
		Result : OUT STD_LOGIC_VECTOR(31 downto 0)
	);
END PCAddress;

ARCHITECTURE PCAddress_logic OF PCAddress IS
	BEGIN
		
    		Result <= std_logic_vector(unsigned(C) + unsigned(B)) WHEN 
			(instruction(6 downto 0) = "1100111") ELSE
			std_logic_vector(unsigned(A) + unsigned(B));

	END PCAddress_logic;