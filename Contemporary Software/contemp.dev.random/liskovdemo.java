
/**
 ** Simple example to illustrate that if covariance is permitted in
 ** the arguments to an overriding method, then substitutivity is not possible
 ** without running the risk of run-time typing errors.
 **
 ** Look at the main method. It contains code that
 ** statically expects to work with an Animal object, but when given a Carnivore
 ** to work with (substitution), produces a run-time type error.
 **
 ** Note that the Carnivore class overrides the eat(Food) method inherited from 
 ** its superclass and tries to limit the type of its parameter to Meat (i.e., covariance).
 **
 ** As explained in lecture, Java does not permit covariance, so we cannot actually
 ** state in Java that the argument to Carnivore::eat() is Meat. 
 **/

import java.io.*;

class Food{};
class Meat  extends Food{}; // So Meat is a subtype of Food
class Fruit extends Food{}; // So Fruit is a subtype of Food


abstract class Animal{
  abstract public void eat(Food f); // Animals eat Food.
}

class Carnivore extends Animal{
   /** The argument to this method should be of type Meat, but we can't state that in Java **/
   public void eat(Food f){
      if (!f.getClass().getName().equals("Meat")){ // testing for a run-time type error, in effect
        System.out.println("Carnivore::eat(Food): Error, run-time type error. Non-meat argument received.\n");
        return;
      }
      for (int i=1; i<=100; i++){
        System.out.println("I'm a carnivore eating meat!\n");
      }
   }
}

public class LiskovDemo{
   public static void main(String[] args) throws IOException{
	Animal c = new Carnivore();
	Food f = new Fruit();
	c.eat(f); // c is of type Animal, f is Food, this should be fine, but it's not!
  }
}