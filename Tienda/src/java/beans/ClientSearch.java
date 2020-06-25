/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import classes.DB;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Miguel
 */
public class ClientSearch {
    private String DNI;
    private String nombre;
    private boolean admin;

    public String getDNI() {
        return DNI;
    }

    public void setDNI(String DNI) {
        this.DNI = DNI;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public boolean isAdmin() {
        return admin;
    }

    public void setAdmin(boolean admin) {
        this.admin = admin;
    }
    
    public static List<ClientSearch> retrieveAllClients() throws SQLException{
        DB db = new DB();
        List<ClientSearch> clientes = new ArrayList();
        ClientSearch c;
        ResultSet rs = db.statement("SELECT DNI, nombre, admin FROM clientes");
        while(rs.next()){
            c = new ClientSearch();
            c.setDNI(rs.getString("DNI"));
            c.setNombre(rs.getString("nombre"));
            c.setAdmin(rs.getBoolean("admin"));
            clientes.add(c);
        }
        return clientes;
    }

    @Override
    public String toString() {
        return "ClientSearch{" + "DNI=" + DNI + ", nombre=" + nombre + ", admin=" + admin + '}';
    }
}
