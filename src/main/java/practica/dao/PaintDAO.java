package practica.dao;
import practica.model.Paint;

import java.util.List;

public interface PaintDAO {

    void save(Paint paint);
    void delete(String name);
    List<Paint> getAllPaints();
    List<Paint> getPaintsByOwner(String owner);

}
