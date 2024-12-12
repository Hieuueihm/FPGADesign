LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY BaudClkGenerator IS

	GENERIC (
		SYS_CLK_FREQ : INTEGER := 50000000;
		BAUD_RATE : INTEGER := 115200;
		NUMBER_OF_CLOCKS : INTEGER := 10;
		IS_RX : BOOLEAN := false
	);
	PORT (
		clk : IN STD_LOGIC; -- 50 MHz 
		rst : IN STD_LOGIC;
		start : IN STD_LOGIC;
		baudClk : OUT STD_LOGIC;
		ready : OUT STD_LOGIC
	);

END ENTITY;

ARCHITECTURE rtl OF BaudClkGenerator IS

	CONSTANT BIT_PERIOD : INTEGER := SYS_CLK_FREQ / BAUD_RATE;
	CONSTANT HALF_BIT_PERIOD : INTEGER := SYS_CLK_FREQ / (2 * BAUD_RATE);
	SIGNAL BitPeriodCounter : INTEGER RANGE 0 TO BIT_PERIOD;
	SIGNAL clocksLeft : INTEGER RANGE 0 TO NUMBER_OF_CLOCKS;
BEGIN

	BitPeriodProcess : PROCESS (clk, rst)
	BEGIN
		IF rst = '1' THEN
			baudClk <= '0';
			BitPeriodCounter <= 0;
		ELSIF rising_edge(clk) THEN
			IF clocksLeft > 0 THEN
				IF BitPeriodCounter = BIT_PERIOD THEN
					baudClk <= '1';
					BitPeriodCounter <= 0;
				ELSE
					baudClk <= '0';
					BitPeriodCounter <= BitPeriodCounter + 1;
				END IF;
			ELSE
				baudClk <= '0';
				IF IS_RX = true THEN
					BitPeriodCounter <= HALF_BIT_PERIOD;
				ELSE
					BitPeriodCounter <= 0;
				END IF;
			END IF;

		END IF;
	END PROCESS;

	BeginOrEndBaudClock : PROCESS (rst, clk)
	BEGIN
		IF rst = '1' THEN
			clocksLeft <= 0;
		ELSIF rising_edge(clk) THEN
			IF start = '1' THEN
				clocksLeft <= NUMBER_OF_CLOCKS;
			ELSIF baudClk = '1' THEN
				ClocksLeft <= ClocksLeft - 1;
			END IF;

		END IF;
	END PROCESS;

	ReadyProcess : PROCESS (rst, clk)
	BEGIN
		IF rst = '1' THEN
			ready <= '0';
		ELSIF rising_edge(clk) THEN
			IF start = '1' THEN
				ready <= '0';
			ELSIF clocksLeft = 0 THEN
				ready <= '1';
			END IF;
		END IF;
	END PROCESS;

END rtl;