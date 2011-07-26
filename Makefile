all : vin

vin : vin.tab.c lex.yy.c node_structs.so
	gcc -o vin vin.tab.c lex.yy.c node_structs.so

node_structs.o : node_structs.cpp
	g++ -fPIC -c node_structs.cpp

node_structs.so : node_structs.o
	g++ --shared -o node_structs.so node_structs.o

lex.yy.c : vin.fl vin.tab.h
	flex vin.fl

vin.tab.c : vin.y sym_tab.h node_structs.h
	bison -d --debug --verbose vin.y

clean :
	rm -rf lex.yy.c
	rm -rf vin.tab.*
	rm -rf vin
	rm -rf vin.output
	rm -rf *.o
	rm -rf *.so

