/**
 * ABSTRACT FACTORY EXERCISE
 * 
 * April, 2014
 */

class Client {
	public Client(){
		prodA = new ProductA();
	}
	public void foo(){
		prodA.doYourStuff();
		ProductB my_prodB = new ProductB();
		my_prodB.doIt();
		ProductC my_prodC = new ProductC();
		my_prodC.perform();
	}
	ProductA prodA;
	ProductB prodB;
}

class ProductA{
	public void doYourStuff(){
		System.out.println("I'm a ProductA, doing my stuff");
	}
}

class ProductB{
	public void doIt(){
		System.out.println("I'm a ProductB, doing it");
	}
}

class ProductC{
	public void perform(){
		System.out.println("I'm a ProductC, performing");
	}
}


public class AF {
	public static void main(String[] args) {
		Client my_client = new Client();
		my_client.foo();
	}
}

