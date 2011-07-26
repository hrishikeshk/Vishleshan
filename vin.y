%{

#include <stdio.h>
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
}

%token PTR PDT_INT PDT_CHAR PDT_DOUBLE PDT_BOOL PDT_VOID IF ELSE WHILE RETURN VAR_NAME OP_DOT OP_EQL TRUE FALSE STRUCT BREAK CONTINUE CHAR_LITERAL

%token <intv> INT_LITERAL
%token <dblv> DOUBLE_LITERAL
%token <strv> STRING_LITERAL

%type <nptr> C_U stmts stmt pdt expr literal var var_decl fn_decl arg_list stmt_blk var_list fn_inv loop_cons var_decl_init ifx struct_decl inr_stmt_blk inr_arg_list inr_var_list array_var

%start C_U

%left '<' '>'
%left '+' '-'
%left '*' '/'
%left '='

%%

C_U:
	stmts     {
			process_node(10);
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
	     }
     |
     PDT_DOUBLE {
		}
     |
     PDT_BOOL  {
	       }
     |
     PDT_VOID  {
	       }
     |
     PDT_CHAR   {
		}
     ;
array_var:
	var '[' array_var ']'	{
				}
	|
	var			{
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
			     }
	|
	var PTR VAR_NAME  {
			     }
	| 
	VAR_NAME		{
				}
	;
literal: INT_LITERAL  {
		   }
	|
	DOUBLE_LITERAL {
			}
	|
	STRING_LITERAL {
			}
	|
	TRUE		{
			}
	|
	FALSE		{
			}
	|
	CHAR_LITERAL	{
			}
	;

%%

int main(int argc, char* argv[]){
	yyparse();
	return 0;
}

