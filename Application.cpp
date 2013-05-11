#include <getopt.h>
#include <iostream>
#include "TypeDefs.h"

void print_usage(){

}

Int32 main(Int32 argc, char* argv[]){

	Int32 next_option;

	const char* const short_options = "ho:v";

	const struct option long_options[] = {
						{ "help", 0, NULL, 'h'},
						{ "option", 1, NULL, 'o'},
						{ "verbose", 0, NULL, 'v'},
						{ NULL, 0, NULL, 0},
					     };
	const char* exec_name = argv[0];
std::cout << "prog name = " << exec_name << "\n";
	char* arg_input_val;
	do{
		next_option = getopt_long(argc, argv, short_options, long_options, NULL);
		switch(next_option){
			case 'h':
std::cout << "help needed\n";
				break;
			case 'o':
				arg_input_val = optarg;
std::cout << "arg_val = " << arg_input_val << "\n";
				break;
			case 'v':
std::cout << "verbose please\n";
				break;
			case -1:
				break;
			case '?':
				print_usage();
				break;
			default:
				print_usage();
				break;
		};
	} while(next_option != -1);

	for(Int32 i = optind; i < argc; ++i){
		std::cout << argv[i] << "\n";
	}

return 0;
}

