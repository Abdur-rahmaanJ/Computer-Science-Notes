
public class OCP {
  public static void main(String[] args) {
    Square square = new Square(10.1);
    PostageStamp stamp = new PostageStamp(square);
    System.out.println(stamp.toString());
  }
}

class PostageStamp{
  public PostageStamp(Square square){
    shape = square;
  }
  public String toString(){
    return "stamp, contained in a " + shape.toString();
  }
  Square shape; 
}

class Square {
  public Square(double d){
    length = d;
  }
  public String toString(){
    return "square, side of length " + length;
  }
  private double length;
}