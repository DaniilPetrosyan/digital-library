document.getElementById("228228").onclick = function() {
    

    const log = document.getElementById("logfield");
    const pwd = document.getElementById("pwdfield");

    const requestURL = '/demo/v1/Authenticator/login?login=' + log.value + '&passwd=' + pwd.value;

    const xhr = new XMLHttpRequest();

    xhr.open('GET', requestURL);

    xhr.onload = function() {
      if (xhr.status >= 200 && xhr.status < 300) {
        try {
            const responseJson = JSON.parse(xhr.responseText);
            
            if (responseJson["result"] == "Found") {
              document.getElementById("error-message").style.display = 'none';
              sessionStorage.setItem("token", responseJson["token"]);
              sessionStorage.setItem("login", log.value);
              window.location = 'https://192.168.60.132';
            } else {
              document.getElementById("error-message").style.display = 'block';
            }
        } catch (error) {
            console.error('Failed to parse JSON response:', error);
        }

          
      } else {
          console.error('Error:', xhr.statusText);
      }
  };

  xhr.onerror = function() {
      console.error('Network Error');
  };

    xhr.send();
  }

  document.getElementById("regis_btn").onclick = function() {
    window.location = 'https://192.168.60.132/register.html';
  }