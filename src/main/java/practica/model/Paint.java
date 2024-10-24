package practica.model;
import java.util.ArrayList;
import java.util.List;

public class Paint {
    private List<Figure> figures;

    public Paint() {
        this.figures = new ArrayList<>();
    }

    public void addFigure(Figure figure) {
        figures.add(figure);
    }

    public List<Figure> getFigures() {
        return figures;
    }

    public void clearPaint() {
        figures.clear();
    }
}
