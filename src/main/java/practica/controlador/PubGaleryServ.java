package practica.controlador;

import com.fasterxml.jackson.databind.ObjectMapper;
import practica.dao.PaintDAOInMemory;
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

@WebServlet("/pubgalery")
public class PubGaleryServ extends HttpServlet {

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
            //el ususari no esta autoritzar per veure la pagina
            resp.sendRedirect("/register");
            return;
        }

        List<Paint> publicPaints = paintService.getAllPaints();

        // Convertir a JSON
        ObjectMapper mapper = new ObjectMapper();
        String publicPaintsJson = mapper.writeValueAsString(publicPaints);
        req.setAttribute("publicPaintsJson", publicPaintsJson);

        System.out.println(publicPaintsJson);

        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/public_galey.jsp");
        requestDispatcher.forward(req, resp);
    }
}
