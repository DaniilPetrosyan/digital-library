export function addBookCard(imageSrc, title, author, idAuthor, idBook) {
    const bookId = `${idAuthor}-${idBook}`;
    const bookCardsContainer = document.querySelector('.book-cards');

    const li = document.createElement('li');
    li.id = bookId;

    const img = document.createElement('img');
    img.src = imageSrc;
    img.alt = `Обложка книги ${title}`;
    img.width = 170;
    img.height = 256;

    const bookInfo = document.createElement('div');
    bookInfo.classList.add('book-info');

    const h2 = document.createElement('h2');
    h2.textContent = title;

    const pAuthor = document.createElement('p');
    pAuthor.classList.add('author');
    pAuthor.textContent = `Автор: ${author}`;

    const buttonContainer = document.createElement('div');
    buttonContainer.classList.add('button-container');

    const readButton = document.createElement('button');
    readButton.textContent = 'Читать';
    readButton.classList.add('read-button');

    const addButton = document.createElement('button');
    addButton.textContent = 'Добавить';
    addButton.classList.add('add-button');

    if ('https://192.168.60.132/library.html' == window.location.href) {
      const requestCheckURL = `/demo/v1/Librarian/books/user/book/author/${sessionStorage.getItem("login")}/${idBook}/${idAuthor}`;
      const xhrCheck = new XMLHttpRequest();
      xhrCheck.open("GET", requestCheckURL);
      
      xhrCheck.onload = function() {
        if (xhrCheck.status == 200) {
          addButton.textContent = 'Удалить';
        }
      };

      xhrCheck.send();
    } else {
      addButton.textContent = 'Удалить';
    }

    buttonContainer.appendChild(readButton);
    buttonContainer.appendChild(addButton);

    bookInfo.appendChild(h2);
    bookInfo.appendChild(pAuthor);
    li.appendChild(img);
    li.appendChild(bookInfo);
    li.appendChild(buttonContainer);

    bookCardsContainer.appendChild(li);
}
