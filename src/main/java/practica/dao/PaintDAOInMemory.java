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
        // Asigna un ID único y almacena el Paint en el almacenamiento en memoria
        storage.put(currentId++, paint);
    }

    @Override
    public void delete(int id) {
        // Elimina el dibujo del almacenamiento si existe
        storage.remove(id);
    }

    // Métodos adicionales para obtener datos, si se necesitan
    public Paint getPaintById(int id) {
        return storage.get(id);
    }

}
