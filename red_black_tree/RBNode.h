#ifndef _RBNODE_
#define _RBNODE_

#include "TypeDefs.h"
#include "Consts.h"

enum color { BLACK, RED };

struct RBNode{
	color m_color;

	UInt32 m_parent_ox;
	UInt32 m_left_ox;
	UInt32 m_right_ox;

	RBNode():m_color(BLACK), m_parent_ox(maxUInt32), m_left_ox(maxUInt32), m_right_ox(maxUInt32){
	}
};

#endif

