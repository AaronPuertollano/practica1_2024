package practica.service;

import practica.dao.PaintDAO;
import practica.dao.PaintDAOInMemory;
import practica.model.Paint;

import java.util.List;
import java.util.stream.Collectors;

public class PaintService {

    private static PaintService instance;
    private PaintDAO paintDAO = new PaintDAOInMemory();

    public PaintService() {

    }

    public static PaintService getInstance() {
        if (instance == null) {
            instance = new PaintService();
        }
        return instance;
    }

    public boolean savePaint(Paint paint) {
        try {
            paintDAO.save(paint);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Paint> getAllPaints() {
        return paintDAO.getAllPaints();
    }

    public List<Paint> getPaintsByOwner(String owner) {
        return paintDAO.getPaintsByOwner(owner);
    }

}
