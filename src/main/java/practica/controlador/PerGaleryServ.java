package practica.controlador;

import com.fasterxml.jackson.databind.ObjectMapper;
import practica.model.Paint;
import practica.service.PaintService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/pergalery")
public class PerGaleryServ extends HttpServlet {

    private PaintService paintService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.paintService = PaintService.getInstance(); // Usa el Singleton para mantener una única instancia
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        String nameUser= (String) session.getAttribute("user");

        if (nameUser == null){
            //el usuari no esta autoritzar per veure la pagina
            resp.sendRedirect("/register");
            return;
        }

        List<Paint> userPaints = paintService.getPaintsByOwner(nameUser);

        ObjectMapper mapper = new ObjectMapper();
        String userPaintsJson = mapper.writeValueAsString(userPaints);
        req.setAttribute("userPaintsJson", userPaintsJson);
        System.out.println(userPaintsJson);

        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/personal_galery.jsp");
        requestDispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("delete".equals(action)) {
            String name = req.getParameter("name");

            if (name == null || name.isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            HttpSession session = req.getSession(false);
            if (session == null) {
                resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                return;
            }

            String owner = (String) session.getAttribute("user");
            if (owner == null) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            System.out.println(name);
            System.out.println(owner);

            try {

                boolean deleted = paintService.deletePaintByNameAndOwner(name, owner);

                if (deleted) {
                    resp.setStatus(HttpServletResponse.SC_OK);
                    resp.sendRedirect(req.getRequestURI());
                } else {
                    resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (Exception e) {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                e.printStackTrace();
            }
        } else {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
