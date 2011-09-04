#include <stdbool.h>
#include <malloc.h>

#ifndef NODE_STRUCTS
#define NODE_STRUCTS

struct NodePtr{
};

enum prim_data_type { BOOL, CHAR, INT, DOUBLE, STRING, VOID };

struct Literal{
	int vi;
	double vd;
	char vc;
	char* vs;
	bool vb;
	enum prim_data_type epdt;
};

struct Variable{
	struct Variable* pVar;
	char* var_name;
};

struct ArrayVariable{
	struct ArrayVariable* pAVar;
	struct Variable* pVar;
};

struct PDT{
	enum prim_data_type epdt;
};

#ifdef __cplusplus
	extern "C" struct Literal* create_literal();
	extern "C" struct Variable* create_variable();
	extern "C" struct ArrayVariable* create_avariable();
	extern "C" struct PDT* create_pdt();

	extern "C" bool get_has_main();
	extern "C" void set_has_main();
#else
	struct Literal* create_literal();
	struct Variable* create_variable();
	struct ArrayVariable* create_avariable();
	struct PDT* create_pdt();

	void set_has_main();
	bool get_has_main();
#endif


#endif

