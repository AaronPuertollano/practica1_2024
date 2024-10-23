package practica.service;

import practica.model.User;
import practica.dao.UserDAO;
import practica.dao.UserDAOInMemory;

public class LoginService {
    static UserDAO userDAO = new UserDAOInMemory();
    public static User checkUser(String username, String password){
        User user = userDAO.findByUsernameAndPassword(username, password);

        return user;
    }
}
