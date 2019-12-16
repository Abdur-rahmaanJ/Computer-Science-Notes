package Payment_Strategy;

public class Client implements PaymentStrategy {
	PaymentStrategy PaymentStrategy;
	
	
	
	public Client(PaymentStrategy newPaymentStrategy) {
		this.PaymentStrategy = newPaymentStrategy;
	}
	
	@Override
	public void purchase(int cents) {
		this.PaymentStrategy.purchase(cents);
	}
}
