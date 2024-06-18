#include "demo_v1_Verify.h"

using namespace demo::v1;

void Verify::checkToken(const HttpRequestPtr &req,
               std::function<void (const HttpResponsePtr &)> &&callback)
{
    auto json = req->getJsonObject();
    
    if (!json)
    {
        auto resp = HttpResponse::newHttpResponse();
        resp->setStatusCode(k400BadRequest);
        resp->setBody("Invalid JSON");
        callback(resp);
        return;
    }

    Json::Value ret;
    enum drogon::HttpStatusCode statCode;

    if (json->isMember("token") && (*json)["token"].isString())
    {
        ret["result"] = verifyToken((*json)["token"].asString()) == 1 ? "Ok" : "Not Auth";
        statCode = k200OK;
    }
    else
    {
        ret["result"] = "Not Auth";
        statCode = k401Unauthorized;
    }
   
    auto resp = HttpResponse::newHttpJsonResponse(ret);
    resp->setStatusCode(statCode);
    callback(resp);
}
// Add definition of your processing function here
