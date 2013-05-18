#ifndef _KEY_
#define _KEY_

#include "TypeDefs.h"

enum RBStatus { LESS, EQUAL, MORE };

class Key{
	public:
		virtual ~Key(){
		}

		virtual RBStatus compare(const UInt32 cpm_ox) const = 0;
};

#endif

