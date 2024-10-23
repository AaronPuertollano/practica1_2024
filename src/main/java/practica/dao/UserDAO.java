package practica.dao;

import practica.model.User;

public interface UserDAO {

    User findByUsernameAndPassword(String username, String password);

}
