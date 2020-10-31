/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Clases.Detalle;
import Clases.Factura;
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
import javax.servlet.http.HttpSession;
import Clases.Producto;

/**
 *
 * @author juanc
 */
public class ServPedidos extends HttpServlet {
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
            this.selectPedidos(cnx, request, response);   
        } else if (accion.equals("Pedidos")) {
            this.consultarPedidos(cnx, request, response);
            //this.consultarPedidos(cnx, request, response);
        }
    }
    
    private void selectPedidos (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            PreparedStatement sta = cnx.prepareStatement("{call SPR_SEL_GRID_PEDIDOS_GRABADOS}");
            ResultSet rs = sta.executeQuery();
            ArrayList<Factura> lista = new ArrayList<>();
            while (rs.next()) {
                Factura pr = new Factura();
                lista.add(pr);
            }
            request.setAttribute("listar", lista);
            request.getRequestDispatcher("Pages/Caja/index.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    private void consultarPedidos (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            //se obtienen los parametros
            int idFactura = Integer.parseInt(request.getParameter("id"));
            
            //se crean las conexiones para el spr
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_SEL_PRODUCTOS_BY_ID(?)}");
            PreparedStatement sta = cnx.prepareCall(sb.toString());
            
            //se sustituyen los valores para los parametros
            sta.setInt(1, idFactura);
            
            //se ejecuta el spr con los parametros
            ResultSet rs = sta.executeQuery();
            ArrayList<Detalle> lista = new ArrayList<>();
            /*while (rs.next()) {
                Detalle c = new Detalle(
                    rs.getInt(1),
                    rs.getInt(2),,    
                    rs.getString(2),
                    rs.getString(3)
                );
                lista.add(c);
            }*/
            sta.close();
            request.setAttribute("gestion", lista);
            request.getRequestDispatcher("Pages/Categoria/gestion.jsp").forward(request, response);
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
            out.println("<title>Servlet ServPedidos</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Error Pedido retornado:" + e.getMessage() + "</h1>");
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
