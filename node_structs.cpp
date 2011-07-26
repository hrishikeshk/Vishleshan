
#include <iostream>

#include "node_structs.h"


class A{
public:
	int z;
	void foo(int x){
		x = 10;
	}

};

void process_node(int x){

	x = 10;
	A a;
	a.foo(x);
	std::cout << x << " HOOOOOO \n";
}

