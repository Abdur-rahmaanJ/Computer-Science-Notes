package Payment_Strategy;

public class DebitCard extends CardStrategy {

	public DebitCard(String nameOnCard, String number, String cvv, String expirationDate) {
			super(nameOnCard, number, cvv, expirationDate);
		}
	@Override
	protected String getType() {
		return "Debit Card";
	}
}
