/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utils;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author Eduardo
 */
public class Conexion {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Conexion.getConexion();
    }
    public static Connection getConexion() {
        Connection conn = null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/ejemplosbdmysql?user=root&password=");
            System.out.println("Conexion exitosa");
        }catch(Exception e){
            System.out.println("ERROR: "+e.getMessage());
        }
        return conn;
    }
}
