package practica.dao;

import practica.model.Paint;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class PaintDAOInMemory implements PaintDAO{

    private Map<Integer, Paint> storage = new HashMap<>();
    private int currentId = 1;

    @Override
    public void save(Paint paint) {
        // Asigna un ID i es almacena
        storage.put(currentId++, paint);
    }

    @Override
    public void delete(int id) {
        storage.remove(id);
    }

    @Override
    public List<Paint> getPaintsByOwner(String owner) {
        return storage.values().stream()
                .filter(paint -> paint.getOwner().equals(owner))
                .collect(Collectors.toList());
    }

    @Override
    public List<Paint> getAllPaints() {
        return new ArrayList<>(storage.values());
    }

}
