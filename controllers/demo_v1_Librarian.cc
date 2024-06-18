#include "demo_v1_Librarian.h"

using namespace demo::v1;

// Add definition of your processing function here
void Librarian::getLibraryBooks(const HttpRequestPtr &req,
               std::function<void (const HttpResponsePtr &)> &&callback)
{
    auto client = drogon::app().getDbClient("librarycon");

    drogon::orm::Mapper<drogon_model::librarybooks::Books> mapperBooks(client);
    drogon::orm::Mapper<drogon_model::librarybooks::Authors> mapperAuthors(client);
    drogon::orm::Mapper<drogon_model::librarybooks::AuthorBook> mapperAuthorBook(client);

    auto futureRes = client->execSqlAsyncFuture(
        "SELECT ab.book_id, b.title AS book_title, ab.author_id, a.name AS author_name, b.image_path "
        "FROM author_book ab "
        "JOIN books b ON ab.book_id = b.id "
        "JOIN authors a ON ab.author_id = a.id;"
    );

    try
    {
        auto result = futureRes.get();

        Json::Value jsonResult(Json::arrayValue);

        for (auto row : result)
        {
            Json::Value jsonItem;

            jsonItem["book_id"] = row["book_id"].as<int>();
            jsonItem["book_title"] = row["book_title"].as<std::string>();
            jsonItem["author_id"] = row["author_id"].as<int>();
            jsonItem["author_name"] = row["author_name"].as<std::string>();
            jsonItem["image_path"] = row["image_path"].as<std::string>();

            jsonResult.append(jsonItem);
        }

        auto resp = HttpResponse::newHttpJsonResponse(jsonResult);
        resp->setStatusCode(k200OK);
        callback(resp);
    }
    catch (const drogon::orm::DrogonDbException &e)
    {
        std::cerr << "Error: " << e.base().what() << std::endl;
    }

    
}

void Librarian::getLibraryUser(const HttpRequestPtr &req,
               std::function<void (const HttpResponsePtr &)> &&callback,
               std::string &&user)
{
    Json::Value jsonResult(Json::arrayValue);

    auto client = drogon::app().getDbClient("librarycon");

    drogon::orm::Mapper<drogon_model::librarybooks::Books> mapperBooks(client);
    drogon::orm::Mapper<drogon_model::librarybooks::Authors> mapperAuthors(client);

    drogon::orm::Mapper<drogon_model::libraryuser::UserBooks> mapperUserBook(drogon::app().getDbClient("userlibrarycon"));

    auto criteriaForUser = drogon::orm::Criteria(drogon_model::libraryuser::UserBooks::Cols::_login_user, drogon::orm::CompareOperator::Like, user);

    try
    {
        auto userAuthorsAndBooks = mapperUserBook.findBy(criteriaForUser);

        for (const auto &userAuthorAndBook : userAuthorsAndBooks)
        {
            Json::Value jsonItem;

            auto bookId = userAuthorAndBook.getValueOfBookId();
            auto authorId = userAuthorAndBook.getValueOfAuthorId();

            auto criteriaForBook = drogon::orm::Criteria(drogon_model::librarybooks::Books::Cols::_id, drogon::orm::CompareOperator::EQ, bookId);
            auto criteriaForAuthor = drogon::orm::Criteria(drogon_model::librarybooks::Authors::Cols::_id, drogon::orm::CompareOperator::EQ, authorId);

            auto book = mapperBooks.findOne(criteriaForBook);
            auto author = mapperAuthors.findOne(criteriaForAuthor);

            jsonItem["image_path"] = book.getValueOfImagePath();
            jsonItem["book_title"] = book.getValueOfTitle();
            jsonItem["author_name"] = author.getValueOfName();
            jsonItem["author_id"] = authorId;
            jsonItem["book_id"] = bookId;

            jsonResult.append(jsonItem);
        }
    }
    catch(const std::exception& e)
    {
        auto resp = HttpResponse::newHttpResponse();;
        resp->setStatusCode(k400BadRequest);
        callback(resp);
        return;
    }

    auto resp = HttpResponse::newHttpJsonResponse(jsonResult);
    resp->setStatusCode(k200OK);
    callback(resp);
}

void Librarian::checkBookUser(const HttpRequestPtr &req,
               std::function<void(const HttpResponsePtr &)> &&callback,
               const std::string &user,
               const std::string &book,
               const std::string &author)
{
    drogon::orm::Mapper<drogon_model::libraryuser::UserBooks> mapperUserBook(drogon::app().getDbClient("userlibrarycon"));

    auto criteria = drogon::orm::Criteria(drogon_model::libraryuser::UserBooks::Cols::_login_user, drogon::orm::CompareOperator::Like, user)
        && drogon::orm::Criteria(drogon_model::libraryuser::UserBooks::Cols::_book_id, drogon::orm::CompareOperator::EQ, book)
        && drogon::orm::Criteria(drogon_model::libraryuser::UserBooks::Cols::_author_id, drogon::orm::CompareOperator::EQ, author);

    auto findUserBook =  mapperUserBook.findBy(criteria);

    enum drogon::HttpStatusCode statCode;

    if (findUserBook.empty())
    {
        statCode = k204NoContent;
    }
    else
    {
        statCode = k200OK;
    }

    auto resp = HttpResponse::newHttpResponse();;
    resp->setStatusCode(statCode);
    callback(resp);
}

void Librarian::deleteBookUser(const HttpRequestPtr &req,
               std::function<void(const HttpResponsePtr &)> &&callback,
               const std::string &user,
               const std::string &book,
               const std::string &author)
{
    drogon::orm::Mapper<drogon_model::libraryuser::UserBooks> mapperUserBook(drogon::app().getDbClient("userlibrarycon"));

    auto criteria = drogon::orm::Criteria(drogon_model::libraryuser::UserBooks::Cols::_login_user, drogon::orm::CompareOperator::Like, user)
        && drogon::orm::Criteria(drogon_model::libraryuser::UserBooks::Cols::_book_id, drogon::orm::CompareOperator::EQ, book)
        && drogon::orm::Criteria(drogon_model::libraryuser::UserBooks::Cols::_author_id, drogon::orm::CompareOperator::EQ, author);

    enum drogon::HttpStatusCode statCode;

    size_t count = mapperUserBook.deleteBy(criteria);

    if (count > 0)
    {
        statCode = k200OK;
    }
    else
    {
        statCode = k204NoContent;
    }

    auto resp = HttpResponse::newHttpResponse();;
    resp->setStatusCode(statCode);
    callback(resp);
}

void Librarian::addBookUser(const HttpRequestPtr &req,
               std::function<void(const HttpResponsePtr &)> &&callback)
{
    auto json = req->getJsonObject();

    drogon::orm::Mapper<drogon_model::libraryuser::UserBooks> mapperUserBook(drogon::app().getDbClient("userlibrarycon"));

    drogon_model::libraryuser::UserBooks newBook;

    if (!json
        && !(json->isMember("user") && (*json)["user"].isString()
        && json->isMember("book") && (*json)["book"].isInt()
        && json->isMember("author") && (*json)["author"].isInt()))
    {
        auto resp = HttpResponse::newHttpResponse();
        resp->setStatusCode(k400BadRequest);
        resp->setBody("Invalid JSON");
        callback(resp);
        return;
    }

    newBook.setLoginUser((*json)["user"].asString());
    newBook.setBookId((*json)["book"].asInt());
    newBook.setAuthorId((*json)["author"].asInt());

    mapperUserBook.insert(newBook);

    auto resp = HttpResponse::newHttpResponse();;
    resp->setStatusCode(k201Created);
    callback(resp);
}