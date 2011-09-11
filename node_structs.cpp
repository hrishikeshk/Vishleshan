
#include <iostream>

#include "node_structs.h"

long generate_id(){

	long ret = seed_id;
	++seed_id;
	return ret;
}

struct Literal* create_literal(){
	struct Literal* pL = (Literal*) malloc(sizeof(Literal));
	pL->vs = NULL;
	return pL;
}

struct Variable* create_variable(){
	struct Variable* pV = (Variable*) malloc(sizeof(struct Variable));
	pV->var_name = NULL;
	pV->pVar = NULL;
	return pV;
}

struct ArrayVariable* create_avariable(){
	struct ArrayVariable* pAV = (ArrayVariable*) malloc(sizeof(ArrayVariable));
	pAV->pAVar = NULL;
	pAV->pVar = NULL;
	return pAV;
}

struct PDT* create_pdt(){
	struct PDT* pPDT = (PDT*) malloc(sizeof(struct PDT));
	return pPDT;
}

struct Var_Decl* create_var_decl(){
	struct Var_Decl* pvd = (Var_Decl*)malloc(sizeof(struct Var_Decl));
	return pvd;
}

