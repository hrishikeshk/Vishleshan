#ifndef _RBTREE_
#define _RBTREE_

#include "TypeDefs.h"
#include "Consts.h"
#include "RBNode.h"
#include "Key.h"
#include <boost/typeof/std/vector.hpp>

class RBTree{
	UInt32 m_root_ox;
	std::vector<RBNode> m_nodes;
	
	public:
	
	RBTree():m_root_ox(maxUInt32){
	}

	Bool insert_element(const Key& k);

	Bool find_element(const Key& k);

	Bool delete_element(const Key& k);
};

#endif

