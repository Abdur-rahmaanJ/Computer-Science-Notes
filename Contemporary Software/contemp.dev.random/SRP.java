
public class SRP {
  public static void main(String[] args) {
  }
}

class Hexapod{
  public Hexapod(String name){
    _name = name;
  }
  
  public void throwStick(){
    System.out.println(_name + "is throwing a stick");
  }

  public void fetchStick(){
    System.out.println("I'm fetching a stick");
  }

  public void walk(){
    System.out.println("I'm walking");
  }

  public void bark(){
    System.out.println("Woof! ");
  }
  
  String _name;
}