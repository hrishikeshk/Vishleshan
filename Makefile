all : vin

vin : vin.tab.c lex.yy.c node_structs.so
	gcc -g -o vin vin.tab.c lex.yy.c node_structs.so

node_structs.o : node_structs.cpp Error_Handler.h
	g++ -g -fPIC -c node_structs.cpp

Error_Handler.o : Error_Handler.cpp
	g++ -g -fPIC -c Error_Handler.cpp

node_structs.so : node_structs.o Error_Handler.o
	g++ -g --shared -o node_structs.so node_structs.o Error_Handler.o

lex.yy.c : vin.fl vin.tab.h
	flex vin.fl

vin.tab.c : vin.y sym_tab.h node_structs.h
	bison -d vin.y

clean :
	rm -rf lex.yy.c
	rm -rf vin.tab.*
	rm -rf vin
	rm -rf vin.output
	rm -rf *.o
	rm -rf *.so

