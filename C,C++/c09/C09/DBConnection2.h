//: C09:DBConnection2.h
// From "Thinking in C++, 2nd Edition, Volume 2"
// by Bruce Eckel & Chuck Allison, (c) 2003 MindView, Inc.
// Available at www.BruceEckel.com.
// A parameterized mixin
#ifndef DBCONNECTION_H
#define DBCONNECTION_H
#include "Database.h"
#include <cassert>
#include <string>
using std::string;

template<class Counter>
class DBConnection : public Database, public Counter {
public:
  static DBConnection* create(const string& dbStr)
  throw(DatabaseError) {
    DBConnection* con = new DBConnection(dbStr);
    con->attach();
    assert(con->refCount() == 1);
    return con;
  }
// Other added functionality as desired...
protected:
  DBConnection(const string& dbStr) throw(DatabaseError)
  : Database(dbStr) {
    open();
  }
  ~DBConnection() {
    close();
  }
private:
  // Disallow copy
  DBConnection(const DBConnection&);
  DBConnection& operator=(const DBConnection&);
};
#endif ///:~
