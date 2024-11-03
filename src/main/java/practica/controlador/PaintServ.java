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
import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;
import java.util.Map;

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

            // Lee el JSON del cuerpo de la solicitud
            BufferedReader reader = req.getReader();
            StringBuilder jsonBuilder = new StringBuilder();
            String line;

            while ((line = reader.readLine()) != null) {
                jsonBuilder.append(line);
            }

            // Convierte el JSON a un objeto
            ObjectMapper mapper = new ObjectMapper();
            Map<String, String> dataMap = mapper.readValue(jsonBuilder.toString(), Map.class);

            // Obtén los valores de "name" y "drawingData" desde el JSON
            String name = dataMap.get("name");
            String drawingData = dataMap.get("drawingData");

            System.out.println("Received name: " + name);
            System.out.println("Received drawingData: " + drawingData);

            HttpSession session = req.getSession();
            String user = (String) session.getAttribute("user");

            // Crear objeto `Paint` y guardarlo
            Paint paint = new Paint(name, drawingData, user);
            boolean success = paintService.savePaint(paint);

            // Configura la respuesta JSON
            resp.setContentType("application/json");
            if (success) {
                resp.getWriter().write("{\"success\": true, \"message\": \"Drawing saved successfully.\"}");
            } else {
                resp.getWriter().write("{\"success\": false, \"message\": \"Failed to save drawing.\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.setContentType("application/json");
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"success\": false, \"message\": \"Server error: " + e.getMessage() + "\"}");
        }


    }
}
