/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Clases.Categoria;
import Utils.Conexion;
import java.sql.SQLException;

/**
 *
 * @author Eduardo
 */
public class ServCategoria extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String accion = request.getParameter("accion");
        Connection cnx = Conexion.getConexion();
        if (accion.equals("listar")) {
            this.listCategoria(cnx, request, response);
        }else if (accion.equals("nuevo")) {
            this.newCategoria(cnx, request, response);
        }else if (accion.equals("insertar")) {
            this.addCategoria(cnx, request, response);
        }else if (accion.equals("eliminar")) {
            this.deleteCategoria(cnx, request, response);
        }else if (accion.equals("consultar")) {
            this.selectCategoria(cnx, request, response);
        }else if (accion.equals("actualizar")) {
            this.updateCategoria(cnx, request, response);
        }
    }
    
    private void listCategoria (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            PreparedStatement sta = cnx.prepareStatement("{call SPR_SEL_GRID_CATEGORIA}");
            ResultSet rs = sta.executeQuery();
            ArrayList<Categoria> lista = new ArrayList<>();
            while (rs.next()) {
                Categoria c = new Categoria(
                    rs.getInt(1),
                    rs.getString(2),
                    rs.getString(3)
                );
                lista.add(c);
            }
            request.setAttribute("listar", lista);
            request.getRequestDispatcher("Pages/Categoria/index.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void newCategoria (Connection cnx, HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        try {
            ArrayList<Categoria> lista = new ArrayList<>();
            //al ser nuevo se genera un objeto vacio
            Categoria c = new Categoria(0, "", "");
            lista.add(c);
            request.setAttribute("gestion", lista);
            request.getRequestDispatcher("Pages/Categoria/gestion.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void addCategoria (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            //se obtienen los parametros
            String codigo = request.getParameter("txtCodigo");
            String nombre = request.getParameter("txtNombre");
            
            //se crean las conexiones para el spr
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_INS_CATEGORIA(?, ?)}");
            PreparedStatement sta = cnx.prepareCall(sb.toString());
            
            //se sustituyen los valores para los parametros
            //en el mismo orden del stored procedure
            sta.setString(1, codigo);
            sta.setString(2, nombre);
            
            //se ejecuta el spr con los parametros
            sta.executeUpdate();
            sta.close();
            
            //se redirige a la pagina de index
            this.listCategoria(cnx, request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void deleteCategoria (Connection cnx, HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        try {
            //se obtienen los parametros
            int idCategoria = Integer.parseInt(request.getParameter("id"));
            
            //se crean las conexiones para el spr
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_DEL_CATEGORIA(?)}");
            PreparedStatement sta = cnx.prepareCall(sb.toString());
            
            //se sustituyen los valores para los parametros
            sta.setInt(1, idCategoria);
            
            //se ejecuta el spr con los parametros
            sta.executeUpdate();
            sta.close();
            
            //se vuelve a cargar la pagina del index
            this.listCategoria(cnx, request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void selectCategoria (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            //se obtienen los parametros
            int idCategoria = Integer.parseInt(request.getParameter("id"));
            
            //se crean las conexiones para el spr
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_SEL_CATEGORIA_BY_ID(?)}");
            PreparedStatement sta = cnx.prepareCall(sb.toString());
            
            //se sustituyen los valores para los parametros
            sta.setInt(1, idCategoria);
            
            //se ejecuta el spr con los parametros
            ResultSet rs = sta.executeQuery();
            ArrayList<Categoria> lista = new ArrayList<>();
            while (rs.next()) {
                Categoria c = new Categoria(
                    rs.getInt(1),
                    rs.getString(2),
                    rs.getString(3)
                );
                lista.add(c);
            }
            sta.close();
            request.setAttribute("gestion", lista);
            request.getRequestDispatcher("Pages/Categoria/gestion.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void updateCategoria (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            //se obtienen los parametros
            int idCategoria = Integer.parseInt(request.getParameter("id"));
            String codigo = request.getParameter("txtCodigo");
            String nombre = request.getParameter("txtNombre");
            
            //se crean las conexiones para el spr
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_UPD_CATEGORIA(?, ?, ?)}");
            PreparedStatement sta = cnx.prepareCall(sb.toString());
            
            //se sustituyen los valores para los parametros
            //en el mismo orden del stored procedure
            sta.setInt(1, idCategoria);
            sta.setString(2, nombre);
            sta.setString(3, codigo);
            
            //se ejecuta el spr con los parametros
            sta.executeUpdate();
            sta.close();
            
            //se redirige a la pagina de index
            this.listCategoria(cnx, request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void defaultError (Exception e, HttpServletResponse response)
        throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>ERROR</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Error Categoria retornado: " + e.getMessage() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
