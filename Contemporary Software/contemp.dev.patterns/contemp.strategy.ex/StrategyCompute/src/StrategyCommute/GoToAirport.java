package StrategyCommute;
public class GoToAirport {
	
	public static void main(String[] args) {
		Commuter eoin = new Commuter(new CarStrategy());
		eoin.travelToAirport();
		
		// Travel by bus
		Commuter jessCommuter = new Commuter(new TaxiStrategy());
		System.out.println(jessCommuter.travelToAirport());
	}
}
