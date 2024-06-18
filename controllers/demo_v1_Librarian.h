#pragma once

#include <drogon/HttpController.h>
#include <drogon/orm/Mapper.h>
#include <json/json.h>
#include <models/LibraryBooksDB/AuthorBook.h>
#include <models/LibraryBooksDB/Books.h>
#include <models/LibraryBooksDB/Authors.h>
#include <models/LibraryUserDB/UserBooks.h>

using namespace drogon;

namespace demo
{
namespace v1
{
class Librarian : public drogon::HttpController<Librarian>
{
  public:
    METHOD_LIST_BEGIN
    // use METHOD_ADD to add your custom processing function here;
    // METHOD_ADD(Librarian::get, "/{2}/{1}", Get); // path is /demo/v1/Librarian/{arg2}/{arg1}
    // METHOD_ADD(Librarian::your_method_name, "/{1}/{2}/list", Get); // path is /demo/v1/Librarian/{arg1}/{arg2}/list
    // ADD_METHOD_TO(Librarian::your_method_name, "/absolute/path/{1}/{2}/list", Get); // path is /absolute/path/{arg1}/{arg2}/list
    METHOD_ADD(Librarian::getLibraryBooks, "/books", Get);
    METHOD_ADD(Librarian::getLibraryUser, "/books/user?user={1}", Get);
    METHOD_ADD(Librarian::checkBookUser, "books/user/book/author/{1}/{2}/{3}", Get);
    METHOD_ADD(Librarian::deleteBookUser, "books/user/book/author/{1}/{2}/{3}", Delete);
    METHOD_ADD(Librarian::addBookUser, "books/user/book/author/set", Post);
    METHOD_LIST_END

    void getLibraryBooks(const HttpRequestPtr &req,
               std::function<void (const HttpResponsePtr &)> &&callback);

    void getLibraryUser(const HttpRequestPtr &req,
               std::function<void (const HttpResponsePtr &)> &&callback,
               std::string &&user);

    void checkBookUser(const HttpRequestPtr &req,
               std::function<void(const HttpResponsePtr &)> &&callback,
               const std::string &user,
               const std::string &book,
               const std::string &author);

    void deleteBookUser(const HttpRequestPtr &req,
               std::function<void(const HttpResponsePtr &)> &&callback,
               const std::string &user,
               const std::string &book,
               const std::string &author);

    void addBookUser(const HttpRequestPtr &req,
               std::function<void(const HttpResponsePtr &)> &&callback);
    // your declaration of processing function maybe like this:
    // void get(const HttpRequestPtr& req, std::function<void (const HttpResponsePtr &)> &&callback, int p1, std::string p2);
    // void your_method_name(const HttpRequestPtr& req, std::function<void (const HttpResponsePtr &)> &&callback, double p1, int p2) const;
};
}
}
