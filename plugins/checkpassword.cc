#include "checkpassword.h"
#include <regex>
#include <iostream>

bool isValidRegexPassword(const std::string& password)
{
    std::string pattern = R"(^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*[#@"'\/\\]).{8,16}$)";
    
    std::regex regexPattern(pattern);

    return std::regex_match(password, regexPattern);
}
