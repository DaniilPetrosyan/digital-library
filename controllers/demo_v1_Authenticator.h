#pragma once

#include <drogon/HttpController.h>
#include <drogon/orm/Mapper.h>
#include <json/json.h>
#include <models/AuthserviceDB/Users.h>
#include <plugins/hashpassword.h>
#include <plugins/jwt_function.h>
#include <plugins/checkpassword.h>

using namespace drogon;

namespace demo
{
namespace v1
{
class Authenticator : public drogon::HttpController<Authenticator>
{
  public:
    METHOD_LIST_BEGIN
    // use METHOD_ADD to add your custom processing function here;
    // METHOD_ADD(Authenticator::get, "/{2}/{1}", Get); // path is /demo/v1/Authenticator/{arg2}/{arg1}
    // METHOD_ADD(Authenticator::your_method_name, "/{1}/{2}/list", Get); // path is /demo/v1/Authenticator/{arg1}/{arg2}/list
    // ADD_METHOD_TO(Authenticator::your_method_name, "/absolute/path/{1}/{2}/list", Get); // path is /absolute/path/{arg1}/{arg2}/list
    METHOD_ADD(Authenticator::logining, "/login?login={1}&passwd={2}", Get);
    METHOD_ADD(Authenticator::registrating, "/register", Post);
    METHOD_LIST_END

    void logining(const HttpRequestPtr &req,
               std::function<void (const HttpResponsePtr &)> &&callback,
               std::string &&login,
               const std::string &passwd);

    void registrating(const HttpRequestPtr &req,
               std::function<void (const HttpResponsePtr &)> &&callback);
    // your declaration of processing function maybe like this:
    // void get(const HttpRequestPtr& req, std::function<void (const HttpResponsePtr &)> &&callback, int p1, std::string p2);
    // void your_method_name(const HttpRequestPtr& req, std::function<void (const HttpResponsePtr &)> &&callback, double p1, int p2) const;
};
}
}
