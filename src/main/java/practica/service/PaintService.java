package practica.service;

import practica.dao.PaintDAO;
import practica.dao.PaintDAOInMemory;
import practica.model.Paint;

public class PaintService {
    private PaintDAO paintDAO = new PaintDAOInMemory();

    // Cambia el método `savePaint` para que NO sea estático
    public boolean savePaint(Paint paint) {
        try {
            paintDAO.save(paint);  // Guardar el dibujo en la capa de persistencia
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
