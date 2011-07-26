
int foo(int ar[]){

	return ar[0];
}

int main(){

	int ar[10];
	int x = 0;
	while(x < foo(ar)){
		x = ar[x];
		x = x + x;
		x = ar[2];
	}
}
