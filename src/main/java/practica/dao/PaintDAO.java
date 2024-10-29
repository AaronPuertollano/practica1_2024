package practica.dao;
import practica.model.Paint;

import java.util.List;

public interface PaintDAO {

    void save(Paint paint);
    void delete(int id);

}
