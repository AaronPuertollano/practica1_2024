package practica.model;

import java.util.List;

public class Canvas {

    private List<Paint> paints;

    public Canvas(List<Paint> paints) {
        this.paints = paints;
    }

    public List<Paint> getPaints() {
        return paints;
    }

    public void setPaints(List<Paint> paints) {
        this.paints = paints;
    }

}
