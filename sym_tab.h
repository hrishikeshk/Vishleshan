#ifndef _SYM_TAB
#define _SYM_TAB

struct Symbol_Attr{

	char* sym_name;
	struct Symbol_Attr* next_sym;	
};

typedef struct Symbol_Attr Symbol; 

typedef struct SymbolTable{

	Symbol* sym_head;	

} Sym_Tab;


#endif

