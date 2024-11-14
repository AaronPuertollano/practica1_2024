package practica.dao;

import practica.model.User;

import java.util.ArrayList;
import java.util.List;

public class UserDAOInMemory implements UserDAO{

    public static List<User> users = new ArrayList<>();

    @Override

    public User findByUsernameAndPassword(String username, String password) {
        for (User user : users) {
            if (user.getUsername() != null && user.getUsername().equals(username)
                    && user.getPassword().equals(password)) {
                return user;  // Si encuentra coincidencia, retorna el usuario
            }
        }
        return null;  // Si no encuentra coincidencias, retorna null
    }

    public static boolean usernameExists(String username) {
        return users.stream().anyMatch(user -> user.getUsername().equals(username));
    }

}

