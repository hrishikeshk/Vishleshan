
struct Symbol_Attr{

	char* sym_name;
	struct Symbol_Attr* next_sym;	
};

typedef struct Symbol_Attr Symbol; 

typedef struct SymbolTable{

	Symbol* sym_head;	

} Sym_Tab;

