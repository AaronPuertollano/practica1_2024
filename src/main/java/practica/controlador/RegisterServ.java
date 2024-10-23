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

        User user = LoginService.checkUser(username,password);

        if (user == null){
            User newUser = new User(name,username,password);
            UserDAOInMemory.users.add(newUser);
            resp.sendRedirect("/paint");
            return;
        }

        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/register.jsp");
        requestDispatcher.forward(req, resp);
    }
}
