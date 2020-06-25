/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import static java.sql.Statement.RETURN_GENERATED_KEYS;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Miguel
 */
public class DB {

    private static final String DRIVER = "com.mysql.jdbc.Driver";
    private static final String DSN = "jdbc:mysql://localhost/";
    private static final String dbName = "onlineshop";
    private static final String username = "root";
    private static final String password = "";
    private Connection conn;

    public DB() throws SQLException {
        try {
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(DSN + dbName, username, password);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int preparedInsertReturnID(String query, Object bindings[]) throws SQLException {
        PreparedStatement st = conn.prepareStatement(query, RETURN_GENERATED_KEYS);
        for (int i = 0; i < bindings.length; i++) {
            st.setObject((i + 1), bindings[i]);
        }
        st.executeUpdate();

        ResultSet rs = st.getGeneratedKeys();
        rs.next();
        return rs.getInt(1);
    }
    
    public PreparedStatement getPreparedStatement(String query) throws SQLException{
        return conn.prepareStatement(query);
    }

    public void transaction() throws SQLException {
        this.conn.setAutoCommit(false);
    }

    public void commit() throws SQLException {
        this.conn.commit();
    }

    public void rollback() throws SQLException {
        this.conn.rollback();
    }

    public ResultSet statement(String query) throws SQLException {
        Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
        return stmt.executeQuery(query);
    }

    public ResultSet preparedStatement(String query, Object bindings[]) throws SQLException {
        PreparedStatement st = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        for (int i = 0; i < bindings.length; i++) {
            st.setObject((i + 1), bindings[i]);
        }
        return st.executeQuery();
    }

    public boolean preparedInsert(String query, Object bindings[]) throws SQLException {
        PreparedStatement st = conn.prepareStatement(query);
        for (int i = 0; i < bindings.length; i++) {
            st.setObject((i + 1), bindings[i]);
        }
        return st.executeUpdate() > 0;
    }

    public int preparedUpdate(String query, Object bindings[]) throws SQLException {
        PreparedStatement st = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        for (int i = 0; i < bindings.length; i++) {
            st.setObject((i + 1), bindings[i]);
        }
        return st.executeUpdate();
    }

    public void closeConn() {
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException ex) {

        }
    }
}
