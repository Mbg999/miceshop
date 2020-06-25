/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Locale;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import languages.Lang;
import utils.MyUtils;

/**
 *
 * @author Miguel
 */
@WebServlet(name = "ChangeLang", urlPatterns = {"/changelang"})
public class ChangeLang extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        synchronized (session) {
            String lang = MyUtils.getParamValue(request.getParameter("lang"));
            if (lang != null) {
                if (lang.equalsIgnoreCase("en")) {
                    response.addCookie(Lang.setEnglish());
                    session.setAttribute("locale", Locale.ENGLISH);
                } else {
                    response.addCookie(Lang.setSpanish());
                    session.setAttribute("locale", new Locale("es"));
                }
            }
            
            response.sendRedirect((request.getHeader("Referer") != null) ? request.getHeader("Referer") : "/Tienda/articles");
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

}
