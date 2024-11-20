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

    private PaintService paintService = PaintService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        String nameUser= (String) session.getAttribute("user");

        if (nameUser == null){
            //el usuari no esta autoritzar per veure la pagina
            resp.sendRedirect("/register");
            return;
        }

        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/paint.jsp");
        requestDispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {

            BufferedReader reader = req.getReader();
            StringBuilder jsonBuilder = new StringBuilder();
            String line;

            while ((line = reader.readLine()) != null) {
                jsonBuilder.append(line);
            }

            // Convirteix el JSON a un objete
            ObjectMapper mapper = new ObjectMapper();
            Map<String, String> dataMap = mapper.readValue(jsonBuilder.toString(), Map.class);

            String name = dataMap.get("name");
            String drawingData = dataMap.get("drawingData");

            // Validacio de nom

            if (name == null || name.trim().isEmpty()) {
                int num = (int) (Math.random() * 9000);
                name = "Random" + String.valueOf(num);
            }

            if (name.trim().isEmpty()) {
                resp.setContentType("application/json");
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                System.out.println("Try another name.");
                return;
            }

            if (!name.matches("^[a-zA-Z0-9_ ]+$")) {
                resp.setContentType("application/json");
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                System.out.println("Invalid characters, try another name.");
                return;
            }

            System.out.println("Received name: " + name);
            System.out.println("Received drawingData: " + drawingData);

            HttpSession session = req.getSession();
            String user = (String) session.getAttribute("user");

            // Crear i guardam objecte paint
            Paint paint = new Paint(name, drawingData, user);
            boolean success = paintService.savePaint(paint);

            // Resposta JSON
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
