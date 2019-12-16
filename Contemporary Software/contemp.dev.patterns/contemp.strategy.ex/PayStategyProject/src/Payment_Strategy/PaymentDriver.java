package Payment_Strategy;

public class PaymentDriver {
public static void main(String[] args) {
	CardStrategy cardStrategy = new CreditCard("eoin", "18204142", "662", "04/19");
	Client eoin = new Client(cardStrategy); 
	eoin.purchase(20);
		
	// pay with cash
	Client jess = new Client(new CashStrategy());
	jess.purchase(50);
}
}
