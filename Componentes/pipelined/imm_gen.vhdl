LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY imm_gen IS
	PORT(
		instruction : IN  STD_LOGIC_VECTOR(31 downto 0);
		imm_out     : OUT STD_LOGIC_VECTOR(31 downto 0)
	);
END imm_gen;

ARCHITECTURE behavioral OF imm_gen IS
	ALIAS opcode : STD_LOGIC_VECTOR(6 downto 0) IS instruction(6 downto 0);
BEGIN

	PROCESS(instruction, opcode)
	BEGIN
		CASE opcode IS
			-- Tipo-I (ex: Load, addi)
			WHEN "0000011" | "0010011" =>
				imm_out <= (31 downto 12 => instruction(31)) & instruction(31 downto 20);

			-- Tipo-S (ex: Store)
			WHEN "0100011" =>
				imm_out <= (31 downto 12 => instruction(31)) & instruction(31 downto 25) & instruction(11 downto 7);

			-- Tipo-B (ex: Branch / Desvios)
			WHEN "1100011" =>
				imm_out <= (31 downto 12 => instruction(31)) & instruction(7) & instruction(30 downto 25) & instruction(11 downto 8) & '0';
				
			-- Tipo-U
			WHEN "0010111" | "0110111"  =>
				imm_out <= instruction(31 downto 12) & x"000";
			-- Tipo-J
			WHEN "1101111" =>
    				imm_out <= (31 downto 21 => instruction(31)) &  -- 11 bits de extensão de sinal
               			instruction(31)                  &  -- imm[20]       (1 bit)
               			instruction(19 downto 12)        &  -- imm[19:12]    (8 bits)
               			instruction(20)                  &  -- imm[11]       (1 bit)
               			instruction(30 downto 21)        &  -- imm[10:1]     (10 bits)
               		'0';
			WHEN OTHERS =>
				imm_out <= (others => '0');
		END CASE;
	END PROCESS;

END behavioral;