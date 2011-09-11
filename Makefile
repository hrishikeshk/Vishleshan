all : vin

vin : vin.tab.c lex.yy.c node_structs.so
	gcc -g -o vin vin.tab.c lex.yy.c node_structs.so

node_structs.o : node_structs.cpp Error_Handler.h
	g++ -g -fPIC -c node_structs.cpp

Error_Handler.o : Error_Handler.cpp Error_Handler.h
	g++ -g -fPIC -c Error_Handler.cpp

node_structs.so : node_structs.o Error_Handler.o Scope.o Local_Sym_Tab.o Function_Sym_Tab.o
	g++ -g --shared -o node_structs.so node_structs.o Error_Handler.o Scope.o Local_Sym_Tab.o Function_Sym_Tab.o

lex.yy.c : vin.fl vin.tab.h
	flex vin.fl

vin.tab.c : vin.y sym_tab.h node_structs.h Scope.h
	bison -d vin.y

Scope.o : Scope.cpp Scope.h Local_Sym_Tab.h Function_Sym_Tab.h
	g++ -g -fPIC -c Scope.cpp

Local_Sym_Tab.o : Local_Sym_Tab.cpp Local_Sym_Tab.h sym_tab.h
	g++ -g -fPIC -c Local_Sym_Tab.cpp

Function_Sym_Tab.o : Function_Sym_Tab.cpp sym_tab.h Function_Sym_Tab.h
	g++ -g -fPIC -c Function_Sym_Tab.cpp

clean :
	rm -rf lex.yy.c
	rm -rf vin.tab.*
	rm -rf vin
	rm -rf vin.output
	rm -rf *.o
	rm -rf *.so

