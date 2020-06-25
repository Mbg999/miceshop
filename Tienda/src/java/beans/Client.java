/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import classes.DB;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Miguel
 */
public class Client {

    private String DNI;
    private String nombre;
    private String password;
    private Date fec_nac;
    private String direccion;
    private boolean admin;
    private List<Ticket> tickets;

    public Client() {
        admin = false;
    }

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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getFec_nac() {
        return fec_nac;
    }

    public void setFec_nac(Date fec_nac) {
        this.fec_nac = fec_nac;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public boolean isAdmin() {
        return admin;
    }

    public void setAdmin(boolean admin) {
        this.admin = admin;
    }

    public List<Ticket> getTickets() {
        return tickets;
    }

    public void setTickets(List<Ticket> tickets) {
        this.tickets = tickets;
    }

    public static Client getClient(String DNI) throws SQLException {
        DB db = new DB();
        Object bindings[] = {DNI};
        ResultSet rs = db.preparedStatement("SELECT * FROM clientes WHERE dni like ?", bindings);
        if (rs.next()) {
            Client c = new Client();
            c.setDNI(DNI);
            c.setNombre(rs.getString("nombre"));
            c.setPassword(rs.getString("password"));
            c.setFec_nac(rs.getDate("fec_nac"));
            c.setDireccion(rs.getString("direccion"));
            c.setAdmin(rs.getBoolean("admin"));
            return c;
        }
        return null;
    }

    public static boolean SignUp(Client c) throws SQLException {
        DB db = new DB();
        Object bindings[] = {c.getDNI(), c.getNombre(), c.getFec_nac(), c.getDireccion(), c.getPassword(), c.isAdmin()};
        return db.preparedInsert("INSERT INTO clientes VALUES(?,?,?,?,?,?)", bindings);
    }

    public static int update(Client c) throws SQLException {
        DB db = new DB();
        Object bindings[] = {c.getNombre(), c.getFec_nac(), c.getDireccion(), c.getPassword(), c.isAdmin(), c.getDNI()};
        return db.preparedUpdate("UPDATE clientes SET nombre = ?, fec_nac = ?, direccion = ?, password = ?, admin = ? WHERE dni like ?", bindings);
    }
    
    @Override
    public String toString() {
        return "Client{" + "DNI=" + DNI + ", nombre=" + nombre + ", fec_nac=" + fec_nac + ", direccion=" + direccion + ", admin=" + admin + '}';
    }

}
