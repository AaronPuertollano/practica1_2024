package practica.model;
import java.util.ArrayList;
import java.util.List;

public class Paint {
    //private List<Figure> figures;

    private String name;
    private String data;
    private String owner;

    @Override
    public String toString() {
        return "Paint{" +
                "name='" + name + '\'' +
                ", data='" + data + '\'' +
                ", owner='" + owner + '\'' +
                '}';
    }

    public Paint(String name, String data, String owner) {
        this.name = name;
        this.data = data;
        this.owner = owner;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }
}
