/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Clases.Producto;
import Utils.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Iterator;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author juanc
 */
public class ServListado extends HttpServlet {
ArrayList<Producto> listaAgregados;
 int idFactura;
 float total = 0.00f;
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
            this.verDetalle(cnx, request, response);
        } else if (accion.equals("Pagar")) {
            this.updatePagar(cnx, request, response);
            
        }
        //if == "detalle"
        //if == "pagar"
    }
    
    private void verDetalle (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
        PreparedStatement sta = cnx.prepareStatement("{call SPR_SEL_GRID_LISTADO}");
            ResultSet rs = sta.executeQuery();    
             ArrayList<Producto> lista = new ArrayList<>();
            while (rs.next()) {
                Producto p = new Producto(
                        rs.getInt(1),
                    rs.getString(2),
                    rs.getString(3)
                );
                lista.add(p);
            }
            request.setAttribute("listar", lista);
            request.getRequestDispatcher("Pages/Caja/index.jsp").forward(request, response);                     
            Iterator itr = listaAgregados.iterator();
            total = 0.00f;
            while (itr.hasNext()) {
                Producto prod = (Producto)itr.next();
                if (prod.getIdProducto() != 0) {
                    total += (Float.parseFloat(prod.getExistencia()) * Float.parseFloat(prod.getPrecio()));
                }
            }
            DecimalFormat df = new DecimalFormat("#.##");
            request.setAttribute("total", String.valueOf(df.format(total)));
            request.setAttribute("listar", listaAgregados);
            request.getRequestDispatcher("Pages/Caja/detalle.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
        
    /*
        metodo de detalle
        select * detalle d, producto p where d.id_producto = p.id_producto
            
        FOR DE LISTA QUE ESTA EN SERVDETALLE
            TOTAL += PRECIO * CANTIDAD
        retornas total
        retornas como lista
        dispacher hacia pages/caja/listado
    */
    
    /*
        metodo de pagar
        parametros a obtener:
        id_factura
        id_forma de pago
        
        SPR UPD PAGAR
        UPDATE FACTURA
        SET ID_FORMAPAGO = P_ID
        ESTADO = 'P' --> G GUARDAR P PAGAR
        WHERE ID_FACTURA = P_ID
    */
    private void selectProducto (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            //se obtienen los parametros
            int idProducto = Integer.parseInt(request.getParameter("selectProducto"));
            String cantidad = request.getParameter("txtCantidad");
            
            //se crean las conexiones para el spr
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_SEL_PRODUCTO_BY_ID(?)}");
            PreparedStatement sta = cnx.prepareCall(sb.toString());
            
            //se sustituyen los valores para los parametros
            sta.setInt(1, idProducto);
            
            //se ejecuta el spr con los parametros
            ResultSet rs = sta.executeQuery();
            
            while (rs.next()) {
                Producto pro = new Producto(
                    rs.getInt(1),
                    0,
                    0,
                    0,
                    rs.getString(5),
                    rs.getString(6),
                    rs.getString(7),
                    cantidad,
                    "",
                    "",
                    "",
                    "",
                    "",
                    ""
                );
                listaAgregados.add(pro);
            }
            sta.close();
            
            Iterator itr = listaAgregados.iterator();
            total = 0.00f;
            while (itr.hasNext()) {
                Producto prod = (Producto)itr.next();
                if (prod.getIdProducto() != 0) {
                    total += (Float.parseFloat(prod.getExistencia()) * Float.parseFloat(prod.getPrecio()));
                }
            }
            DecimalFormat df = new DecimalFormat("#.##");
            request.setAttribute("total", String.valueOf(df.format(total)));
            request.setAttribute("listar", listaAgregados);
            request.getRequestDispatcher("Pages/Caja/detalle.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
        private void consultarFactura (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            String nit = request.getParameter("txtNit");
            String nombre = request.getParameter("txtNombre");
            String direccion = request.getParameter("txtDireccion");
            
            //se crean las conexiones para el spr
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_INS_UPD_CLIENTE(?, ?, ?)}");
            PreparedStatement sta = cnx.prepareCall(sb.toString());
            
            //se sustituyen los valores para los parametros
            sta.setString(1, nit);
            sta.setString(2, nombre);
            sta.setString(3, direccion);
            
            //se ejecuta el spr con los parametros
            ResultSet rs = sta.executeQuery();
            
            //se almacenan los valores
            while (rs.next()) {
                idFactura = rs.getInt(1); //variable global
                nombre = rs.getString(2);
                direccion = rs.getString(3);
                nit = rs.getString(4);
            }
            sta.close();
            
            request.setAttribute("idCliente", idFactura);
            request.setAttribute("nombre", nombre);
            request.setAttribute("direccion", direccion);
            request.setAttribute("nit", nit);
            request.getRequestDispatcher("Pages/caja/detalle.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    private void updatePagar (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            //se obtienen los parametros
            int idFactura = Integer.parseInt(request.getParameter("id"));
            int idCliente  = Integer.parseInt(request.getParameter("id"));
            String total = request.getParameter("txtTotal");
            
            //se crean las conexiones para el spr
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_UPD_FACTURA(?, ?, ?)}");
            PreparedStatement sta = cnx.prepareCall(sb.toString());
            
            //se sustituyen los valores para los parametros
            //en el mismo orden del stored procedure
            sta.setInt(1, idFactura);
            sta.setInt(2, idCliente);
            sta.setString(3, total);
            
            //se ejecuta el spr con los parametros
            sta.executeUpdate();
            sta.close();
            
            //se redirige a la pagina de index
            //this.listPagar(cnx, request, response); <- no existe
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
            out.println("<h1>Error Caja retornado: " + e.getMessage() + "</h1>");
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
