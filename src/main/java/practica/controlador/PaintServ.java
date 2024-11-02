package practica.controlador;

import practica.model.Figure;
import practica.model.Paint;
import practica.model.User;
import practica.service.PaintService;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/paint")
public class PaintServ extends HttpServlet {
    private PaintService paintService = new PaintService();
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

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            String name = req.getParameter("name");
            String drawingData = req.getParameter("drawingData");

            System.out.println("Received name: " + name);
            System.out.println("Received drawingData: " + drawingData);

            HttpSession session = req.getSession();
            //User user = (User) session.getAttribute("user");
            String user = (String) session.getAttribute("user");

            // Crear objeto `Paint` y guardarlo
            Paint paint = new Paint(name, drawingData ,user);

            System.out.println(paint);

        } catch (Exception e) {
            e.printStackTrace();  // Esto imprimirá la excepción en el log
            resp.setContentType("application/json");
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"success\": false, \"message\": \"Server error: " + e.getMessage() + "\"}");
        }


    }
}
