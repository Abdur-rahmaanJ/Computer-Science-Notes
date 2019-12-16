package StrategyCommute;

public class Commuter {

	// will have a list of commuting strategies
	// does not need to know how they work
	// just calls this commuter's strategy
	CommuterStrategy commuterStrategy;
	public Commuter(CommuterStrategy newStrategy) {
		this.commuterStrategy = newStrategy;
	}
	
	public String travelToAirport() {
		return this.commuterStrategy.travelToAirport();
	}
}
