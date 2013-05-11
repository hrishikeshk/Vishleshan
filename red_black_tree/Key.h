#ifndef _KEY_
#define _KEY_

#include "TypeDefs.h"

enum RBStatus { LESS, EQUAL_TO, MORE };

class Key{
	public:
		virtual ~Key(){
		}

		virtual RBStatus compare(const UInt32 cpm_ox) = 0;
};

#endif

