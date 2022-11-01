package entity;

public class TableType {
    private int tabletypeID;
    private String tabletypeName;
    private int capacity;

    public TableType() {
    }

    public TableType(int tabletypeID, String tabletypeName, int capacity) {
        this.tabletypeID = tabletypeID;
        this.tabletypeName = tabletypeName;
        this.capacity = capacity;
    }

    public int getTabletypeID() {
        return tabletypeID;
    }

    public void setTabletypeID(int tabletypeID) {
        this.tabletypeID = tabletypeID;
    }

    public String getTabletypeName() {
        return tabletypeName;
    }

    public void setTabletypeName(String tabletypeName) {
        this.tabletypeName = tabletypeName;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

}
