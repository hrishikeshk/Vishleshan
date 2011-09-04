%{

#include <stdio.h>
#include<string.h>
#include <assert.h>

#include "sym_tab.h"
#include "node_structs.h"


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
}

%token PTR PDT_INT PDT_CHAR PDT_DOUBLE PDT_BOOL PDT_VOID IF ELSE WHILE RETURN OP_DOT OP_EQL TRUE FALSE STRUCT BREAK CONTINUE

%token <intv> INT_LITERAL
%token <dblv> DOUBLE_LITERAL
%token <strv> STRING_LITERAL
%token <chrv> CHAR_LITERAL
%token <strv> VAR_NAME

%type <nptr> C_U stmts stmt expr var_decl fn_decl arg_list stmt_blk var_list fn_inv loop_cons var_decl_init ifx struct_decl inr_stmt_blk inr_arg_list inr_var_list

%type <lit> literal
%type <var> var
%type <avar> array_var
%type <pdt> pdt

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
	var_decl_init	{
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
			    }
	|
	var		    {
			    }
	|
	inr_var_list ',' literal    {
			    }
	|
	literal		{
			}
	;
var_list:
	'(' inr_var_list ')'	{
				}
	|
	'(' ')'			{
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
	yyparse();
	return 0;
}

