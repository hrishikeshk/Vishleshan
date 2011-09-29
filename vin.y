%{

#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <limits.h>

#include "sym_tab.h"
#include "node_structs.h"
#include "Scope.h"


int yyerror(const char* se){
	printf("Parse Error : ");
	printf(se);
	printf("\n");
	return 1;
}

int yywrap(){
	return 1;
}

int yydebug=1;

Scope g_s;

struct NodePtr c_u;

Scope* pCurrent_Scope;

%}

%union {

	int intv;
	double dblv;
	char*	strv;
	char	chrv;
	struct NodePtr* nptr;
	struct Literal* lit;
	struct Variable* var;
	struct ArrayVariable* avar;
	struct PDT*	pdt;
	struct Var_Decl*	pvd;
	struct Inr_Var_List*	ivl;
	struct Var_List*	pvl;
}

%token PTR PDT_INT PDT_CHAR PDT_DOUBLE PDT_BOOL PDT_VOID IF ELSE WHILE RETURN OP_DOT OP_EQL TRUE FALSE STRUCT BREAK CONTINUE

%token <intv> INT_LITERAL
%token <dblv> DOUBLE_LITERAL
%token <strv> STRING_LITERAL
%token <chrv> CHAR_LITERAL
%token <strv> VAR_NAME

%type <nptr> C_U stmts stmt expr fn_decl arg_list stmt_blk fn_inv loop_cons var_decl_init ifx struct_decl inr_stmt_blk inr_arg_list

%type <lit> literal
%type <var> var
%type <avar> array_var
%type <pdt> pdt
%type <pvd> var_decl
%type <ivl> inr_var_list
%type <pvl> var_list

%start C_U

%left '<' '>'
%left '+' '-'
%left '*' '/'
%left '='

%%

C_U:
	stmts     {
		  }
	;
stmts:
	stmt     {
	         }
	|
	stmts stmt 	{	 
		  	}
	;
stmt:
	var_decl_init ';'	{
				}
	|
	fn_decl		{
			}
	|
	struct_decl	{
			}
	;
var_decl_init:
	var_decl	{
			}
	|
	pdt var '=' expr  	{
				}
	|
	pdt var '[' INT_LITERAL ']'	{
					}
	;
var_decl:
	pdt var		{
				struct Var_Decl* pvd = create_var_decl();
				pvd->pVar = $2;
				pvd->pPDT = $1;
				$$=pvd;
			}
	;
var_decl_list:
	var_decl_list var_decl ';'	{
					}
	|
	var_decl ';'			{
					}
struct_decl:
	STRUCT var '{' var_decl_list '}' ';'	{
						}
	;
fn_decl:
        pdt var arg_list stmt_blk               {
                                                }
        ;
arg_list:
	'(' inr_arg_list ')'	{
				}
	|
	'(' ')'			{
				}
	;
inr_arg_list:
        inr_arg_list ','  var_decl {
                        }
        |
        var_decl        {
                        }
	|
	pdt var '[' ']'	{
			}
	|
	inr_arg_list ',' pdt var '[' ']'	{
						}
        ;
inr_var_list:
	inr_var_list ',' var    {
					struct Inr_Var_List* pivl = $1;
					struct Variable* pIVar = $3;
					struct inr_var* piv = (struct inr_var*) malloc(sizeof(struct inr_var));
					piv->pVar = pIVar;
					piv->pLit = NULL;
					piv->pNext = NULL;

					struct inr_var* pTmp = pivl->pinrv;
					if(pTmp == NULL){
						assert(0);
					}
					while(pTmp->pNext != NULL){
						pTmp = pTmp->pNext;
					}
					pTmp->pNext = piv;
					$$=pivl;
			    }
	|
	var		    {
					struct Inr_Var_List* pivl = create_inr_var_list();
					struct inr_var* piv = (struct inr_var*) malloc(sizeof(struct inr_var));
					piv->pVar = $1;
					piv->pNext = NULL;
					pivl->pinrv = piv;
					$$=pivl;
			    }
	|
	inr_var_list ',' literal    {
					struct Inr_Var_List* pivl = $1;
					struct Literal* pILit = $3;
					struct inr_var* piv = (struct inr_var*) malloc(sizeof(struct inr_var));
					piv->pVar = NULL;
					piv->pLit = pILit;
					piv->pNext = NULL;

					struct inr_var* pTmp = pivl->pinrv;
					if(pTmp == NULL){
						assert(0);
					}
					while(pTmp->pNext != NULL){
						pTmp = pTmp->pNext;
					}
					pTmp->pNext = piv;
					$$=pivl;
			    }
	|
	literal		{
					struct Inr_Var_List* pivl = create_inr_var_list();
					struct inr_var* piv = (struct inr_var*) malloc(sizeof(struct inr_var));
					piv->pLit = $1;
					piv->pNext = NULL;
					pivl->pinrv = piv;
					$$=pivl;
			}
	;
var_list:
	'(' inr_var_list ')'	{
					struct Var_List* pvl = create_var_list();
					pvl->pivl = $2;
					$$ = pvl;
				}
	|
	'(' ')'			{
					struct Var_List* pvl = create_var_list();
					pvl->pivl = NULL;
					$$ = pvl;
				}
	;
