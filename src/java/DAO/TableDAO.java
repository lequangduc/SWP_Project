package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import DBContext.DBContext;
import entity.Table;
import entity.TableType;

public class TableDAO {
    public static Connection conn = null;
    public static PreparedStatement ps = null;
    public static ResultSet rs = null;

    public static ArrayList<Table> getAllTable() {
        ArrayList<Table> list = new ArrayList<>();
        String query = "SELECT * FROM [tables]";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Table(rs.getInt(1), rs.getInt(2), rs.getString(3)));
            }

        } catch (Exception e) {
            System.out.println(e);

        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        }

        return list;
    }

    // get table by tableID
    public Table getTableByID(int tableID) {
        String query = "SELECT * FROM [tables] WHERE table_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, tableID);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Table(rs.getInt(1), rs.getInt(2), rs.getString(3));
            }

        } catch (Exception e) {
            System.out.println(e);

        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        }

        return null;
    }
    // update table status, tabletypeID

    public void updateTable(int tableID, int tabletypeID, String status) {
        String query = "UPDATE [tables] SET tabletype_id = ?, status = ? WHERE table_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, tabletypeID);
            ps.setString(2, status);
            ps.setInt(3, tableID);
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println(e);

        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        }
    }

    // update table status
    public void updateTableStatus(int tableID, String status) {
        String query = "UPDATE [tables] SET status = ? WHERE table_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, status);
            ps.setInt(2, tableID);
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println(e);

        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        }
    }

    // add table
    public void addTable(int tabletypeID, String status) {
        String query = "insert into tables(tabletype_id,status) values (?,?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, tabletypeID);
            ps.setString(2, status);
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println(e);

        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        }
    }

    // delete table
    public void deleteTable(int tableID) {
        String query = "DELETE FROM [tables] WHERE table_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, tableID);
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println(e);

        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        }
    }

    // get all table type
    public ArrayList<TableType> getAllTableType() {
        ArrayList<TableType> list = new ArrayList<>();
        String query = "SELECT * FROM [tablestype]";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new TableType(rs.getInt(1), rs.getString(2), rs.getInt(3)));
            }

        } catch (Exception e) {
            System.out.println(e);

        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        }

        return list;
    }

    // get table type by tabletypeID
    public TableType getTableTypeByID(int tabletypeID) {
        String query = "SELECT * FROM [tablestype] WHERE tabletype_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, tabletypeID);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new TableType(rs.getInt(1), rs.getString(2), rs.getInt(3));
            }

        } catch (Exception e) {
            System.out.println(e);

        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        }

        return null;
    }

}
