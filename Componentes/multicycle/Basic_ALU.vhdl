LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY ALU IS
	PORT(
		A, B : IN STD_LOGIC_VECTOR(31 downto 0);
		selector : IN STD_LOGIC_VECTOR(1 downto 0);
        	Zero    : OUT STD_LOGIC;
		Result : OUT STD_LOGIC_VECTOR(31 downto 0)
	);
END ALU;

ARCHITECTURE ALU_logic OF ALU IS

	signal B_eff    : STD_LOGIC_VECTOR(31 downto 0);

	constant allZero : std_logic_vector(31 downto 0) := (others => '0');
	constant allOne : std_logic_vector(31 downto 0) := (others => '1');

    	signal Sum_ext  : UNSIGNED(32 downto 0);

    	signal Res_temp : STD_LOGIC_VECTOR(31 downto 0);
	signal and_temp : STD_LOGIC_VECTOR(31 downto 0);
	signal or_temp : STD_LOGIC_VECTOR(31 downto 0);

    	signal Cin_vec  : UNSIGNED(32 downto 0);

	BEGIN

		and_temp <= A AND B;
		or_temp <= A OR B;

------------------------------------

    B_eff <= (B xor allOne) WHEN (selector = "01") ELSE
		B;

    Cin_vec <= unsigned(allZero & selector(0));

    Sum_ext <= unsigned('0' & A) + unsigned('0' & B_eff) + Cin_vec;

    Res_temp <= std_logic_vector(Sum_ext(31 downto 0));

    Zero <= '1' WHEN ((Res_temp = allZero) AND (selector(1) = '0')) ELSE
		'0';

    Result <= and_temp WHEN (selector = "10") ELSE
		or_temp WHEN (selector = "11") ELSE
		Res_temp;

	END ALU_logic;