#ifndef _SCOPE_
#define _SCOPE_

#include "Local_Sym_Tab.h"
#include "Function_Sym_Tab.h"

typedef struct Scope_Struct{

	long scope_id;

	long parent_scope_id;   // the scope directly enclosing this scope can be INT_MAX for global scope.

	struct Local_Sym_Tab*	pLST;

	struct Function_Sym_Tab*    pFST;

} Scope;



#endif

