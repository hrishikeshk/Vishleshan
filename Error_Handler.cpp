#include <iostream>
#include "Error_Handler.h"

std::string Error::get_message(err_code ec){

	switch(ec){
		case DUP_MAIN_FUNC:
				return "Duplicate definitions of the \"main\" function found\n";
		default:
			return "";
	};
	return "";
}


Error_Handler::Error_Handler(err_code ec1){
	ec = ec1;	
}

void Error_Handler::print_console(){
	Error er;
	std::cout << er.get_message(ec);	
}

