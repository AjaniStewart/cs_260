//Password: guinan
//Credit: chapel, culber

#include <iostream>
using namespace std;

int main() {
  struct foo_t {
    int x[100];
    int var1;
    int y[10];
  } foo;
  int var2;
  long i;
  int *p, *q;
  short int *s;
  long int *l;
  struct foo_t bar[50];

  for (i=0; i<100; i++) foo.x[i]=100+i;
  for (i=0; i<10; i++) foo.y[i]=200+i;
  foo.var1 = 250;

  cout << sizeof(*s) << "\n";
  cout << sizeof(*p) << "\n";
  cout << sizeof(*l) << "\n";
  // MOD
  cout << sizeof(s) << "\n";
  q = (int*) &foo; cout << q << "\n";
  p = &(foo.x[5]); cout << p << "\n";
  cout << i << "\n";
  /* for question 4*/
  cout << "FOR QUESTION 4\n";
  cout << "foo " << &foo << "\n";
  cout << "foo.x[0] " << foo.x << "\n";
  cout << "foo.x[1] " << &(foo.x[1]) << "\n";
  cout << "foo.x[99] " << &(foo.x[99]) << "\n";
  cout << "foo.var1 " << &foo.var1 << "\n";
  cout << "foo.y[0] " << foo.y << "\n";
  cout << "foo.y[1] " << &(foo.y[1]) << "\n";
  cout << "foo.y[9] " << &(foo.y[9]) << "\n";
  cout << "var2 " << &var2 << "\n";
  cout << "i " << &i << "\n";
  cout << "p " << &p << "\n";
  cout << "q " << &q << "\n";
  cout << "s " << &s << "\n";
  cout << "l " << &l << "\n";
  cout << "bar[0] " << bar << "\n";
  cout << "bar[1] " << &(bar[1]) << "\n";
  cout << "bar[49] " << &(bar[49]) << "\n";
  //Point 1
  cout << "POINT 1\n";
  q = (int*) &var2; cout << q << " 1\n";
  q = p+16;         cout << *q << " 2\n";
  i = ((long) p) + 16;
  q = (int*) i; cout << *q << " 3\n";
  s = (short*) i; cout << *s << " 4\n";
  l = (long*) i; cout << *l << " 5\n";
  q = p+95; cout << *q << " 6\n";
  q = p+98; cout << *q << " 7\n";
  i = ((long) p) + 17;
  q = (int*) i; cout << *q << " 8\n";
  q = p + 101; cout << *q << "\n";
  q = (int*) (((long) p) + 404); cout << *q << "\n";
  p = (int*) bar;
  *(p + 988) = 500; cout << bar[8].var1 << "\n";
  }

/********************************************************
Question 1:

Output:
2
4
8
0x7ffeefb46590
0x7ffeefb465a4
0x7ffeefb4658c
121
109
109
472446402669
250
202
1845493760

Computer:
Apple MacBook Air
1.8 GHz Intel Core i5

Compiler: g++8


Question 2:
short: 16 bits
int: 32 bits
long: 64 bits

Question 3:
Pointers are stored with 64 bits.

Question 4:

address        value    variable

0x7ffeec9b85c0             foo
0x7ffeec9b85c0  100        foo.x[0]
0x7ffeec9b85c4  101        foo.x[1]
                100+i      foo.x[i]
0x7ffeec9b874c  199        foo.x[99]
0x7ffeec9b8750  250        foo.var1 
0x7ffeec9b8754  200        foo.y[0] 
0x7ffeec9b8758  201        foo.y[1]
                200+i      foo.y[i]
0x7ffeec9b8778  209        foo.y[9] 
0x7ffeec9b85bc             var2 
0x7ffeec9b85b0  10         i 
0x7ffeec9b85a8             p  <-- Points to foo.x[5]
0x7ffeec9b85a0             q  <-- Points to foo
0x7ffeec9b8598             e
0x7ffeec9b8590             l
0x7ffeec9b2ed0             bar[0] 
0x7ffeec9b308c             bar[1] 
0x7ffeec9b83cc             bar[49]

Questions 5:
The strange output results from line l = (long*) i; i is an int pointer that was casted to a long pointer. Because p is pointing to an int array, i interprets it interprests the first 2 elements as one variable.


Question 6:
When adding integers, only the value updates. When adding pointers, it takes into account the size of the type it is pointing to and adds the correct amount of bytes to ensure that it is pointing correctly.

************************************************************/ 
