package StrategyCommute;

import static org.junit.Assert.*;

import org.junit.Test;

public class StrategyTest {

	@Test
	public void test() {
		Commuter eoinTestCommuter = new Commuter(new CarStrategy());
		assertTrue("Did not return the correct value", eoinTestCommuter.travelToAirport().equals("Travelling by Car"));
	}
}
