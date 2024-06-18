#include "jwt_function.h"
#include "config_jwt.h"
#include <jwt-cpp/jwt.h>



std::string createToken(const std::string& login)
{
    auto token = jwt::create()
        .set_issuer(ISSUER_NAME)
        .set_type("JWS")
        .set_payload_claim("login", jwt::claim(login))
        .set_expires_at(std::chrono::system_clock::now() + std::chrono::minutes{60})
        .sign(jwt::algorithm::hs256{SECRET_KEY_JWT});

    return token;
}

bool verifyToken(const std::string& token)
{
    bool flag = false;

    try
    {
        auto decoded = jwt::decode(token);
        auto verifier = jwt::verify()
            .allow_algorithm(jwt::algorithm::hs256{SECRET_KEY_JWT})
            .with_issuer(ISSUER_NAME);

        verifier.verify(decoded);
        
        flag = true;
    }
    catch (const std::exception& e)
    {
        flag = false;
    }

    return flag;
}