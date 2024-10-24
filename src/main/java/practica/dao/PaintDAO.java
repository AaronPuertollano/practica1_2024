package practica.dao;
import practica.model.Paint;

import java.util.List;

public interface PaintDAO {

    void save(Paint paint);
    Paint findById(int id);
    List<Paint> findAll();
    void delete(int id);

}
