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
public class LTicket {
    private int num_ticket;
    private int referencia;
    private String descripcion;
    private int precio;
    private int ctd;

    public int getNum_ticket() {
        return num_ticket;
    }

    public void setNum_ticket(int num_ticket) {
        this.num_ticket = num_ticket;
    }

    public int getReferencia() {
        return referencia;
    }

    public void setReferencia(int referencia) {
        this.referencia = referencia;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getPrecio() {
        return precio;
    }

    public void setPrecio(int precio) {
        this.precio = precio;
    }

    public int getCtd() {
        return ctd;
    }

    public void setCtd(int ctd) {
        this.ctd = ctd;
    }
    
    public static List<LTicket> getLTickets(int num_ticket) throws SQLException{
        DB db = new DB();
        Object bindings[] = {num_ticket};
        ResultSet rs = db.preparedStatement("SELECT * FROM l_tickets WHERE num_ticket = ?", bindings);
        List<LTicket> ltickets = new ArrayList();
        LTicket t;
        while(rs.next()){
            t = new LTicket();
            t.setNum_ticket(num_ticket);
            t.setReferencia(rs.getInt(2));
            t.setDescripcion(rs.getString(3));
            t.setPrecio(rs.getInt(4));
            t.setCtd(rs.getInt(5));
            ltickets.add(t);
        }
        return (ltickets.isEmpty()) ? null : ltickets;
    }

    @Override
    public String toString() {
        return "LTicket{" + "num_ticket=" + num_ticket + ", referencia=" + referencia + ", descripcion=" + descripcion + ", precio=" + precio + ", ctd=" + ctd + '}';
    }
    
    
}
