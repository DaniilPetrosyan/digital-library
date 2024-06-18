const nav = document.querySelector('#nav');
const navBtn = document.querySelector('#nav-btn');
const navBtnImg = document.querySelector('#nav-btn-img');

navBtn.onclick = () => {
    if (nav.classList.toggle('open')) {
        navBtnImg.src = "./img/icons/nav-close.svg";
    } else {
        navBtnImg.src = './img/icons/nav-open.svg';
    }
}

document.getElementById("sign_btn").onclick = function() {
    if (document.getElementById("sign_btn").textContent == 'Выход') {
        sessionStorage.clear();
    }
}

document.addEventListener('DOMContentLoaded', function() {
    
    const token = sessionStorage.getItem("token");
    const login = sessionStorage.getItem("login");
    
    if (token !== null && login !== null) {
        document.getElementById('login_field').textContent = login;
        document.getElementById('sign_btn').textContent = 'Выход';
        document.getElementById('sign_btn').href = 'index.html';
    }
    else {
        document.getElementById('login_field').textContent = '';
        document.getElementById('sign_btn').textContent = 'Войти';
        document.getElementById('sign_btn').href = 'auth.html';
    }
});

AOS.init();