import unittest
from data_structures.set_adt_array import Set

class TestSetAdt(unittest.TestCase):

    def test_add(self):
        a = Set()
        a.add(24)
        a.add(24)
        self.assertTrue(a.size()==1)
        
    def test_remove(self):
        a = Set()
        a.add(24)
        a.add("toto")
        self.assertTrue(a.size()==2)
        a.remove("titi")
        self.assertTrue(a.size()==2)
        a.remove("toto")
        self.assertTrue(a.size()==1)
    
    def test_empty(self):
        a = Set()
        self.assertTrue(a.is_empty())
        a.add(24)
        self.assertFalse(a.is_empty())
        a.remove(24)
        self.assertTrue(a.is_empty())
        a.add(24)
        a.remove(23)
        self.assertFalse(a.is_empty())
        
    def test_union(self):
        a = Set()
        b = Set()
        a.add(24)
        a.add(25)
        b.add(4)
        b.add(6)
        b.add(24)
        a.union(b)
        self.assertEqual(a.size(), 4)
        
    def test_intereection(self):
        a = Set()
        b = Set()
        a.add(25)
        b.add(4)
        b.add(6)
        b.add(24)
        a.intersection(b)
        self.assertEqual(a.size(), 0)

        c = Set()
        c.add(4)
        c.add(6)
        c.intersection(b)
        self.assertEqual(c.size(), 2)
    
    def test_difference(self):
        a = Set()
        b = Set()
        a.add(24)
        a.add(25)
        b.add(4)
        b.add(6)
        b.add(24)
        a.difference(b)
        self.assertEqual(a.size(), 1)
        b.difference(a)
        self.assertEqual(b.size(), 3)
        
    
if __name__ == '__main__':
    unittest.main()