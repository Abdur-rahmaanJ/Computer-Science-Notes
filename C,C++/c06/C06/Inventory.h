//: C06:Inventory.h
// From "Thinking in C++, 2nd Edition, Volume 2"
// by Bruce Eckel & Chuck Allison, (c) 2003 MindView, Inc.
// Available at www.BruceEckel.com.
#ifndef INVENTORY_H
#define INVENTORY_H
#include <iostream>
#include <cstdlib>
#include <ctime>

#ifndef _MSC_VER
// Microsoft namespace work-around
using std::rand;
using std::srand;
using std::time;
#endif

class Inventory {
  char item;
  int quantity;
  int value;
public:
  Inventory(char it, int quant, int val) 
    : item(it), quantity(quant), value(val) {}
  // Synthesized operator= & copy-constructor OK
  char getItem() const { return item; }
  int getQuantity() const { return quantity; }
  void setQuantity(int q) { quantity = q; }
  int getValue() const { return value; }
  void setValue(int val) { value = val; }
  friend std::ostream& operator<<(
    std::ostream& os, const Inventory& inv) {
    return os << inv.item << ": " 
      << "quantity " << inv.quantity 
      << ", value " << inv.value;
  }
};

// A generator:
struct InvenGen {
  InvenGen() { srand(time(0)); }
  Inventory operator()() {
    static char c = 'a';
    int q = rand() % 100;
    int v = rand() % 500;
    return Inventory(c++, q, v);
  }
};
#endif // INVENTORY_H ///:~
