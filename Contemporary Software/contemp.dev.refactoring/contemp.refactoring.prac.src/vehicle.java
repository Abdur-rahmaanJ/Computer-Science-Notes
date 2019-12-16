
public class Vehicle {

  public Vehicle(String model, int vehicleType) {
    _model = model;
    _vehicleType = vehicleType;
  }

  public int getVehicleType() {
    return _vehicleType;
  }

  public void setVehicleType(int arg) {
    _vehicleType = arg;
  }

  public String getTitle() {
    return _model;
  }

  public static final int MOTORBIKE = 2;
  public static final int ALL_TERRAIN = 1;
  public static final int CAR = 0;

  private String _model;
  private int _vehicleType;
}
