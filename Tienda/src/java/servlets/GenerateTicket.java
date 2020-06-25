/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.Client;
import beans.LTicket;
import beans.Ticket;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.Locale;
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
 * @author Miguel
 */
@WebServlet(name = "GenerateTicket", urlPatterns = {"/ticket"})
public class GenerateTicket extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        synchronized (session) {
            if (session.getAttribute("locale") == null) { // language
                session.setAttribute("locale", Lang.getLocale(request.getCookies()));
            }
            String num_ticket = MyUtils.getParamValue(request.getParameter("num_ticket"));
            if (num_ticket == null) {
                Dispatch.go(request, response, "/WEB-INF/errors/404.jsp");
            } else {
                try {
                    Ticket ticket = Ticket.getTicket(Integer.parseInt(num_ticket));
                    Client client = (Client) session.getAttribute("client");
                    if (ticket == null) {
                        Dispatch.go(request, response, "/WEB-INF/errors/404.jsp");
                    } else if(client == null || !client.getDNI().equalsIgnoreCase(ticket.getDNI()) && !client.isAdmin()){
                        Dispatch.go(request, response, "/WEB-INF/errors/403.jsp");
                    } else {
                        client = Client.getClient(ticket.getDNI()); // the ticket client, admin can see tickets
                        generatePDF(request, response, ticket, client);
                    }
                } catch (SQLException ex) {
                    request.setAttribute("err", ex.getMessage());
                    Dispatch.go(request, response, "/WEB-INF/errors/sqlError.jsp");
                } catch (DocumentException ex) {
                    Dispatch.go(request, response, "/WEB-INF/errors/500.jsp");
                }
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

    private void generatePDF(HttpServletRequest request, HttpServletResponse response, Ticket ticket, Client client) throws IOException, DocumentException {
        int total = 0;
        int i = 0;
        int totalXArticle;
        response.setHeader("Content-Type", "application/pdf");
        Document document = new Document(PageSize.A4);
        PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
        writer.setPdfVersion(PdfWriter.VERSION_1_7);
        //TAGGED PDF
        //Make document tagged
        writer.setTagged();
        //===============
        //PDF/UA
        //Set document metadata
        writer.setViewerPreferences(PdfWriter.DisplayDocTitle);
        document.addLanguage("en-EN");
        document.addTitle("Ticket nº: " + ticket.getNum_ticket());
        writer.createXmpMetadata();
        //=====================
        document.open();

        String str = "<html><head></head><body>"
                + "<h1>Tienda</h1>"
                + "<h3>Ticket Nº: " + ticket.getNum_ticket() + "</h3>"
                + "<p>Fecha: " + ticket.getFecha() + "</p>"
                + "<table style='border: 1px solid #999; text-align: left;'>"
                    + "<tr>"
                        + "<th>DNI:</th>"
                        + "<td>" + client.getDNI() + "</td>"
                    + "</tr>"
                    + "<tr>"
                        + "<th>Nombre:</th>"
                        + "<td>"+client.getNombre()+"</td>"
                    + "</tr>"
                    + "<tr>"
                        + "<th>Fecha Nacimiento:</th>"
                        + "<td>"+client.getFec_nac()+"</td>"
                    + "</tr>"
                    + "<tr>"
                        + "<th>Dirección:</th>"
                        + "<td>"+client.getDireccion()+"</td>"
                    + "</tr>"
                + "</table>"
                + "<hr/>"
                + "<table border='1px' style='border-collapse: collapse;'>"
                    + "<tr style='background-color: #000; color: #ccc;'>"
                        + "<th>Referencia</th>"
                        + "<th>Descripción</th>"
                        + "<th>Precio</th>"
                        + "<th>Cantidad</th>"
                        + "<th>Total</th>"
                    + "</tr>";
                for(LTicket t : ticket.getLtickets()){
                    totalXArticle = t.getPrecio() * t.getCtd();
                    if(i%2 == 0){
                        str  += "<tr style='background-color: #bbb;'>";
                    } else {
                        str += "<tr>";
                    }
                    str+= "<td>"+t.getReferencia()+"</td>"
                        + "<td>"+t.getDescripcion()+"</td>"
                        + "<td>"+t.getPrecio()+"&euro;</td>"
                        + "<td>"+t.getCtd()+"</td>"
                        + "<td>"+totalXArticle+"</td>"
                    + "</tr>";
                    total += totalXArticle;
                    i++;
                }
                    
                str += "</table>"
                        +"<hr/>"
                        +"<h2>Total: "+total+"&euro;</h2>"
                + "</body></html>";

        XMLWorkerHelper worker = XMLWorkerHelper.getInstance();
        InputStream is = new ByteArrayInputStream(str.getBytes(StandardCharsets.UTF_8));
        worker.parseXHtml(writer, document, is, Charset.forName("UTF-8"));

        document.close();
    }

}
