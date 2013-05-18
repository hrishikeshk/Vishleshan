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
	UInt32 m_first_free_ox;
	
	public:
	
	RBTree():m_root_ox(maxUInt32), m_first_free_ox(maxUInt32){
	}

	Bool insert_element(const Key& k, UInt32& ref_ox);

	Bool find_element(const Key& k, UInt32& ref_ox) const;

	Bool delete_element(const Key& k);

	private:

	void rb_insert_fixup(const UInt32& new_node_ox);

	void rb_delete_fixup(const UInt32& del_node_ox);
};

#endif

