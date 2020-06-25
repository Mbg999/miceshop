/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import beans.Client;
import beans.ClientSearch;
import beans.Ticket;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import javax.json.stream.JsonGenerationException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import languages.Lang;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import utils.Dispatch;
import utils.MyUtils;

/**
 *
 * @author Miguel
 */
@WebServlet(name = "Clients", urlPatterns = {
    "/clients", // shows identifier.jsp
    "/clients/show", // shows a client, showClient.jsp
    "/login", // login into a client, ok: ArticlesController, not ok: identifier.jsp
    "/signup", // signup a new client, it logs in after signingup ok: ArticlesController, not ok: identifier.jsp
    "/signupfromadmin", // return client/signupfromadmin.jsp
    "/dosignupfromadmin", // insert the new user and return client/showClient.jsp
    "/clients/edit", // return client/edit.jsp
    "/clients/editfromadmin", // return client/editfromadmin.jsp
    "/clients/update", // client updating his own data, identifier.jsp
    "/clients/updatefromadmin", // an admin updating another client data, identifier.jsp
    "/logout", // close session
    "/clients/showall",
    "/clients/alljson"
})
public class ClientController extends HttpServlet {

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
                    case "/clients/show":
                        show(request, response);
                        break;
                    case "/clients/edit":
                        if (session.getAttribute("client") != null) {
                            Dispatch.go(request, response, "/WEB-INF/clients/edit.jsp");
                        } else {
                            Dispatch.go(request, response, "/WEB-INF/clients/identifier.jsp");
                        }
                        break;
                    case "/clients/editfromadmin":
                        if (session.getAttribute("client") != null) {
                            if (((Client) session.getAttribute("client")).isAdmin()) {
                                selecttoupdate(request, response);
                            } else {
                                Dispatch.go(request, response, "/WEB-INF/errors/403.jsp");
                            }
                        } else {
                            Dispatch.go(request, response, "/WEB-INF/clients/identifier.jsp");
                        }

                        break;
                    case "/signupfromadmin":
                        if (session.getAttribute("client") != null) {
                            if (((Client) session.getAttribute("client")).isAdmin()) {
                                Dispatch.go(request, response, "/WEB-INF/clients/signupfromadmin.jsp");
                            } else {
                                Dispatch.go(request, response, "/WEB-INF/errors/403.jsp");
                            }
                        } else {
                            Dispatch.go(request, response, "/WEB-INF/clients/identifier.jsp");
                        }
                        break;
                    case "/logout":
                        session.invalidate();
                        Cookie c = new Cookie("client", "0");
                        c.setMaxAge(0);
                        response.addCookie(c);
                        response.sendRedirect("articles");
                        break;
                    case "/clients/showall":
                        if (session.getAttribute("client") != null) {
                            if (((Client) session.getAttribute("client")).isAdmin()) {
                                Dispatch.go(request, response, "/WEB-INF/clients/showallclients.jsp");
                            } else {
                                Dispatch.go(request, response, "/WEB-INF/errors/403.jsp");
                            }
                        } else {
                            Dispatch.go(request, response, "/WEB-INF/clients/identifier.jsp");
                        }
                        break;
                    case "/clients/alljson":
                        allclientstojson(request, response);
                        break;
                    default:
                        Dispatch.go(request, response, "/WEB-INF/clients/identifier.jsp");
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
                    case "/login":
                        login(request, response);
                        break;
                    case "/signup":
                        signup(request, response);
                        break;
                    case "/clients/update":
                        if (session.getAttribute("client") != null) {
                            String DNI = MyUtils.getParamValue(request.getParameter("DNI"));
                            if (DNI != null && ((Client) session.getAttribute("client")).getDNI().equalsIgnoreCase(DNI)) {
                                updateClient(request, response);
                            } else {
                                Dispatch.go(request, response, "/WEB-INF/errors/403.jsp");
                            }
                        } else {
                            Dispatch.go(request, response, "/WEB-INF/clients/identifier.jsp");
                        }

