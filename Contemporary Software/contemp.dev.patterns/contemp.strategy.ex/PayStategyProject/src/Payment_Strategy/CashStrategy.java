package Payment_Strategy;

public class CashStrategy implements PaymentStrategy {

	@Override
	public void purchase(int cents) {
		System.out.println("Payed " + cents + " using cash");
	}
	
}
