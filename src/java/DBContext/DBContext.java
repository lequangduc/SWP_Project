/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DBContext;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author admin
 */
public class DBContext {
    private final String servername = "LAPTOP-61ETP8DM";
    private final String dbName = "Restaurant";
    private final String portNumber = "1433";
    private final String instance = "";
    private final String userID = "sa";
    private final String password = "123";

    public Connection getConnection() throws Exception {
        try {
            String url = "jdbc:sqlserver://" + servername + ":" + portNumber + "\\" + instance + ";databaseName=" + dbName+";encrypt=true;trustServerCertificate=true";
            if (instance == null || instance.trim().isEmpty()) {
                url = "jdbc:sqlserver://" + servername + ":" + portNumber + ";databaseName=" + dbName +";encrypt=true;trustServerCertificate=true";
            }
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(url, userID, password);

        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
}