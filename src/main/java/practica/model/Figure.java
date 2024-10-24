package practica.model;

public class Figure {

    String type;
    String color;
    int size;
    int x, y;  // coordenadas de la figura en el canvas
    boolean filled;

    public Figure(String type, String color, int size, int x, int y, boolean filled) {
        this.type = type;
        this.color = color;
        this.size = size;
        this.x = x;
        this.y = y;
        this.filled = filled;
    }

    public String getType() {
        return type;
    }

    public String getColor() {
        return color;
    }

    public int getSize() {
        return size;
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }

    public boolean isFilled() {
        return filled;
    }
}
