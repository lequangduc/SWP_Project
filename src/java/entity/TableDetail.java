package entity;

public class TableDetail {
    private int tableID;
    private String status;
    private String type;
    private int capacity;

    public TableDetail() {
    }

    public TableDetail(int tableID, String status, String type, int capacity) {
        this.tableID = tableID;
        this.status = status;
        this.type = type;
        this.capacity = capacity;
    }

    public int getTableID() {
        return tableID;
    }

    public void setTableID(int tableID) {
        this.tableID = tableID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

}
