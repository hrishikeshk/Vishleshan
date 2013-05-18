#include "TypeDefs.h"
#include "Consts.h"

#include "Key.h"
#include "RBTree.h"


Bool RBTree::find_element(const Key& k, UInt32& ref_ox) const{

	ref_ox = maxUInt32;
	if(m_root_ox == maxUInt32)
		return false;

	UInt32 exp_ox = m_root_ox;
	RBStatus rs = k.compare(exp_ox);

	while(rs != EQUAL){
		if(rs == LESS){
			exp_ox = m_nodes[exp_ox].m_left_ox;
		}
		else{
			exp_ox = m_nodes[exp_ox].m_right_ox;
		}
		if(exp_ox == maxUInt32)
			return false;
		rs = k.compare(exp_ox);
	}
	ref_ox = exp_ox;
	return true;
}

Bool RBTree::insert_element(const Key& k, UInt32& ref_ox){

	RBNode new_node;
	ref_ox = maxUInt32;
	UInt32 trailer_ox = maxUInt32;
	UInt32 lead_ox = m_root_ox;
	RBStatus rs;
	while(lead_ox != maxUInt32){
		trailer_ox = lead_ox;
		rs = k.compare(lead_ox);
		if(rs == MORE){
			lead_ox = m_nodes[lead_ox].m_right_ox;
		}
		else if(rs == LESS){
			lead_ox = m_nodes[lead_ox].m_left_ox;
		}
		else{
			return false;
		}
	}
	new_node.m_parent_ox = trailer_ox;
	if(trailer_ox == maxUInt32){
		m_root_ox = 0;
		ref_ox = 0;
		return true;
	}
	UInt32 new_node_ox;
	if(m_first_free_ox != maxUInt32){
		new_node_ox = m_first_free_ox;
		m_first_free_ox = m_nodes[m_first_free_ox].m_next_free_ox;
		m_nodes[new_node_ox] = new_node;
	}
	else{
		new_node_ox = m_nodes.size();
		m_nodes.push_back(new_node);
	}
	if(rs == MORE){
		m_nodes[trailer_ox].m_right_ox = new_node_ox;
	}
	else{
		m_nodes[trailer_ox].m_left_ox = new_node_ox;
	}

	rb_insert_fixup(new_node_ox);
	return true;
}

void RBTree::rb_insert_fixup(const UInt32& new_node_ox){

}

Bool RBTree::delete_element(const Key& k){

	return true;
}

void RBTree::rb_delete_fixup(const UInt32& del_node_ox){

}

