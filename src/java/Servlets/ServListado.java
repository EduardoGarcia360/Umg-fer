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
        if (accion.equals("nuevo")) {
            this.nuevoCaja(cnx, request, response);
        } else if (accion.equals("Pagar")) {
            this.selectProducto(cnx, request, response);
        }
    }
    
    private void nuevoCaja (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            listaAgregados = new ArrayList<>();
            //al ser nuevo se genera un objeto vacio
            Producto pro = new Producto(0, 0, 0, 0, "", "", "", "", "", "", "", "", "", "");
            listaAgregados.add(pro);
            request.setAttribute("total", "0.00");
            request.setAttribute("listar", listaAgregados);
            request.getRequestDispatcher("Pages/Caja/listado.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void selectProducto (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            //se obtienen los parametros
            int idFormaPago = Integer.parseInt(request.getParameter("selectFormaPago"));
            String efectivo = request.getParameter("txtEfectivo");
            
            //se crean las conexiones para el spr
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_SEL_PRODUCTO_BY_ID(?)}");
            PreparedStatement sta = cnx.prepareCall(sb.toString());
            
            //se sustituyen los valores para los parametros
            sta.setInt(1, idFormaPago);
            
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
                    efectivo,
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
            float total = 0.00f;
            while (itr.hasNext()) {
                Producto prod = (Producto)itr.next();
                if (prod.getIdProducto() != 0) {
                    total += (Float.parseFloat(prod.getExistencia()) * Float.parseFloat(prod.getPrecio()));
                }
            }
            DecimalFormat df = new DecimalFormat("#.##");
            request.setAttribute("total", String.valueOf(df.format(total)));
            request.setAttribute("listar", listaAgregados);
            request.getRequestDispatcher("Pages/Caja/listado.jsp").forward(request, response);
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
            out.println("<h1>Error Venta retornado: " + e.getMessage() + "</h1>");
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
