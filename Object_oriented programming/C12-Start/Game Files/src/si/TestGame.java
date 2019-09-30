package si;

public class TestGame {
  public static void main(String[] args) {
    test();
  }

  public static void test() {
    Game g = new Game();
    g.player.printShip();
    Bullet pB = g.player.fire();

    for (int i = 0; i < g.numberOfEnemies; i++) {
      g.enemyShips[i].printShip();

      if (g.enemyShips[i].isHit(pB)) {
        System.out.println("hit");
      } else {
        System.out.println("miss");
      }

      Bullet b = g.enemyShips[i].fire();
      if (b != null) {
        System.out.println(b);
      }
    }
  }
}