                        break;
                    case "/dosignupfromadmin":
                        if (session.getAttribute("client") != null) {
                            if (((Client) session.getAttribute("client")).isAdmin()) {
                                signupbutfromadmin(request, response);
                            } else {
                                Dispatch.go(request, response, "/WEB-INF/errors/403.jsp");
                            }
                        } else {
                            Dispatch.go(request, response, "/WEB-INF/clients/identifier.jsp");
                        }
                        break;
                    case "/clients/updatefromadmin":
                        if (session.getAttribute("client") != null) {
                            if (((Client) session.getAttribute("client")).isAdmin()) {
                                updateClientFromAdmin(request, response);
                            } else {
                                Dispatch.go(request, response, "/WEB-INF/errors/403.jsp");
                            }
                        } else {
                            Dispatch.go(request, response, "/WEB-INF/clients/identifier.jsp");
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

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        synchronized (session) {
            if (session.getAttribute("client") != null) {
                response.sendRedirect("articles");
            } else {
                // variables
                String DNI[] = new String[2];
                String password[] = new String[2];
                boolean err = false;

                // getting param values
                DNI[0] = MyUtils.getParamValue(request.getParameter("DNIl"));
                password[0] = MyUtils.getParamValue(request.getParameter("passwordl"));

                // ---------- validation
                if (DNI[0] == null) { // DNI
                    DNI[1] = (session.getAttribute("locale") != "es") ? "Required field" : "Campo requerido";
                    err = true;
                } else {
                    DNI[0] = DNI[0].toUpperCase();
                    if (!MyUtils.validateDNI(DNI[0])) {
                        DNI[1] = (session.getAttribute("locale") != "es") ? "Not valid DNI" : "DNI no válido";
                        err = true;
                    }
                }

                if (password[0] == null) { // password
                    password[1] = (session.getAttribute("locale") != "es") ? "Required field" : "Campo requerido";
                    err = true;
                }
                // ---------- /validation

                if (!err) { // login process
                    Client client = Client.getClient(DNI[0]);
                    if (client != null) {
                        if (client.getPassword().equals(password[0])) {
                            // set Client into session
                            session.setAttribute("client", client);
                            Cookie c = new Cookie("client", (client.isAdmin()) ? "1" : "0");
                            response.addCookie(c);
                        } else {
                            password[1] = (session.getAttribute("locale") != "es") ? "Wrong password" : "Contraseña incorrecta";
                            err = true;
                        }
                    } else {
                        // hardcoded admin user
                        if (DNI[0].equalsIgnoreCase("12345678Z") && password[0].equals("admin")) { // cambiar a un DNI cuando se implemente la validacion
                            client = new Client();
                            client.setDNI("12345678Z");
                            client.setNombre("admin");
                            client.setDireccion("admin");
                            client.setFec_nac(Date.valueOf("2020-02-19"));
                            client.setPassword("admin");
                            client.setAdmin(true);
                            session.setAttribute("client", client);
                            Cookie c = new Cookie("client", "1");
                            response.addCookie(c);
                            // if the user fail de password in this case, i won't tell him the error, i won't give him the hardcoded admin DNI 
                        } else {
                            DNI[1] = (session.getAttribute("locale") != "es") ? "This user doesn't exists" : "El usuario no existe";
                            err = true;
                        }
                    }
                }

                if (err) { // errors at param validation or login process
                    request.setAttribute("DNIl", DNI);
                    request.setAttribute("passwordl", password);
                    Dispatch.go(request, response, "/WEB-INF/clients/identifier.jsp");
                } else { // success login
                    response.sendRedirect("articles");
                }
            }
        }
    }

