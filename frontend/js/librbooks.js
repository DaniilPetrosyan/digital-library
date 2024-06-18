import {addBookCard} from './createritem.js';

document.getElementById("sign_btn").onclick = function() {
    if (document.getElementById("sign_btn").textContent == 'Выход') {
        sessionStorage.clear();
    }
}

document.addEventListener('DOMContentLoaded', function() {

    const requestURL = '/demo/v1/Librarian/books';
    const requestCheckURL = '/demo/v1/Verify/token';

    const xhrTokenCheck = new XMLHttpRequest();
    const xhr = new XMLHttpRequest();

    xhrTokenCheck.open('POST', requestCheckURL);
    xhr.open('GET', requestURL);

    xhrTokenCheck.setRequestHeader('Content-Type', 'application/json');

    xhrTokenCheck.onload = function() {
        try {
            const responseJson = JSON.parse(xhrTokenCheck.responseText);
            
            if (responseJson["result"] == "Ok") {
                document.getElementById('login_field').textContent = sessionStorage.getItem('login');
                document.getElementById('sign_btn').textContent = 'Выход';
                document.getElementById('sign_btn').href = 'index.html';
            } else {
                window.location.replace('https://192.168.60.132/auth.html');
            }
        } catch (error) {
            console.error('Failed to parse JSON response:', error);
        }
    };

    xhr.onload = function() {
        if (xhr.status >= 200 && xhr.status < 300) {
          try {
              const responseJson = JSON.parse(xhr.responseText);
    
              responseJson.forEach(item => {
                addBookCard(item.image_path, item.book_title, item.author_name, item.author_id, item.book_id);
              });
          } catch (error) {
              console.error('Failed to parse JSON response:', error);
          }
  
            
        } else {
            console.error('Error:', xhr.statusText);
        }
    };

    const body = {
        "token": sessionStorage.getItem("token")
    }
   
    xhrTokenCheck.send(JSON.stringify(body));
    xhr.send();

    
});

document.querySelector('.book-cards').addEventListener('click', function(event) {
    const target = event.target;
    const li = target.closest('li');

    if (!li) return; // Если клик не по элементу списка, ничего не делаем

    const bookId = li.id;

    const authorAndBook = bookId.split('-');

    if (target.classList.contains('read-button')) {
        console.log(`Читать книгу с ID: ${bookId}`);
        // Логика для кнопки "Читать"
    }
    
    if (target.classList.contains('add-button')) {
        // Логика для кнопки "Добавить"
        if (target.textContent == 'Удалить') {
            const requestDeleteURL = `/demo/v1/Librarian/books/user/book/author/${sessionStorage.getItem("login")}/${authorAndBook[1]}/${authorAndBook[0]}`;
            const xhrDelete = new XMLHttpRequest();
            xhrDelete.open("DELETE", requestDeleteURL);

            xhrDelete.onload = function() {
                if (xhrDelete.status == 200) {
                    target.textContent = 'Добавить';
                }
            };

            xhrDelete.send();
        } else if (target.textContent == 'Добавить') {
            const requestAddURL = '/demo/v1/Librarian/books/user/book/author/set';
            const xhrAdd = new XMLHttpRequest();
            xhrAdd.open("POST", requestAddURL);
            xhrAdd.setRequestHeader('Content-Type', 'application/json');


            xhrAdd.onload = function() {
                if (xhrAdd.status == 201) {
                    target.textContent = 'Удалить';
                }
            };

            const body = {
                "user": sessionStorage.getItem("login"),
                "book": parseInt(authorAndBook[1], 10),
                "author": parseInt(authorAndBook[0], 10)
            }

            xhrAdd.send(JSON.stringify(body));
        }
    }
});