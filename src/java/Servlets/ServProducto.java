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
import Clases.Producto;
import Utils.Conexion;

/**
 *
 * @author juanc
 */
public class ServProducto extends HttpServlet {

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
            this.listProducto(cnx, request, response);
        }else if (accion.equals("nuevo")) {
            this.newProducto(cnx, request, response);
        }else if (accion.equals("insertar")) {
            this.addProducto(cnx, request, response);
        }else if (accion.equals("eliminar")) {
            this.deleteProducto(cnx, request, response);
        }else if (accion.equals("consultar")) {
            this.selectProducto(cnx, request, response);
        }else if (accion.equals("actualizar")) {
            this.updateProducto(cnx, request, response);
        }
    }
    
    private void listProducto (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            PreparedStatement sta = cnx.prepareStatement("{call SPR_SEL_GRID_PRODUCTO}");
            ResultSet rs = sta.executeQuery();
            ArrayList<Producto> lista = new ArrayList<>();
            while (rs.next()) {
                Producto pro = new Producto( 
                    rs.getInt(1),
                    rs.getInt(2),
                    rs.getInt(3),
                    rs.getInt(4),   
                    rs.getString(5),
                    rs.getString(6),
                    rs.getString(7),
                    rs.getString(8),
                    rs.getString(9),
                    rs.getString(10),
                    rs.getString(11),
                    rs.getString(12),
                    rs.getString(13),
                    rs.getString(14)
                );
                lista.add(pro);
            }
            request.setAttribute("listar", lista);
            request.getRequestDispatcher("Pages/Producto/index.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void newProducto (Connection cnx, HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        try {
            ArrayList<Producto> lista = new ArrayList<>();
            //al ser nuevo se genera un objeto vacio
            Producto pro = new Producto(0, 0, 0, 0, "", "", "", "", "", "", "", "", "", "");
            lista.add(pro);
            request.setAttribute("gestion", lista);
            request.getRequestDispatcher("Pages/Producto/gestion.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void addProducto (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            //se obtienen los parametros
            int idMarca = Integer.parseInt(request.getParameter("selectMarca"));
            int idCategoria = Integer.parseInt(request.getParameter("selectCategoria"));
            int idProveedor = Integer.parseInt(request.getParameter("selectProveedor"));
            String codProducto = request.getParameter("txtCodProducto");
            String nombre = request.getParameter("txtNombre");
            String precio = request.getParameter("txtPrecio");
            String existencia = request.getParameter("txtExistencia");
            String orden_compra = request.getParameter("txtOrden_Compra");
            String serie_factura = request.getParameter("txtSerie_fac");
            String numero_factura = request.getParameter("txtNumero_fac");
            
            //se crean las conexiones para el spr
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_INS_PRODUCTO(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
            PreparedStatement sta = cnx.prepareCall(sb.toString());
            
            //se sustituyen los valores para los parametros
            //en el mismo orden del stored procedure
            sta.setInt(1, idMarca);
            sta.setString(2, codProducto);
            sta.setString(3, nombre);
            sta.setString(4, precio);
            sta.setString(5, existencia);
            sta.setString(6, orden_compra);
            sta.setString(7, serie_factura);
            sta.setString(8, numero_factura);
            sta.setInt(9, idCategoria);
            sta.setInt(10, idProveedor);
            
            //se ejecuta el spr con los parametros
            sta.executeUpdate();
            sta.close();
            
            //se redirige a la pagina de index
            this.listProducto(cnx, request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void deleteProducto (Connection cnx, HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        try {
            //se obtienen los parametros
            int idProducto = Integer.parseInt(request.getParameter("id"));

            //se crean las conexiones para el spr
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_DEL_PRODUCTO(?)}");
            PreparedStatement sta = cnx.prepareCall(sb.toString());
            
            //se sustituyen los valores para los parametros
            sta.setInt(1, idProducto);
            
            //se ejecuta el spr con los parametros
            sta.executeUpdate();
            sta.close();
            
            //se vuelve a cargar la pagina del index
            this.listProducto(cnx, request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void selectProducto (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            //se obtienen los parametros
            int idProducto = Integer.parseInt(request.getParameter("id"));
            
            //se crean las conexiones para el spr
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_SEL_PRODUCTO_BY_ID(?)}");
            PreparedStatement sta = cnx.prepareCall(sb.toString());
            
            //se sustituyen los valores para los parametros
            sta.setInt(1, idProducto);
  
            
            //se ejecuta el spr con los parametros
            ResultSet rs = sta.executeQuery();
            ArrayList<Producto> lista = new ArrayList<>();
            while (rs.next()) {
                //cambiar
                Producto pro = new Producto(
                    rs.getInt(1),
                    rs.getInt(2),
                    rs.getInt(3),
                    rs.getInt(4),    
                    rs.getString(5),
                    rs.getString(6),
                    rs.getString(7),
                    rs.getString(8),
                    rs.getString(9),
                    rs.getString(10),
                    rs.getString(11),
                    rs.getString(12),
                    rs.getString(13),
                    rs.getString(14)    
                );
                lista.add(pro);
            }
            sta.close();
            request.setAttribute("gestion", lista);
            request.getRequestDispatcher("Pages/Producto/gestion.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void updateProducto (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            //se obtienen los parametros
            int idProducto = Integer.parseInt(request.getParameter("id"));
            int idMarca = Integer.parseInt(request.getParameter("selectMarca"));
            int idCategoria = Integer.parseInt(request.getParameter("selectCategoria"));
            int idProveedor = Integer.parseInt(request.getParameter("selectProveedor"));
            String codProducto = request.getParameter("txtCodProducto");
            String nombre = request.getParameter("txtNombre");
            String precio = request.getParameter("txtPrecio");
            String existencia = request.getParameter("txtExistencia");
            String orden_compra = request.getParameter("txtOrden_Compra");
            String serie_factura = request.getParameter("txtSerie_fac");
            String numero_factura = request.getParameter("txtNumero_fac");
            
            //se crean las conexiones para el spr
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_UPD_PRODUCTO(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
            PreparedStatement sta = cnx.prepareCall(sb.toString());
            
            //se sustituyen los valores para los parametros
            //en el mismo orden del stored procedure
            sta.setInt(1, idProducto);
            sta.setInt(2, idMarca);
            sta.setInt(3, idCategoria);
            sta.setInt(4, idProveedor);
            sta.setString(5, codProducto);
            sta.setString(6, nombre);
            sta.setString(7, precio);
            sta.setString(8, existencia);
            sta.setString(9, orden_compra);
            sta.setString(10, serie_factura);
            sta.setString(11, numero_factura);
   
            //se ejecuta el spr con los parametros
            sta.executeUpdate();
            sta.close();
            
            //se redirige a la pagina de index
            this.listProducto(cnx, request, response);
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
            out.println("<h1>Error Producto retornado: " + e.getMessage() + "</h1>");
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
