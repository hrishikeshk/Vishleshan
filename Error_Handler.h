#ifndef ERROR_HANDLER

#define ERROR_HANDLER

#include <string>

enum err_code{DUP_MAIN_FUNC};

class Error{

	public:
		std::string get_message(err_code ec);
};


class Error_Handler {

	err_code ec;
	public:
		Error_Handler(err_code ec1);

		void print_console();
};

#endif