    private boolean validateClient(HttpServletRequest request) {
        HttpSession session = request.getSession();
        synchronized (session) {
            // variables
            String DNI[] = new String[2];
            String nombre[] = new String[2];
            String fec_nac[] = new String[2];
            String direccion[] = new String[2];
            String password[] = new String[2];
            boolean err = false;

            // getting param values
            DNI[0] = MyUtils.getParamValue(request.getParameter("DNI"));
            nombre[0] = MyUtils.getParamValue(request.getParameter("nombre"));
            fec_nac[0] = MyUtils.getParamValue(request.getParameter("fec_nac"));
            direccion[0] = MyUtils.getParamValue(request.getParameter("direccion"));
            password[0] = MyUtils.getParamValue(request.getParameter("password"));

            // ---------- validation
            if (DNI[0] == null) { // DNI
                DNI[1] = (session.getAttribute("locale") != "es") ? "Required field" : "Campo requerido";
                err = true;
            } else {
                DNI[0] = DNI[0].toUpperCase();
                if (!MyUtils.validateDNI(DNI[0])) {
                    DNI[1] = (session.getAttribute("locale") != "es") ? "Not valid DNI" : "DNI no válido";
                    err = true;
                }
            }

            if (nombre[0] == null) { // nombre
                nombre[1] = (session.getAttribute("locale") != "es") ? "Required field" : "Campo requerido";
                err = true;
            }

            if (direccion[0] == null) { // direccion
                direccion[1] = (session.getAttribute("locale") != "es") ? "Required field" : "Campo requerido";
                err = true;
            }

            if (fec_nac[0] == null) { // fec_nac
                fec_nac[1] = (session.getAttribute("locale") != "es") ? "Required field" : "Campo requerido";
                err = true;
            } else if (!MyUtils.isValidDate(fec_nac[0])) {
                fec_nac[1] = (session.getAttribute("locale") != "es") ? "Not a valid date" : "No es una fecha valida";
                err = true;
            }

            if (password[0] == null) { // password
                password[1] = (session.getAttribute("locale") != "es") ? "Required field" : "Campo requerido";
                err = true;
            }

            request.setAttribute("DNI", DNI);
            request.setAttribute("nombre", nombre);
            request.setAttribute("fec_nac", fec_nac);
            request.setAttribute("direccion", direccion);
            request.setAttribute("password", password);
            return err;
        }
    }

    private void signup(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        synchronized (session) {
            boolean err = validateClient(request);
            String[] DNI = (String[]) request.getAttribute("DNI");

            if (!err) { // register process
                Client client = Client.getClient(DNI[0]);
                if (client != null) {
                    DNI[1] = (session.getAttribute("locale") != "es") ? "This user already exists" : "El usuario ya existe";
                    err = true;
                } else {
                    // prepare bean
                    client = new Client();
                    client.setDNI(DNI[0]);
                    client.setNombre(((String[]) request.getAttribute("nombre"))[0]);
                    client.setFec_nac(Date.valueOf(((String[]) request.getAttribute("fec_nac"))[0]));
                    client.setDireccion(((String[]) request.getAttribute("direccion"))[0]);
                    client.setPassword(((String[]) request.getAttribute("password"))[0]);
                    client.setAdmin(false);

                    if (Client.SignUp(client)) { // signup
                        // set Client into session
                        session.setAttribute("client", client);
                        Cookie c = new Cookie("client", (client.isAdmin()) ? "1" : "0");
                        response.addCookie(c);
                    }
                }
            }

            if (err) { // errors at param validation or register process
                request.setAttribute("DNI", DNI);
                Dispatch.go(request, response, "/WEB-INF/clients/identifier.jsp");

            } else { // success signup
                response.sendRedirect("articles");
            }

        }
    }

