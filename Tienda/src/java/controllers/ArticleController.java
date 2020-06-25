/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import beans.Article;
import beans.Client;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.json.stream.JsonGenerationException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import languages.Lang;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import utils.Dispatch;
import utils.MyUtils;
import utils.UploadImage;

/**
 *
 * @author IES TRASSIERRA
 */
@WebServlet(name = "Articles", urlPatterns = {
    "/articles",
    "/articles/show",
    "/articles/create",
    "/articles/store",
    "/articles/edit",
    "/articles/update",
    "/articles/showall",
    "/articles/alljson"
//,"/articles/delete"
})
@MultipartConfig()
public class ArticleController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        synchronized (session) {
            if (session.getAttribute("locale") == null) { // language
                session.setAttribute("locale", Lang.getLocale(request.getCookies()));
            }
            String action = request.getServletPath();
            try {
                switch (action) {
                    case "/articles/show":
                        show(request, response);
                        break;
                    case "/articles/create":
                        if (session.getAttribute("client") != null) {
                            if (((Client) session.getAttribute("client")).isAdmin()) {
                                Dispatch.go(request, response, "/WEB-INF/articles/create.jsp");
                            } else {
                                Dispatch.go(request, response, "/WEB-INF/errors/403.jsp");
                            }
                        } else {
                            response.sendRedirect("/Tienda/clients");
                        }

                        break;
                    case "/articles/edit":
                        if (session.getAttribute("client") != null) {
                            if (((Client) session.getAttribute("client")).isAdmin()) {
                                edit(request, response);
                            } else {
                                Dispatch.go(request, response, "/WEB-INF/errors/403.jsp");
                            }

                        } else {
                            response.sendRedirect("/Tienda/clients");
                        }
                        break;
                    case "/articles/showall":
                        if (session.getAttribute("client") != null) {
                            if (((Client) session.getAttribute("client")).isAdmin()) {
                                Dispatch.go(request, response, "/WEB-INF/articles/showall.jsp");
                            } else {
                                Dispatch.go(request, response, "/WEB-INF/errors/403.jsp");
                            }
                        } else {
                            Dispatch.go(request, response, "/WEB-INF/clients/identifier.jsp");
                        }
                        break;
                    case "/articles/alljson":
                        showAllToJson(request, response);
                        break;
                    default:
                        showAll(request, response);
                        break;
                }
            } catch (SQLException ex) {
                request.setAttribute("err", ex.getMessage());
                Dispatch.go(request, response, "/WEB-INF/errors/sqlError.jsp");
            }
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
                    case "/articles/store":
                        if (session.getAttribute("client") != null) {
                            if (((Client) session.getAttribute("client")).isAdmin()) {
                                store(request, response);
                            } else {
                                Dispatch.go(request, response, "/WEB-INF/errors/403.jsp");
                            }

                        } else {
                            response.sendRedirect("/Tienda/clients");
                        }
                        break;
                    case "/articles/update":
                        if (session.getAttribute("client") != null) {
                            if (((Client) session.getAttribute("client")).isAdmin()) {
                                update(request, response);
                            } else {
                                Dispatch.go(request, response, "/WEB-INF/errors/403.jsp");
                            }

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

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void show(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        String ref = MyUtils.getParamValue(request.getParameter("ref"));
        if (ref != null && MyUtils.isNumber(ref)) { // show client profile
            Article article = Article.getArticle(Integer.parseInt(ref));
            request.setAttribute("article", article);
        }
        Dispatch.go(request, response, "/WEB-INF/articles/show.jsp");
    }

    private void store(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {
        HttpSession session = request.getSession();
        synchronized (session) {
            boolean err = validateForm(request);
            Article a = null;
            int ref;
            if (!err) {
                ref = Integer.parseInt(((String[]) request.getAttribute("referencia"))[0]);
                a = Article.getArticle(ref);
                if (a != null) {
                    String referencia[] = {String.valueOf(ref), (session.getAttribute("locale") != "es") ? "There is already an article with that reference" : "Ya hay un artículo con esta referencia"};
                    request.setAttribute("referencia", referencia);
                    err = true;
                } else {
                    // creating bean
                    a = new Article();
                    a.setReferencia(ref);
                    a.setDescripcion(((String[]) request.getAttribute("descripcion"))[0]);
                    a.setPrecio(Integer.parseInt(((String[]) request.getAttribute("precio"))[0]));
                    a.setPath_imagen("");
                    a.setStock(Integer.parseInt(((String[]) request.getAttribute("stock"))[0]));

                    // storing bean into db
                    if (Article.createArticle(a)) {
                        // upload new image
                        String img = UploadImage.uploadImage(request.getPart("img"), a, request.getServletContext().getRealPath("imgs"));
                    } else {
                        request.setAttribute("err", (session.getAttribute("locale") != "es") ? "Error creating the article" : "Error al crear el artículo");
                        err = true;
                    }
                }
            }

            if (err) {
                Dispatch.go(request, response, "/WEB-INF/articles/create.jsp");
            } else {
                response.sendRedirect("show?ref=" + a.getReferencia());
            }
        }
    }

    private boolean validateForm(HttpServletRequest request) {
        HttpSession session = request.getSession();
        synchronized (session) {
            // variables
            String referencia[] = new String[2];
            String descripcion[] = new String[2];
            String precio[] = new String[2];
            String stock[] = new String[2];
            boolean err = false;

            // retrieving params
            referencia[0] = MyUtils.getParamValue(request.getParameter("referencia"));
            descripcion[0] = MyUtils.getParamValue(request.getParameter("descripcion"));
            precio[0] = MyUtils.getParamValue(request.getParameter("precio"));
            stock[0] = MyUtils.getParamValue(request.getParameter("stock"));

            // validation
            if (referencia[0] == null) {
                referencia[1] = (session.getAttribute("locale") != "es") ? "Required field" : "Campo requerido";
                err = true;
            } else if (!MyUtils.isNumber(referencia[0])) {
                referencia[1] = (session.getAttribute("locale") != "es") ? "Not a valid number" : "Número no válido";
                err = true;
            }

            if (descripcion[0] == null) {
                descripcion[1] = (session.getAttribute("locale") != "es") ? "Required field" : "Campo requerido";
                err = true;
            } else if(descripcion[0].length() > 200){
                descripcion[1] = (session.getAttribute("locale") != "es") ? "Maximum length of 200 characters" : "Logintud máxima de 200 caracteres";
                err = true;
            }

            if (precio[0] == null) {
                precio[1] = (session.getAttribute("locale") != "es") ? "Required field" : "Campo requerido";
                err = true;
            } else if (!MyUtils.isNumber(precio[0])) {
                precio[1] = (session.getAttribute("locale") != "es") ? "Not a valid number" : "Número no válido";
                err = true;
            }

            if (stock[0] == null) {
                stock[1] = (session.getAttribute("locale") != "es") ? "Required field" : "Campo requerido";
                err = true;
            } else if (!MyUtils.isNumber(stock[0])) {
                stock[1] = (session.getAttribute("locale") != "es") ? "Not a valid number" : "Número no válido";
                err = true;
            }

            // saving into request scope
            request.setAttribute("referencia", referencia);
            request.setAttribute("descripcion", descripcion);
            request.setAttribute("precio", precio);
            request.setAttribute("stock", stock);

            return err;
        }
    }

    private void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        String ref = MyUtils.getParamValue(request.getParameter("ref"));
        if (ref != null) { // show article to edit
            Article a = Article.getArticle(Integer.parseInt(ref));
            if (a != null) {
                request.setAttribute("article", a);
                Dispatch.go(request, response, "/WEB-INF/articles/edit.jsp");
            } else {
                Dispatch.go(request, response, "/WEB-INF/errors/404.jsp");
            }

        } else {
            Dispatch.go(request, response, "/WEB-INF/errors/404.jsp");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        synchronized (session) {
            boolean err = validateForm(request);
            Article a = null;
            int ref = Integer.parseInt(((String[]) request.getAttribute("referencia"))[0]);
            if (!err) {
                a = Article.getArticle(ref);
                if (a != null) {
                    // updating the bean
                    a.setDescripcion(((String[]) request.getAttribute("descripcion"))[0]);
                    a.setPrecio(Integer.parseInt(((String[]) request.getAttribute("precio"))[0]));
                    a.setStock(Integer.parseInt(((String[]) request.getAttribute("stock"))[0]));

                    // storing bean into db
                    if (Article.updateArticle(a)) {
                        // upload new image
                        String img = UploadImage.uploadImage(request.getPart("img"), a, request.getServletContext().getRealPath("imgs"));
                        if (img != null) {
                            request.setAttribute("path_imagen", img);
                        } else {
                            request.setAttribute("path_imagen", a.getPath_imagen());
                        }

                        request.setAttribute("success", (session.getAttribute("locale") != "es") ? "Acrticle correctly updated" : "Articulo actualizado correctamente");
                    } else {
                        request.setAttribute("err", (session.getAttribute("locale") != "es") ? "Error updating the article" : "Error al actualizar el artículo");
                        err = true;
                    }
                } else {
                    String referencia[] = {String.valueOf(ref), "You shouldn't try to hack this lol"};
                    request.setAttribute("referencia", referencia);
                    err = true;
                }

            }
            Dispatch.go(request, response, "/WEB-INF/articles/edit.jsp");
        }
    }

    private void showAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        List<Article> articles = Article.getAllArticles();
        request.setAttribute("articles", articles);
        Dispatch.go(request, response, "/WEB-INF/articles/articles.jsp");
    }

    private void showAllToJson(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        String admin = MyUtils.getParamValue(request.getHeader("admin"));
        ObjectMapper mapper = new ObjectMapper();
        List<Article> articles;
        PrintWriter out;
        response.setContentType("application/json;charset=UTF-8");
        try {
            out = response.getWriter();
            if (admin == null || !admin.equals("1")) {
                out.println("{}");
            } else {
                articles = Article.getAllArticles();
                out.println(mapper.writeValueAsString(articles));
            }

        } catch (JsonGenerationException | JsonMappingException e) {
            e.printStackTrace();
        }
    }
}
