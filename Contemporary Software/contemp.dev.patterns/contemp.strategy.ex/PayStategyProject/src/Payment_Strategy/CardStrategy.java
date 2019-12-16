package Payment_Strategy;

import java.text.MessageFormat;

public abstract class CardStrategy implements PaymentStrategy {

	
	    private final String nameOnCard;
	    private final String number;
	    private final String cvv;
	    private final String expirationDate;
	    
	    public CardStrategy(String nameOnCard, String number, String cvv, String expirationDate) {
	        this.nameOnCard = nameOnCard;
	        this.number = number;
	        this.cvv = cvv;
	        this.expirationDate = expirationDate;
	    }
	    @Override
	    public String toString() {
	        return MessageFormat.format("{0} card[name = {1}, number = {2}, CVV = {3}, expiration = {4}]", getType(), nameOnCard, number, cvv, expirationDate);
	    }
	    @Override
	    public void purchase(int cents) {
	        System.out.println("Payed " + cents + " cents using " + toString());
	    }
	    protected abstract String getType();
}
