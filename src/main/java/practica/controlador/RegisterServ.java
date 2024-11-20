package practica.controlador;

import practica.dao.UserDAOInMemory;
import practica.model.User;
import practica.service.LoginService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import static practica.dao.UserDAOInMemory.users;

@WebServlet("/register")
public class RegisterServ extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/register.jsp");
        requestDispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String name = req.getParameter("name");

        String regex = "^[a-zA-Z0-9_-]+$";

        //Parametres per asegurar un acces segur
        if (password == null || password.length() <= 5) {
            req.setAttribute("errorMess", "The password needs 6 or more characters.");
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/register.jsp");
            requestDispatcher.forward(req, resp);
            return;
        }

        if (username.contains(" ")) {
            req.setAttribute("errorMess", "The username should not have spaces.");
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/register.jsp");
            requestDispatcher.forward(req, resp);
            return;
        }

        if (!name.matches(regex) || !username.matches(regex) || !password.matches(regex)) {
            req.setAttribute("errorMess", "Only letters, numbers and hyphens are allowed.");
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/register.jsp");
            requestDispatcher.forward(req, resp);
            return;
        }

        if (UserDAOInMemory.usernameExists(username)) {
            req.setAttribute("errorMess", "The username is already taken.");
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/register.jsp");
            requestDispatcher.forward(req, resp);
            return;
        }

        //Una vegada comprovat que tots el praámetres son correctes es pot crear el ususari
        User user = LoginService.checkUser(username,password);

        if (user == null){
            User newUser = new User(name,username,password);
            UserDAOInMemory.users.add(newUser);
            System.out.println(users);

            //Aquí cream la sessio actual amb el user creat
            HttpSession session = req.getSession();
            session.setAttribute("user", username);
            System.out.println(username);

            resp.sendRedirect("/login");
            return;
        }

        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/register.jsp");
        requestDispatcher.forward(req, resp);
    }
}
