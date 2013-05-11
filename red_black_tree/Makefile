
INCLUDES=-I $(SRC_DIR) -I $(SRC_DIR)/red_black_tree

WARN=-Wall

DEBUG=-g -ggdb

CC=g++

SHAREDLIB_FLAGS=-shared -fPIC

FPIC_OBJ=-fPIC

rbtree.so: rbtree.o
	$(CC) $(WARN) $(DEBUG) $(SHAREDLIB_FLAGS) -o rbtree.so rbtree.o

rbtree.o: RBNode.h Key.h
	$(CC) $(WARN) $(DEBUG) $(INCLUDES) $(FPIC_OBJ) -o rbtree.o -c RBTree.cpp 

.PHONY: clean

clean:
	rm -rf *.o *.so *.a
