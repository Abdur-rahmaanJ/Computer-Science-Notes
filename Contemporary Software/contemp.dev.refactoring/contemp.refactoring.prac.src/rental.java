
// Represents a rental of a vehicle
public class Rental {

  public Rental(Vehicle vehicle, int daysRented) {
    _vehicle = vehicle;
    _daysRented = daysRented;
  }

  public int getDaysRented() {
    return _daysRented;
  }

  public Vehicle getVehicle() {
    return _vehicle;
  }

  private Vehicle _vehicle;
  private int _daysRented;
}