    private void signupbutfromadmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        synchronized (session) {
            boolean err = validateClient(request);
            boolean admin = false;
            String[] DNI = (String[]) request.getAttribute("DNI");
            if (MyUtils.getParamValue(request.getParameter("admin")) != null) {
                admin = true;
            }
            if (!err) { // register process
                Client client = Client.getClient(DNI[0]);
                if (client != null) {
                    DNI[1] = (session.getAttribute("locale") != "es") ? "This user already exists" : "El usuario ya existe";
                    err = true;
                } else {
                    // prepare bean
                    client = new Client();
                    client.setDNI(DNI[0]);
                    client.setNombre(((String[]) request.getAttribute("nombre"))[0]);
                    client.setFec_nac(Date.valueOf(((String[]) request.getAttribute("fec_nac"))[0]));
                    client.setDireccion(((String[]) request.getAttribute("direccion"))[0]);
                    client.setPassword(((String[]) request.getAttribute("password"))[0]);
                    client.setAdmin(admin);

                    Client.SignUp(client); // signup
                }
            }

            if (err) { // errors at param validation or register process
                request.setAttribute("DNI", DNI);
                request.setAttribute("admin", admin);
                Dispatch.go(request, response, "/WEB-INF/clients/signupfromadmin.jsp");
            } else { // success signup
                response.sendRedirect("/Tienda/clients/show?client=" + DNI[0]);
            }
        }
    }

    private void show(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        String DNI = MyUtils.getParamValue(request.getParameter("client"));
        if (DNI != null) { // show client profile
            Client client = Client.getClient(DNI);
            if (client != null) {
                client.setTickets(Ticket.getTicketsByDNI(client.getDNI()));
                request.setAttribute("showClient", client);
            }
        }
        Dispatch.go(request, response, "/WEB-INF/clients/showClient.jsp");
    }

    private void selecttoupdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        String DNI = MyUtils.getParamValue(request.getParameter("client"));
        if (DNI != null) { // show client profile
            Client client = Client.getClient(DNI);
            if (client != null) {
                request.setAttribute("uclient", client);
                Dispatch.go(request, response, "/WEB-INF/clients/editfromadmin.jsp");
            } else {
                Dispatch.go(request, response, "/WEB-INF/errors/404.jsp");
            }

        } else {
            Dispatch.go(request, response, "/WEB-INF/errors/404.jsp");
        }
    }

    private void updateClientFromAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        synchronized (session) {
            if (session.getAttribute("client") != null
                    && ((Client) session.getAttribute("client")).isAdmin()) { // its admin, all ok
                boolean err = validateClient(request);
                boolean admin = false;
                String[] DNI = (String[]) request.getAttribute("DNI");
                if (MyUtils.getParamValue(request.getParameter("admin")) != null) {
                    admin = true;
                }
                request.setAttribute("admin", admin);

                if (!err) { // register process
                    Client client = Client.getClient(DNI[0]);
                    if (client != null) {
                        // prepare bean
                        client.setDNI(DNI[0]);
                        client.setNombre(((String[]) request.getAttribute("nombre"))[0]);
                        client.setFec_nac(Date.valueOf(((String[]) request.getAttribute("fec_nac"))[0]));
                        client.setDireccion(((String[]) request.getAttribute("direccion"))[0]);
                        client.setPassword(((String[]) request.getAttribute("password"))[0]);
                        client.setAdmin(admin);

                        // update
                        if (Client.update(client) > 0) {
                            request.setAttribute("uclient", client);
                            request.setAttribute("success", "Successfully updated");
                        } else {
                            request.setAttribute("err", "Error updating client");
                        }
                    } else {
                        Dispatch.go(request, response, "/WEB-INF/errors/404.jsp");
                    }

                }
                Dispatch.go(request, response, "/WEB-INF/clients/editfromadmin.jsp");
            } else {
                Dispatch.go(request, response, "/WEB-INF/errors/403.jsp");
            }
        }
    }

    private void updateClient(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        HttpSession session = request.getSession();
        synchronized (session) {
            if (session.getAttribute("client") != null) { // an user updating his profile, all ok
                boolean err = validateClient(request);
                String[] DNI = (String[]) request.getAttribute("DNI");

                if (!err) { // register process
                    Client client = Client.getClient(DNI[0]);
                    if (client != null) {
                        // prepare bean
                        client.setDNI(DNI[0]);
                        client.setNombre(((String[]) request.getAttribute("nombre"))[0]);
                        client.setFec_nac(Date.valueOf(((String[]) request.getAttribute("fec_nac"))[0]));
                        client.setDireccion(((String[]) request.getAttribute("direccion"))[0]);
                        client.setPassword(((String[]) request.getAttribute("password"))[0]);

                        // update
                        if (Client.update(client) > 0) {
                            session.setAttribute("client", client);
                            request.setAttribute("success", (session.getAttribute("locale") != "es") ? "Successfully updated" : "Actualizado correctamente");
                        } else {
                            request.setAttribute("err", (session.getAttribute("locale") != "es") ? "Error updating client" : "Error actualizando el cliente");
                        }
                    } else {
                        Dispatch.go(request, response, "/WEB-INF/errors/404.jsp");
                    }

                }
                Dispatch.go(request, response, "/WEB-INF/clients/edit.jsp");
            } else {
                Dispatch.go(request, response, "/WEB-INF/errors/403.jsp");
            }
        }
    }

    private void allclientstojson(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        String admin = MyUtils.getParamValue(request.getHeader("admin"));
        ObjectMapper mapper = new ObjectMapper();
        List<ClientSearch> clientes;
        PrintWriter out;
        try {
            out = response.getWriter();
            if (admin == null || !admin.equals("1")) {
                out.println("{}");
            } else {
                clientes = ClientSearch.retrieveAllClients();
                out.println(mapper.writeValueAsString(clientes));
            }

        } catch (JsonGenerationException | JsonMappingException e) {
            e.printStackTrace();
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
