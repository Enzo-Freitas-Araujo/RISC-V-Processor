LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY register_block IS
	PORT(
		instruction : IN STD_LOGIC_VECTOR(31 downto 0);
		instruction2 : IN STD_LOGIC_VECTOR(31 downto 0);
		CLK : IN STD_LOGIC;
		reg_write : IN STD_LOGIC;
		rgw_data : IN STD_LOGIC_VECTOR(31 downto 0);
		rg1_data , rg2_data : OUT STD_LOGIC_VECTOR(31 downto 0)
	);
END register_block;

ARCHITECTURE register_logic OF register_block IS

	type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);
	signal registers : reg_array := (others => (others => '0'));
	signal value1 : STD_LOGIC_VECTOR(31 downto 0);
	signal value2 : STD_LOGIC_VECTOR(31 downto 0);
	signal rg1, rg2, rgw : STD_LOGIC_VECTOR(4 downto 0);

	BEGIN
		rg1 <= instruction(19 downto 15);
		rg2 <= instruction(24 downto 20);
		rgw <= instruction2(11 downto 7);
		PROCESS(CLK)
			BEGIN
				IF (RISING_EDGE(CLK)) THEN
					IF (reg_write = '1' AND rgw /= "00000") THEN
						registers(to_integer(unsigned(rgw))) <= rgw_data;
					END IF;
				END IF;
		END PROCESS;

		rg1_data <= registers(to_integer(unsigned(rg1)));
		rg2_data <= registers(to_integer(unsigned(rg2)));

	END register_logic;