fn_inv:
	var var_list     {
			}
	;
stmt_blk:
	'{' inr_stmt_blk '}'	{
				}
	|
	'{' '}'			{
				}
	;
inr_stmt_blk:
        inr_stmt_blk expr ';'  {
                        }
        |
        inr_stmt_blk var_decl_init ';'      {
                                }
        |
        expr ';'        {
                        }
        |
        var_decl_init ';'    {
                        }
	|
	inr_stmt_blk ctrl_stmt ';' {
				}
	|
	ctrl_stmt ';'	{
			}
	|
	inr_stmt_blk loop_cons	{
			}
	|
	loop_cons	{
			}
	|
	inr_stmt_blk ifx		{
			}
	|
	ifx		{
			}
        ;
ifx:
	IF '(' expr ')' stmt_blk  {
				  }
	|
	IF '(' expr ')' stmt_blk ELSE stmt_blk    {
						  }
	;
ctrl_stmt:
	RETURN literal	{
			}
	|
	RETURN var	{
			}
	|
	RETURN var '[' INT_LITERAL ']' {
					}
	|
	RETURN var '[' var ']'		{
					}
	|
	BREAK		{
			}
	|
	CONTINUE	{
			}
	;
loop_cons:
	WHILE '(' expr ')' stmt_blk {
					}
        ;
pdt: PDT_INT {
		struct PDT* pPDT = create_pdt();
		pPDT->epdt = INT;
		$$=pPDT;
	     }
     |
     PDT_DOUBLE {
		struct PDT* pPDT = create_pdt();
		pPDT->epdt = DOUBLE;
		$$=pPDT;
		}
     |
     PDT_BOOL  {
		struct PDT* pPDT = create_pdt();
		pPDT->epdt = BOOL;
		$$=pPDT;
	       }
     |
     PDT_VOID  {
		struct PDT* pPDT = create_pdt();
		pPDT->epdt = VOID;
		$$=pPDT;
	       }
     |
     PDT_CHAR   {
		struct PDT* pPDT = create_pdt();
		pPDT->epdt = CHAR;
		$$=pPDT;
		}
     ;
array_var:
	var '[' array_var ']'	{
					struct ArrayVariable* pAV = create_avariable();
					pAV->pAVar = $3;
					pAV->pVar = $1;
					$$=pAV;
				}
	|
	var			{
					struct ArrayVariable* pAV = create_avariable();
					pAV->pVar = $1;
					$$=pAV;
				}
	;
expr: 
	'(' expr ')'	{
			}
	|
	expr '<' expr	{
			}
	|
	expr '>' expr	{
			}
	|
	expr '+' expr  {
			}
        |
	expr '-' expr    {
			}
	|
	expr '*' expr 	{
			}
	|
	expr '/' expr   {
			}
	|
	array_var '=' expr {
		     }
	|
	var OP_EQL literal    {
				   }
	|
	literal			{
				}
	|
	fn_inv			{
				}
	|
	var '[' INT_LITERAL ']'	{
				}
	|
	array_var 		{
				}
	;
var:	
	var OP_DOT VAR_NAME  {
					struct Variable* pV = $1;
					while(pV->pVar != NULL){
						pV = pV->pVar;
					}
					struct Variable* pV2 = create_variable();
					pV2->var_name=(char*)malloc(strlen($3)+1);
					strcpy(pV2->var_name, $3);
					pV2->var_name[strlen($3)] = '\0';
					pV->pVar = pV2;
					$$=pV;
			     }
	| 
	VAR_NAME		{
					struct Variable* pV = create_variable();
					pV->var_name=(char*)malloc(strlen($1)+1);
					strcpy(pV->var_name, $1);
					pV->var_name[strlen($1)] = '\0';
					$$=pV;
				}
	;
literal: INT_LITERAL  {
			struct Literal* pL = create_literal();
			pL->vi = $1;
			pL->epdt = INT;
			$$ = pL;
		   }
	|
	DOUBLE_LITERAL {
			struct Literal* pL = create_literal();
			pL->vd = $1;
			pL->epdt = DOUBLE;
			$$ = pL;
			}
	|
	STRING_LITERAL {
			struct Literal* pL = create_literal();
			int len = strlen($1);
			pL->vs = (char*)malloc(len+1);
			strcpy(pL->vs, $1);
			pL->vs[len] = '\0';
			pL->epdt = STRING;
			$$ = pL;
			}
	|
	TRUE		{
			struct Literal* pL = create_literal();
			pL->vb = true;
			pL->epdt = BOOL;
			$$ = pL;
			}
	|
	FALSE		{
			struct Literal* pL = create_literal();
			pL->vb = false;
			pL->epdt = BOOL;
			$$ = pL;
			}
	|
	CHAR_LITERAL	{
			struct Literal* pL = create_literal();
			pL->vc = $1;
			pL->epdt = CHAR;
			$$ = pL;
			}
	;

%%

int main(int argc, char* argv[]){

	g_s.scope_id = generate_id();
	g_s.parent_scope_id = INT_MAX;
	g_s.pLST = NULL;
	g_s.pFST = NULL;

	pCurrent_Scope = &g_s;

	c_u.gs = g_s.scope_id;

	yyparse();
	return 0;
}

