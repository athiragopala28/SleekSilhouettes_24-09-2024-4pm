package bean;

public class MaterialBean {

    private int materialId;
    private String material_name;
    private String material_type;
    private String description;

    // Default constructor
    public MaterialBean() {
    }

    // Parameterized constructor
    public MaterialBean(int materialId, String name, String type, String description) {
        this.materialId = materialId;
        this.material_name = name;
        this.material_type = type;
        this.description = description;
    }

    // Getter and setter methods
    public int getMaterialId() {
        return materialId;
    }

    public void setMaterialId(int materialId) {
        this.materialId = materialId;
    }

    public String getName() {
        return material_name;
    }

    public void setName(String name) {
        this.material_name = name;
    }

    public String getType() {
        return material_type;
    }

    public void setType(String type) {
        this.material_type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "MaterialBean{" +
                "materialId=" + materialId +
                ", name='" + material_name + '\'' +
                ", type='" + material_type + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
