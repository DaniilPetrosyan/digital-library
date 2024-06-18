#include "demo_v1_Authenticator.h"


using namespace demo::v1;

// Add definition of your processing function here
void Authenticator::logining(const HttpRequestPtr &req,
               std::function<void (const HttpResponsePtr &)> &&callback,
               std::string &&login,
               const std::string &passwd)
{
    // LOG_DEBUG<<"User "<< login <<" login" << " Pass " << hashPassword(login + passwd);

    LOG_DEBUG << "TOKEN: " << login;
    // LOG_DEBUG << "TOKEN_VER: " << verifyToken(tmpsrr, "secret_key");

    drogon::orm::Mapper<drogon_model::authservice::Users> mapperForLogin(drogon::app().getDbClient("authcon"));

    auto users = mapperForLogin.findBy((drogon::orm::Criteria(drogon_model::authservice::Users::Cols::_login, drogon::orm::CompareOperator::Like, login)
     && drogon::orm::Criteria(drogon_model::authservice::Users::Cols::_password, drogon::orm::CompareOperator::Like, hashPassword(login + passwd))));

    Json::Value ret;

    if (users.empty())
    {
        ret["result"] = "Not Found";
    }
    else
    {
        ret["result"] = "Found";
        ret["token"] = createToken(login);
    }

    auto resp=HttpResponse::newHttpJsonResponse(ret);

    callback(resp);
}

void Authenticator::registrating(const HttpRequestPtr &req,
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
    std::string login;
    std::string pass;

    drogon::orm::Mapper<drogon_model::authservice::Users> mapperForRegister(drogon::app().getDbClient("authcon"));

    drogon_model::authservice::Users newUser;
    
    if (json->isMember("login") && (*json)["login"].isString() && json->isMember("password") && (*json)["password"].isString())
    {
        login = (*json)["login"].asString();

        if (!isValidRegexPassword((*json)["password"].asString()) || !(login.length() >= 3 && login.length() <= 20))
        {
            ret["result"] = "Error password";
            auto resp=HttpResponse::newHttpJsonResponse(ret);
            callback(resp);
            return;
        }

        pass = hashPassword(login + ((*json)["password"].asString()));
    }

    if (!mapperForRegister.findBy(drogon::orm::Criteria(drogon_model::authservice::Users::Cols::_login, drogon::orm::CompareOperator::Like, login)).empty())
    {
        // LOG_DEBUG << "Такой пользователь есть!!!";
        ret["result"] = "Exists";
        auto resp=HttpResponse::newHttpJsonResponse(ret);
        callback(resp);
        return;
    }

    // LOG_DEBUG << "login: " << login << " pass: " << pass;

    newUser.setLogin(login);
    newUser.setPassword(pass);

    mapperForRegister.insert(newUser);

    ret["result"] = "Created";
    auto resp = HttpResponse::newHttpJsonResponse(ret);
    resp->setStatusCode(k201Created);
    callback(resp);
}