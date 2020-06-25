/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import classes.DB;
import java.io.File;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Miguel
 */
public class Article {

    private int referencia;
    private String descripcion;
    private int precio;
    private String path_imagen;
    private int stock;
    private int ctd;

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

    public String getPath_imagen() {
        return path_imagen;
    }

    public void setPath_imagen(String path_imagen) throws SQLException {
        this.path_imagen = path_imagen;
    }

    public String getExtension() {
        if (this.path_imagen == null || this.path_imagen.equals("") || this.path_imagen.lastIndexOf(".") < 0) {
            return null;
        }
        return this.path_imagen.substring(this.path_imagen.lastIndexOf("."));
    }

    public void setNewPath_imagen(String name, String extension, String path) throws SQLException {
        DB db = new DB();
        Object bindings[] = {name+extension, this.referencia};
        if (db.preparedUpdate("UPDATE articulos SET path_imagen = ? WHERE referencia = ?", bindings) > 0) {
            if (this.path_imagen != null && !this.path_imagen.equals("")) {
                File oldImg = new File(path + File.separator + this.path_imagen);
                if (oldImg != null) { // si al mover la imagen, no se ha machacado, porque la antigua tenia otra extension, la antigua se elimina
                    oldImg.delete();
                }
            }
        }
        this.setPath_imagen(name+extension);
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getCtd() {
        return ctd;
    }

    public void setCtd(int ctd) {
        this.ctd = ctd;
    }

    public static Article getArticle(int ref) throws SQLException {
        DB db = new DB();
        Object bindings[] = {ref};
        ResultSet rs = db.preparedStatement("SELECT * FROM articulos WHERE referencia = ?", bindings);
        if (rs.next()) {
            Article a = new Article();
            a.setReferencia(rs.getInt("referencia"));
            a.setDescripcion(rs.getString("descripcion"));
            a.setPrecio(rs.getInt("precio"));
            a.setPath_imagen(rs.getString("path_imagen"));
            a.setStock(rs.getInt("stock"));
            return a;
        }
        return null;
    }

    public static boolean createArticle(Article a) throws SQLException {
        DB db = new DB();
        Object bindings[] = {a.getReferencia(), a.getDescripcion(), a.getPrecio(),
            a.getPath_imagen(), a.getStock()};
        return db.preparedInsert("INSERT INTO articulos VALUES(?,?,?,?,?)", bindings);
    }

    public static boolean updateArticle(Article a) throws SQLException {
        DB db = new DB();
        Object bindings[] = {a.getDescripcion(), a.getPrecio(), a.getStock(), a.getReferencia()};
        return db.preparedUpdate("UPDATE articulos SET descripcion= ?, precio= ?, stock = ? WHERE referencia = ?", bindings) > 0;
    }

    public static List<Article> getAllArticles() throws SQLException {
        Article a;
        DB db = new DB();
        List<Article> articles = new ArrayList();
        ResultSet rs = db.statement("SELECT * FROM articulos");
        while (rs.next()) {
            a = new Article();
            a.setReferencia(rs.getInt("referencia"));
            a.setDescripcion(rs.getString("descripcion"));
            a.setPrecio(rs.getInt("precio"));
            a.setPath_imagen(rs.getString("path_imagen"));
            a.setStock(rs.getInt("stock"));
            articles.add(a);
        }
        return articles;
    }

    @Override
    public String toString() {
        return "Article{" + "referencia=" + referencia + ", descripcion=" + descripcion + ", precio=" + precio + ", path_imagen=" + path_imagen + ", stock=" + stock + '}';
    }

}
