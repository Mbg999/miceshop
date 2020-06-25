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
public class Ticket {
    private int num_ticket;
    private String fecha;
    private String DNI;
    private List<LTicket> ltickets;

    public int getNum_ticket() {
        return num_ticket;
    }

    public void setNum_ticket(int num_ticket) {
        this.num_ticket = num_ticket;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getDNI() {
        return DNI;
    }

    public void setDNI(String DNI) {
        this.DNI = DNI;
    }

    public List<LTicket> getLtickets() {
        return ltickets;
    }

    public void setLtickets(List<LTicket> ltickets) {
        this.ltickets = ltickets;
    }

    public static Ticket getTicket(int num_ticket) throws SQLException{
        DB db = new DB();
        Object bindings[] = {num_ticket};
        ResultSet rs = db.preparedStatement("SELECT * FROM tickets WHERE num_ticket = ?", bindings);
        if(rs.next()){
            Ticket t = new Ticket();
            t.setNum_ticket(num_ticket);
            t.setFecha(rs.getString(2));
            t.setDNI(rs.getString(3));
            t.setLtickets(LTicket.getLTickets(num_ticket));
            return t;
        }
        return null;
    }
    
    public static List<Ticket> getTicketsByDNI(String DNI) throws SQLException {
        DB db = new DB();
        List<Ticket> ts = new ArrayList();
        Ticket t ;
        Object bindings[] = {DNI};
        ResultSet rs = db.preparedStatement("SELECT * FROM tickets WHERE DNI LIKE ?", bindings);
        while(rs.next()){
            t = new Ticket();
            t.setNum_ticket(rs.getInt(1));
            t.setFecha(rs.getString(2));
            t.setDNI(rs.getString(3));
            //t.setLtickets(LTicket.getLTickets(t.getNum_ticket()));
            ts.add(t);
        }
        return (ts.isEmpty()) ? null : ts;
    }
    
    @Override
    public String toString() {
        return "Ticket{" + "num_ticket=" + num_ticket + ", fecha=" + fecha + ", dni=" + DNI + '}';
    }
    
    
}
