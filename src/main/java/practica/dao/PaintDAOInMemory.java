package practica.dao;

import practica.model.Paint;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PaintDAOInMemory implements PaintDAO{

    private Map<Integer, Paint> storage = new HashMap<>();
    private int currentId = 1;

    @Override
    public void save(Paint paint) {

    }

    @Override
    public Paint findById(int id) {
        return null;
    }

    @Override
    public List<Paint> findAll() {
        return null;
    }

    @Override
    public void delete(int id) {

    }
}
