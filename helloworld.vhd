ENTITY helloworld IS
END ENTITY;

ARCHITECTURE sim OF helloworld IS

	SIGNAL CountUp : INTEGER := 0;
	SIGNAL CountDown : INTEGER := 10;
BEGIN

	PROCESS IS
	BEGIN
		CountUp <= CountUp + 1;
		CountDown <= CountDown - 1;
		WAIT FOR 10 ns;
	END PROCESS;

	PROCESS IS
	BEGIN
		IF CountUp = CountDown THEN
			REPORT "This is a message";
		END IF;

		WAIT ON CountUp, CountDown;

	END PROCESS;

	PROCESS (CountUp, CountDown) IS
	BEGIN
		IF CountUp = CountDown THEN
			REPORT "This is a message 1";
		END IF;
	END PROCESS;
END ARCHITECTURE;