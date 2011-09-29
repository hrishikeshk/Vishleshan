#ifndef _SYM_TAB
#define _SYM_TAB

#include <stdbool.h>

struct Symbol_Attr{

	char* sym_name;
	struct Symbol_Attr* next_sym;	
};

typedef struct Symbol_Attr Symbol; 

#ifdef __cplusplus

	extern "C" bool lookup_sym(const char* insym_name, Symbol* outSym);

	extern "C" bool insert_sym(const char* insym_name, const char* insym_type);

	extern "C" bool remove_sym(const char* insym_name);

#else
	bool lookup_sym(const char* insym_name, Symbol* outSym);

	bool insert_sym(const char* insym_name, const char* insym_type);

	bool remove_sym(const char* insym_name);

#endif


#endif

