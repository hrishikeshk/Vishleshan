#ifndef NODE_STRUCTS
#define NODE_STRUCTS

#include <stdbool.h>
#include <malloc.h>

static long seed_id = 0;

struct NodePtr{
	long gs;
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

struct Var_Decl{
	struct Variable* pVar;
	struct ArrayVariable* pAVar;
	struct PDT* pPDT;
};

struct inr_var{
	struct Literal* pLit;
	struct Variable* pVar;
	struct inr_var* pNext; 
};

struct Inr_Var_List{
	struct inr_var* pinrv;
};

struct Var_List{
	struct Inr_Var_List* pivl;
};

struct Expr{
	////struct Data_Type* pData_Type;
	struct Literal* pSem_Value;

};

#ifdef __cplusplus
	extern "C" struct Literal* create_literal();
	extern "C" struct Variable* create_variable();
	extern "C" struct ArrayVariable* create_avariable();
	extern "C" struct PDT* create_pdt();
	extern "C" struct Var_Decl* create_var_decl();
	extern "C" struct Inr_Var_List* create_inr_var_list();
	extern "C" struct Var_List* create_var_list();

	extern "C" long generate_id();

	extern "C" bool get_has_main();
	extern "C" void set_has_main();
#else
	struct Literal* create_literal();
	struct Variable* create_variable();
	struct ArrayVariable* create_avariable();
	struct PDT* create_pdt();
	struct Var_Decl* create_var_decl();
	struct Inr_Var_List* create_inr_var_list();
	struct Var_List* create_var_list();

	long generate_id();

	void set_has_main();
	bool get_has_main();
#endif


#endif

