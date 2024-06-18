document.getElementById("regbutn").onclick = function(){
    

    const log = document.getElementById("logfield");
    const pwd = document.getElementById("pwdfield");
    const pwdrep = document.getElementById("pwdfieldrepeat");

    if (pwd.value != pwdrep.value) {
        return;
    }

    const requestURL = '/demo/v1/Authenticator/register';

    const xhr = new XMLHttpRequest();

    xhr.open('POST', requestURL);
    xhr.setRequestHeader('Content-Type', 'application/json');

    xhr.onload = function() {
        const state = 0
        if (xhr.status >= 200 && xhr.status < 300) {
          try {
              const responseJson = JSON.parse(xhr.responseText);
              
              if (responseJson["result"] == "Created") {
                document.getElementById("error-message").style.display = 'none';
                document.getElementById("rule-message").style.display = 'none';
                
                window.location.replace('https://192.168.60.132');
              } else {
                if (responseJson["result"] == "Exists") {
                    document.getElementById("error-message").style.display = 'block';
                } else {
                    document.getElementById("error-message").style.display = 'none';
                }

                if (responseJson["result"] == "Error password") {
                    document.getElementById("rule-message").style.display = 'block';
                } else {
                    document.getElementById("rule-message").style.display = 'none';
                }
              }
          } catch (error) {
              console.error('Failed to parse JSON response:', error);
          }
  
            
        } else {
            console.error('Error:', xhr.statusText);
        }
    };

    const body = {
        "login": log.value,
        "password": pwd.value
    }

    xhr.send(JSON.stringify(body));
  }