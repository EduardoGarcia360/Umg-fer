/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Clases.DetalleFactura;
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
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.design.JRDesignQuery;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

/**
 *
 * @author juanc
 */
public class ServListado extends HttpServlet {
ArrayList<Producto> listaAgregados;
 int idDetalleFactura;
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
        if (accion.equals("nuevo")) {
            this.paginaEnBlanco(cnx, request, response);
        } else if (accion.equals("Pagar")) {
            this.updatePagar(cnx, request, response);
            //this.generarReporte(cnx, request, response);
        } else if (accion.equals("factura")) {
            this.generarReporte(cnx, request, response);
        } else if (accion.equals("listar")) {
            this.verDetalleFactura(cnx, request, response);
        }
    }
    
    private void paginaEnBlanco (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {   
             ArrayList<DetalleFactura> lista = new ArrayList<>();
             DetalleFactura df = new DetalleFactura(
                    0,
                    "",    
                    "",
                    "",
                    ""
                );
            lista.add(df);
            request.setAttribute("listar", lista);
            request.getRequestDispatcher("Pages/Caja/listado.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void verDetalleFactura (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            int idFactura = Integer.parseInt(request.getParameter("id"));
            
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_SEL_GRID_LISTADO(?)}");
            PreparedStatement sta = cnx.prepareCall(sb.toString());
            
            //se sustituyen los valores para los parametros
            sta.setInt(1, idFactura);
            ResultSet rs = sta.executeQuery();    
             ArrayList<DetalleFactura> lista = new ArrayList<>();
            while (rs.next()) {
                DetalleFactura df = new DetalleFactura(
                    rs.getInt(1),
                    rs.getString(2),    
                    rs.getString(3),
                    rs.getString(4),
                    rs.getString(5)
                );
                lista.add(df);
            }
            
            request.setAttribute("idFactura", String.valueOf(idFactura));
            request.setAttribute("listar", lista);
            request.getRequestDispatcher("Pages/Caja/listado.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void updatePagar (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            //se obtienen los parametros
            int idFactura = Integer.parseInt(request.getParameter("idfactura"));
            int idFormaPago = Integer.parseInt(request.getParameter("selectFormaPago"));
            
            
            //se crean las conexiones para el spr
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_UPD_FACTURA(?, ?)}");
            PreparedStatement sta = cnx.prepareCall(sb.toString());
            
            //se sustituyen los valores para los parametros
            //en el mismo orden del stored procedure
            sta.setInt(1, idFactura);
            sta.setInt(2, idFormaPago);
            
            //se ejecuta el spr con los parametros
            sta.executeUpdate();
            
            //se genera el reporte de la factura del cliente
            this.generarReporte(cnx, request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void generarReporte (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        try {
            String idCliente = request.getParameter("idcliente");
            JasperDesign jdesign = JRXmlLoader.load("C:\\Users\\juanc\\Documents\\NetBeansProjects\\Umg-fer\\src\\java\\Utils\\report1.jrxml");
            //sustituir en el parametro
            String query = "select c.id_cliente, c.nombre_completo, c.direccion as 'cliente_direccion', c.nit from cliente c where c.id_cliente = 1";
            JRDesignQuery upQuery = new JRDesignQuery();
            upQuery.setText(query);
            
            jdesign.setQuery(upQuery);
            
            JasperReport jreport = JasperCompileManager.compileReport(jdesign);
            JasperPrint jprint = JasperFillManager.fillReport(jreport, null,  cnx);
            
            ServletOutputStream sos = response.getOutputStream();
            response.setContentType("application/pdf");
            JasperExportManager.exportReportToPdfStream(jprint, sos);
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
