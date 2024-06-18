#pragma once

#include <drogon/HttpController.h>
#include <plugins/jwt_function.h>
#include <json/json.h>

using namespace drogon;

namespace demo
{
namespace v1
{
class Verify : public drogon::HttpController<Verify>
{
  public:
    METHOD_LIST_BEGIN
    // use METHOD_ADD to add your custom processing function here;
    // METHOD_ADD(Verify::get, "/{2}/{1}", Get); // path is /demo/v1/Verify/{arg2}/{arg1}
    // METHOD_ADD(Verify::your_method_name, "/{1}/{2}/list", Get); // path is /demo/v1/Verify/{arg1}/{arg2}/list
    // ADD_METHOD_TO(Verify::your_method_name, "/absolute/path/{1}/{2}/list", Get); // path is /absolute/path/{arg1}/{arg2}/list
    METHOD_ADD(Verify::checkToken, "/token", Post);
    METHOD_LIST_END

    void checkToken(const HttpRequestPtr &req,
               std::function<void (const HttpResponsePtr &)> &&callback);
    // your declaration of processing function maybe like this:
    // void get(const HttpRequestPtr& req, std::function<void (const HttpResponsePtr &)> &&callback, int p1, std::string p2);
    // void your_method_name(const HttpRequestPtr& req, std::function<void (const HttpResponsePtr &)> &&callback, double p1, int p2) const;
};
}
}
