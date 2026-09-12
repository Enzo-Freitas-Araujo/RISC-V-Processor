LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Forwarding IS
	PORT(
		IDEXInstruction : IN STD_LOGIC_VECTOR(31 downto 0);
		EXMEMInstruction : IN STD_LOGIC_VECTOR(31 downto 0);
		EXMEMRegWrite : IN STD_LOGIC;
		MEMWBInstruction : IN STD_LOGIC_VECTOR(31 downto 0);
		MEMWBRegWrite : IN STD_LOGIC;
		ForwardA : OUT STD_LOGIC_VECTOR(1 downto 0);
		ForwardB : OUT STD_LOGIC_VECTOR(1 downto 0)
	);
END Forwarding;

ARCHITECTURE behavioral OF Forwarding IS
	SIGNAL Rs1 : STD_LOGIC_VECTOR(4 downto 0);
	SIGNAL Rs2 : STD_LOGIC_VECTOR(4 downto 0);
	SIGNAL RdMEMWB : STD_LOGIC_VECTOR(4 downto 0);
	SIGNAL RdEXMEM : STD_LOGIC_VECTOR(4 downto 0);
BEGIN
	Rs1 <= IDEXInstruction(19 downto 15);
	Rs2 <= IDEXInstruction(24 downto 20);
	RdMEMWB <= MEMWBInstruction(11 downto 7);
	RdEXMEM <= EXMEMInstruction(11 downto 7);

	PROCESS(Rs1,
    Rs2,
    RdMEMWB,
    RdEXMEM,
    EXMEMRegWrite,
    MEMWBRegWrite)
	BEGIN
		IF (EXMEMRegWrite = '1') AND (RdEXMEM /= "00000") AND (RdEXMEM = Rs1) THEN
    			ForwardA <= "10";
		ELSIF (MEMWBRegWrite = '1') AND (RdMEMWB /= "00000") 
   		AND NOT (EXMEMRegWrite = '1' AND RdEXMEM /= "00000" AND RdEXMEM = Rs1)
   		AND (RdMEMWB = Rs1) THEN
    			ForwardA <= "01";
		ELSE
			ForwardA <= "00";
		END IF;

		IF (EXMEMRegWrite = '1') AND (RdEXMEM /= "00000") AND (RdEXMEM = Rs2) THEN
    			ForwardB <= "10";
		ELSIF (MEMWBRegWrite = '1') AND (RdMEMWB /= "00000") 
   		AND NOT (EXMEMRegWrite = '1' AND RdEXMEM /= "00000" AND RdEXMEM = Rs2)
   		AND (RdMEMWB = Rs2) THEN
    			ForwardB <= "01";
		ELSE
			ForwardB <= "00";
		END IF;
	END PROCESS;
END behavioral;