/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Clases.Empleado;
import Utils.Conexion;
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

/**
 *
 * @author Eduardo
 */
public class ServEmpleado extends HttpServlet {

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
            this.listEmpleado(cnx, request, response);
        }else if (accion.equals("nuevo")) {
            this.newEmpleado(cnx, request, response);
        }else if (accion.equals("insertar")) {
            this.addEmpleado(cnx, request, response);
        }else if (accion.equals("eliminar")) {
            this.deleteEmpleado(cnx, request, response);
        }else if (accion.equals("consultar")) {
            this.selectEmpleado(cnx, request, response);
        }else if (accion.equals("actualizar")) {
            this.updateEmpleado(cnx, request, response);
        }
    }
    
    private void listEmpleado (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            PreparedStatement sta = cnx.prepareStatement("{call SPR_SEL_GRID_EMPLEADO}");
            ResultSet rs = sta.executeQuery();
            ArrayList<Empleado> lista = new ArrayList<>();
            while (rs.next()) {
                Empleado emp = new Empleado(
                    rs.getInt(1),
                    rs.getInt(2),
                    rs.getString(3),
                    rs.getString(4),
                    rs.getString(5),
                    rs.getString(6),
                    rs.getString(7),
                    rs.getString(8),
                    rs.getString(9),
                    rs.getString(10),
                    rs.getString(11),
                    rs.getString(12),
                    rs.getString(13)
                );
                lista.add(emp);
            }
            request.setAttribute("listar", lista);
            request.getRequestDispatcher("Pages/Empleado/index.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void newEmpleado (Connection cnx, HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        try {
            ArrayList<Empleado> lista = new ArrayList<>();
            //al ser nuevo se genera un objeto vacio
            Empleado emp = new Empleado(0, 0, "", "", "", "", "", "", "", "", "", "", "");
            lista.add(emp);
            request.setAttribute("gestion", lista);
            request.getRequestDispatcher("Pages/Empleado/gestion.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void addEmpleado (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            //se obtienen los parametros
            int idPuesto = Integer.parseInt(request.getParameter("selectPuesto"));
            String codigo = request.getParameter("txtCodigo");
            String usuario = request.getParameter("txtUsuario");
            String pass = request.getParameter("txtPass");
            String nombre = request.getParameter("txtNombre");
            String apellido = request.getParameter("txtApellido");
            String fecha = request.getParameter("txtFechanac");
            String dire = request.getParameter("txtDire");
            String telefono = request.getParameter("txtTelefono");
            String dpi = request.getParameter("txtDpi");
            String correo = request.getParameter("txtCorreo");
            
            //se crean las conexiones para el spr
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_INS_EMPLEADO(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
            PreparedStatement sta = cnx.prepareCall(sb.toString());
            
            //se sustituyen los valores para los parametros
            //en el mismo orden del stored procedure
            sta.setInt(1, idPuesto);
            sta.setString(2, codigo);
            sta.setString(3, usuario);
            sta.setString(4, pass);
            sta.setString(5, nombre);
            sta.setString(6, apellido);
            sta.setString(7, fecha);
            sta.setString(8, dire);
            sta.setString(9, telefono);
            sta.setString(10, dpi);
            sta.setString(11, correo);
            
            //se ejecuta el spr con los parametros
            sta.executeUpdate();
            sta.close();
            
            //se redirige a la pagina de index
            this.listEmpleado(cnx, request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void deleteEmpleado (Connection cnx, HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        try {
            //se obtienen los parametros
            int idPuesto = Integer.parseInt(request.getParameter("id"));
            
            //se crean las conexiones para el spr
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_DEL_EMPLEADO(?)}");
            PreparedStatement sta = cnx.prepareCall(sb.toString());
            
            //se sustituyen los valores para los parametros
            sta.setInt(1, idPuesto);
            
            //se ejecuta el spr con los parametros
            sta.executeUpdate();
            sta.close();
            
            //se vuelve a cargar la pagina del index
            this.listEmpleado(cnx, request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void selectEmpleado (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            //se obtienen los parametros
            int idPuesto = Integer.parseInt(request.getParameter("id"));
            
            //se crean las conexiones para el spr
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_SEL_EMPLEADO_BY_ID(?)}");
            PreparedStatement sta = cnx.prepareCall(sb.toString());
            
            //se sustituyen los valores para los parametros
            sta.setInt(1, idPuesto);
            
            //se ejecuta el spr con los parametros
            ResultSet rs = sta.executeQuery();
            ArrayList<Empleado> lista = new ArrayList<>();
            while (rs.next()) {
                Empleado emp = new Empleado(
                    rs.getInt(1),
                    rs.getInt(2),
                    rs.getString(3),
                    rs.getString(4),
                    rs.getString(5),
                    rs.getString(6),
                    rs.getString(7),
                    rs.getString(8),
                    rs.getString(9),
                    rs.getString(10),
                    rs.getString(11),
                    rs.getString(12),
                    rs.getString(13)
                );
                lista.add(emp);
            }
            sta.close();
            request.setAttribute("gestion", lista);
            request.getRequestDispatcher("Pages/Empleado/gestion.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void updateEmpleado (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            //se obtienen los parametros
            int idEmpleado = Integer.parseInt(request.getParameter("id"));
            int idPuesto = Integer.parseInt(request.getParameter("selectPuesto"));
            String codigo = request.getParameter("txtCodigo");
            String usuario = request.getParameter("txtUsuario");
            String pass = request.getParameter("txtPass");
            String nombre = request.getParameter("txtNombre");
            String apellido = request.getParameter("txtApellido");
            String fecha = request.getParameter("txtFechanac");
            String dire = request.getParameter("txtDire");
            String telefono = request.getParameter("txtTelefono");
            String dpi = request.getParameter("txtDpi");
            String correo = request.getParameter("txtCorreo");
            
            //se crean las conexiones para el spr
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_UPD_EMPLEADO(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
            PreparedStatement sta = cnx.prepareCall(sb.toString());
            
            //se sustituyen los valores para los parametros
            //en el mismo orden del stored procedure
            sta.setInt(1, idPuesto);
            sta.setString(2, codigo);
            sta.setString(3, usuario);
            sta.setString(4, pass);
            sta.setString(5, nombre);
            sta.setString(6, apellido);
            sta.setString(7, fecha);
            sta.setString(8, dire);
            sta.setString(9, telefono);
            sta.setString(10, dpi);
            sta.setString(11, correo);
            sta.setInt(12, idEmpleado);
            
            //se ejecuta el spr con los parametros
            sta.executeUpdate();
            sta.close();
            
            //se redirige a la pagina de index
            this.listEmpleado(cnx, request, response);
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
            out.println("<title>Error</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Error Empleado retornado: " + e.getMessage() + "</h1>");
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
