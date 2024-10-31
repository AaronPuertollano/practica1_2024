package practica.controlador;

import practica.model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/paint")
public class PaintServ extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        String nameUser= (String) session.getAttribute("user");

        if (nameUser == null){
            //el ususari no esta autoritzar per veure la pagina
            resp.sendRedirect("/register");
            return;
        }


        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/paint.jsp");
        requestDispatcher.forward(req, resp);
    }
}
