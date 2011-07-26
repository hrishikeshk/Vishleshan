
bool bar(int a, int b[]){
	bool ret = true;
	if(a == 4){
		a=a+1;
		return ret;
	}
	else{
		a = b[2];
		ret = false;
		return ret;
	}
	return false;
}

void foo(char xyz[], char abc[]){
	
}

int main(int x, char arg[]){
	x = 10;
	char a[10];
	char b[20];
	foo(a, b);
}

