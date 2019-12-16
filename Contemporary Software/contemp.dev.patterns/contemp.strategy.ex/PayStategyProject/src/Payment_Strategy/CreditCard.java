package Payment_Strategy;

public class CreditCard extends CardStrategy{

	public CreditCard(String nameOnCard, String number, String cvv, String expirationDate) {
		super(nameOnCard, number, cvv, expirationDate);
	}

	@Override
	protected String getType() {
		return "credit";
	}

}
