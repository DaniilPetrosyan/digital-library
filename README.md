# digital-library
A small website, the backend of which is written on the drogon framework

# Technologies Used

- **Authentication with JWT** 

- **Object-Relational Mapping (ORM)**  

- **REST API**  


# Application Screenshots
![Alt text](/../screenshots/ScreenApp/HomePage.png?raw=true "Home Page")

<div align="center">
<p><strong>Home page</strong></p>
</div>

![Alt text](/../screenshots/ScreenApp/LibraryPage.png?raw=true "Library Page")

<div align="center">
<p><strong>Library page</strong></p>
</div>

![Alt text](/../screenshots/ScreenApp/UserLibraryPage.png?raw=true "User Library Page")

<div align="center">
<p><strong>User's library page</strong></p>
</div>

<div align="center">
<img src="/../screenshots/ScreenApp/AuthPage.png?raw=true" alt="Auth Page">
<p><strong>Authentication page</strong></p>
</div>

# How to Run the Application

1. **Download and Set Up the Database**  
   Make sure to download and configure the database in advance. Database dumps are available in the repository.

2. **Clone the Repository**  
   Clone the repository using the following command in your terminal:
   ```sh
   git clone https://github.com/DaniilPetrosyan/digital-library
   ```

3. **Navigate to the Build Directory**
   Change to the build directory using the command:
   ```sh
   cd digital-library/build
   ```

4. **Start the Application**
   ```sh
   cmake ..
   make
   ./WebAppCpp
   ```

5. **Open your Browser**
   Open your browser and navigate to the address: https://localhost

### Possible Errors

1. **Missing Required Libraries**  
   `cmake` will indicate if any required libraries are missing.

2. **No Connection to the Database**  
   Ensure the database is running and accessible.

3. **No Internet Connection**  
   Verify that your machine is connected to the internet.

4. **Check the `config.json` File**  
   Ensure the following settings are correctly configured:
   - `ssl` settings
   - `db_clients` settings
