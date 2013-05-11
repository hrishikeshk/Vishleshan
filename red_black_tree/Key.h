#ifndef _KEY_
#define _KEY_

enum RBStatus { LESS, EQUAL_TO, MORE };

class Key{
	public:
		virtual ~Key(){
		}

		virtual RBStatus compare(const Key& k) = 0;
};

#endif

