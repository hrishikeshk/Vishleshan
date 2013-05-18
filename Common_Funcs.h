#ifndef _COMMON_FUNCS_
#define _COMMON_FUNCS_

#include <assert.h>
#include <iostream>
#include "TypeDefs.h"
#include <string>

Bool v_assert(Bool val, const std::string& mesg){
#ifdef _DEBUG_BUILD_
	if(val == false){
		std::cout << mesg << "\n";
	}
	assert(val);
#else
	if(val == false){
		std::cerr << "*********** \n FATAL problem detected\n ***********\n";
		std::cerr << mesg << "\n";
	}
#endif
	return val;
}

#endif

