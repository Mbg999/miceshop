/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import classes.DB;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.Dispatch;
import utils.MyUtils;

/**
 *
 * @author miguel
 */
public class Cart {

    private Map<Integer, Article> articles;

    public Cart() {
        articles = new HashMap();
    }

    public void setArticle(int ref, Article article, int ctd) {
        article.setCtd(ctd);
        articles.put(ref, article);
    }

    public Map getArticles() {
        return articles;
    }

    public Article getArticle(int ref) {
        if (this.articles.containsKey(ref)) {
            return this.articles.get(ref);
        }
        return null;
    }

    public boolean isOnCart(int ref) {
        return this.articles.containsKey(ref);
    }

    public int getCtdOnCart(int ref) {
        return this.articles.get(ref).getCtd();
    }

    public void setPurchase(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        HttpSession session = request.getSession();
        synchronized (session) {
            DB db = new DB();
            db.transaction();
            List<String> errors = new ArrayList();
            Article article;
            Article a;

            // create ticket
            Object bindings[] = {
                new SimpleDateFormat("dd-MM-yyyy").format(new GregorianCalendar().getTime()),
                ((Client) session.getAttribute("client")).getDNI()
            };

            int num_ticket = db.preparedInsertReturnID("INSERT INTO tickets (fecha, dni) VALUES(?,?)", bindings);
            PreparedStatement ps = db.getPreparedStatement("INSERT INTO l_tickets values(?,?,?,?,?)");
            PreparedStatement ps2 = db.getPreparedStatement("UPDATE articulos SET stock = ? WHERE referencia = ?");
            for (Map.Entry set : articles.entrySet()) {
                a = ((Article) set.getValue());
                article = Article.getArticle(a.getReferencia());
                if (article.getStock() >= a.getCtd()) {
                    ps.setInt(1, num_ticket);
                    ps.setInt(2, a.getReferencia());
                    ps.setString(3, a.getDescripcion());
                    ps.setInt(4, a.getPrecio());
                    ps.setInt(5, a.getCtd());
                    ps.execute();

                    ps2.setInt(1, article.getStock() - a.getCtd());
                    ps2.setInt(2, a.getReferencia());
                    ps2.execute();
                } else {
                    errors.add("ref: " + a.getReferencia() + ": " + ((session.getAttribute("locale") != "es") ? "Not enough stock" : "No hay suficiente stock"));
                }
            }

            if (errors.isEmpty()) {
                db.commit();
                request.setAttribute("num_ticket", num_ticket);
                session.removeAttribute("cart");
                Dispatch.go(request, response, "/WEB-INF/cart/purchased.jsp");
            } else {
                db.rollback();
                request.setAttribute("errors", errors);
                Dispatch.go(request, response, "/WEB-INF/cart/mycart.jsp");
            }
        }

    }

    public void setUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        synchronized (session) {
            String ref = MyUtils.getParamValue(request.getParameter("referencia"));
            String ctd[] = new String[2];
            ctd[0] = MyUtils.getParamValue(request.getParameter("ctd"));
            boolean updated = false;
            if (ref == null) {
                Dispatch.go(request, response, "/WEB-INF/errors/400.jsp");
            } else {
                Article article = Article.getArticle(Integer.parseInt(ref));
                if (article == null) {
                    Dispatch.go(request, response, "/WEB-INF/errors/400.jsp");
                } else {
                    if (ctd[0] == null || !MyUtils.isNumber(ctd[0]) || Integer.parseInt(ctd[0]) < 1) {
                        ctd[1] = (session.getAttribute("locale") != "es") ? "Quantity is required" : "La cantidad es necesaria";
                    } else if(article.getStock() < Integer.parseInt(ctd[0])) {
                        ctd[1] = (session.getAttribute("locale") != "es") ? "Not enough stock" : "No hay suficiente stock";
                    } else {
                        this.articles.get(Integer.parseInt(ref)).setCtd(Integer.parseInt(ctd[0]));
                        updated = true;
                    }
                }
                
                if(updated){
                    request.setAttribute("success", "Carrito actualizado");
                } else {
                    request.setAttribute("err", "Compruebe sus artículos");
                    request.setAttribute("errRef", Integer.parseInt(ref));
                    request.setAttribute("ctd", ctd[1]);
                }
                Dispatch.go(request, response, "/WEB-INF/cart/mycart.jsp");
            }

        }
    }

}
