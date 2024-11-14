package practica.controlador;

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

@WebServlet ("/login")
public class LoginServ extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
        requestDispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = LoginService.checkUser(username,password);

        if (user != null && user.getUsername() != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", username);  // Guardar el objeto User en la sesion
                System.out.println(username);
                resp.sendRedirect("/paint");
                return;
        } else {
            req.setAttribute("message", "User or password incorrect");
        }

        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
        requestDispatcher.forward(req, resp);
    }
}
