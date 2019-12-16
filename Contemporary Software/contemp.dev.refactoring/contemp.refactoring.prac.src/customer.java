import java.util.ArrayList;
import java.util.List;

public class Customer {

  public Customer(String name) {
    _name = name;
  }

  public void addRental(Rental arg) {
    _rentals.add(arg);
  }

  public String getName() {
    return _name;
  }

  public String statement() {
    double totalAmount = 0;
    int frequentRenterPoints = 0;
    String result = "Rental Record for " + getName() + "\n";

    for (Rental each: _rentals) {
      double thisAmount = 0;

      // determine amounts for each line
      switch (each.getVehicle().getVehicleType()) {
      case Vehicle.CAR:
        thisAmount += 2;
        if (each.getDaysRented() > 2)
          thisAmount += (each.getDaysRented() - 2) * 1.5;
        break;
      case Vehicle.ALL_TERRAIN:
        thisAmount += each.getDaysRented() * 3;
        break;
      case Vehicle.MOTORBIKE:
        thisAmount += 1.5;
        if (each.getDaysRented() > 3)
          thisAmount += (each.getDaysRented() - 3) * 1.5;
        break;
      }

      // add frequent renter points
      frequentRenterPoints++;
      // add bonus for a two day all terrain rental
      if ((each.getVehicle().getVehicleType() == Vehicle.ALL_TERRAIN) && each.getDaysRented() > 1)
        frequentRenterPoints++;

      // show figures for this rental
      result += "\t" + each.getVehicle().getTitle() + "\t" + String.valueOf(thisAmount) + "\n";
      totalAmount += thisAmount;
    }

    // add footer lines
    result += "Amount owed is " + String.valueOf(totalAmount) + "\n";
    result += "You earned " + String.valueOf(frequentRenterPoints) + " frequent renter points";

    return result;
  }

  private String _name;
  private List<Rental> _rentals = new ArrayList<Rental>();
}
