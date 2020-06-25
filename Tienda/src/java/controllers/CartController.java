/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import beans.Article;
import beans.Cart;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import languages.Lang;
import utils.Dispatch;
import utils.MyUtils;

/**
 *
 * @author IES TRASSIERRA
 */
@WebServlet(name = "Cart", urlPatterns = {
    "/cart",
    "/cart/add",
    "/cart/update",
    "/cart/delete",
    "/cart/delete/article",
    "/cart/purchase"
})
public class CartController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        synchronized (session) {
            if (session.getAttribute("locale") == null) { // language
                session.setAttribute("locale", Lang.getLocale(request.getCookies()));
            }
            Dispatch.go(request, response, "/WEB-INF/cart/mycart.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        synchronized (session) {
            String action = request.getServletPath();
            try {
                switch (action) {
                    case "/cart/add":
                        addToCart(request, response);
                        break;
                    case "/cart/update":
                        ((Cart) session.getAttribute("cart")).setUpdate(request, response);
                        break;
                    case "/cart/delete":
                        session.removeAttribute("cart");
                        Dispatch.go(request, response, "/WEB-INF/cart/mycart.jsp");
                        break;
                    case "/cart/delete/article":
                        String ref = MyUtils.getParamValue(request.getParameter("referencia"));
                        if (ref == null || !MyUtils.isNumber(ref)) {
                            Dispatch.go(request, response, "/WEB-INF/errors/400.jsp");
                        } else {
                            Cart cart = (Cart) session.getAttribute("cart");
                            cart.getArticles().remove(Integer.parseInt(ref));
                            if (cart.getArticles().isEmpty()) {
                                session.removeAttribute("cart");
                            }
                        }
                        Dispatch.go(request, response, "/WEB-INF/cart/mycart.jsp");
                        break;
                    case "/cart/purchase":
                        if (session.getAttribute("client") != null) {
                            ((Cart) session.getAttribute("cart")).setPurchase(request, response);
                        } else {
                            response.sendRedirect("/Tienda/clients");
                        }
                        break;
                    default:
                        Dispatch.go(request, response, "/WEB-INF/errors/404.jsp");
                        break;
                }
            } catch (SQLException ex) {
                request.setAttribute("err", ex.getMessage());
                Dispatch.go(request, response, "/WEB-INF/errors/sqlError.jsp");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        synchronized (session) {
            // variables
            String referencia;
            String ctd;
            String feedbackMsg = null;
            boolean feedbackSuccess = true;
            Article article = null;
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
            }

            // get values
            referencia = MyUtils.getParamValue(request.getParameter("referencia"));
            ctd = MyUtils.getParamValue(request.getParameter("ctd"));

            // validation
            if (referencia == null || !MyUtils.isNumber(referencia)) {
                Dispatch.go(request, response, "/WEB-INF/errors/404.jsp");
            } else if ((article = Article.getArticle(Integer.parseInt(referencia))) == null) {
                Dispatch.go(request, response, "/WEB-INF/errors/400.jsp");
            } else if (ctd == null || !MyUtils.isNumber(ctd) || Integer.parseInt(ctd) < 1) {
                feedbackMsg = (session.getAttribute("locale") != "es") ? "The quantity is required" : "La cantidad es necesaria";
                feedbackSuccess = false;
            }

            if (feedbackMsg == null) {
                int ref = Integer.parseInt(referencia);
                int demand = 0;
                Article onCart = cart.getArticle(ref);
                if (onCart != null) {
                    demand = onCart.getCtd();
                }
                demand += Integer.parseInt(ctd);
                if (article.getStock() >= demand) {
                    cart.setArticle(ref, article, demand); // add to cart
                    session.setAttribute("cart", cart); // save cart into session
                    feedbackMsg = (session.getAttribute("locale") != "es") ? "Correclty added" : "Añadido correctamente";
                    feedbackSuccess = true;
                } else {
                    feedbackMsg = (session.getAttribute("locale") != "es") ? "Not enough stock" : "No hay suficiente stock";
                    feedbackSuccess = false;
                }

            }

            request.setAttribute("article", article);
            request.setAttribute("feedbackMsg", feedbackMsg);
            request.setAttribute("feedbackSuccess", feedbackSuccess);
            Dispatch.go(request, response, "/WEB-INF/articles/show.jsp");
        }

    }

}
