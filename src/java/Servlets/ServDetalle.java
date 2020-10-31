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
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
 * @author Eduardo
 */
public class ServDetalle extends HttpServlet {
    ArrayList<Producto> listaAgregados;
    int idCliente = 0;
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
            this.nuevaVenta(cnx, request, response);
        } else if (accion.equals("agregar")) {
            this.selectProducto(cnx, request, response);
        } else if (accion.equals("buscar")) {
            this.consultarCliente(cnx, request, response);
        } else if (accion.equals("pedido")) {
            //this.generarReporte(cnx, request, response);
            //this.verLista(cnx, request, response);
            this.agregarPedido(cnx, request, response);
        } else if (accion.equals("remover")) {
            this.removerItem(request, response);
        }
    }
    
    private void nuevaVenta (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            idCliente = 0;
            listaAgregados = new ArrayList<>();
            //al ser nuevo se genera un objeto vacio
            Producto pro = new Producto(0, 0, 0, 0, "", "", "", "", "", "", "", "", "", "");
            listaAgregados.add(pro);
            request.setAttribute("total", "0.00");
            request.setAttribute("listar", listaAgregados);
            request.getRequestDispatcher("Pages/Venta/detalle.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
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
            request.getRequestDispatcher("Pages/Venta/detalle.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void consultarCliente (Connection cnx, HttpServletRequest request, HttpServletResponse response)
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
                idCliente = rs.getInt(1); //variable global
                nombre = rs.getString(2);
                direccion = rs.getString(3);
                nit = rs.getString(4);
            }
            sta.close();
            
            request.setAttribute("nombre", nombre);
            request.setAttribute("direccion", direccion);
            request.setAttribute("nit", nit);
            request.getRequestDispatcher("Pages/Venta/cliente.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void agregarPedido (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        try {
            HttpSession sesion = request.getSession();
            int idEmpleado = (int)sesion.getAttribute("idEmpleado");
            
            //se crean las conexiones para el spr
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_INS_FACTURA(?, ?, ?)}");
            PreparedStatement sta = cnx.prepareCall(sb.toString());
            
            //se sustituyen los valores para los parametros
            sta.setInt(1, idEmpleado);
            sta.setInt(2, idCliente);
            sta.setString(3, String.valueOf(total));
            
            //se ejecuta el spr con los parametros
            ResultSet rs = sta.executeQuery();
            
            //se almacena el id factura generado
            int idFactura = 0;
            while (rs.next()) {
                idFactura = rs.getInt(1);
            }
            sta.close();
            //se inserta el detalle
            this.agregarDetalle(cnx, request, response, idFactura);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void agregarDetalle (Connection cnx, HttpServletRequest request, HttpServletResponse response, int idFactura)
        throws ServletException, IOException {
        try {
            //se crean las conexiones para el spr
            StringBuilder sb = new StringBuilder();
            sb.append("{call SPR_INS_DETALLE(?, ?, ?, ?)}");
            PreparedStatement sta;
            
            //se itera la lista
            Iterator itr = listaAgregados.iterator();
            while (itr.hasNext()) {
                Producto prod = (Producto)itr.next();
                if (prod.getIdProducto() != 0) {
                    sta = cnx.prepareCall(sb.toString());

                    //se sustituyen los valores para los parametros
                    sta.setInt(1, prod.getIdProducto());
                    sta.setInt(2, idFactura);
                    sta.setInt(3, Integer.parseInt(prod.getExistencia()));
                    sta.setString(4, String.valueOf(prod.getPrecio()));

                    //se ejecuta el spr con los parametros
                    sta.executeUpdate();
                    sta.close();
                }
            }
            request.getRequestDispatcher("principal.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    //metodo que sirve para listar en pantalla el contenido de la lista de productos agregados
    private void verLista (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        try {
            Iterator itr = listaAgregados.iterator();
            try (PrintWriter out = response.getWriter()) {
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Error</title>");            
                out.println("</head>");
                out.println("<body>");
                while (itr.hasNext()) {
                    Producto prod = (Producto)itr.next();
                    if (prod.getIdProducto() != 0) {    
                        out.println("<h1>id producto: " + prod.getIdProducto() + "</h1>");
                        out.println("<h1>id factura: idfactura</h1>");
                        out.println("<h1>cantidad: " + Integer.parseInt(prod.getExistencia()) + "</h1>");
                        out.println("<h>precio: " + Float.parseFloat(prod.getPrecio()) + "</h1>");
                        out.println("<h>-------------------</h1>");
                    }
                }
                out.println("</body>");
                out.println("</html>");
            }
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void removerItem (HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        try {
            //obtiene el id del producto a eliminar
            int idProducto = Integer.parseInt(request.getParameter("id"));
            
            //hace una iteracion y cuando encuentre el objeto lo remueve de la lista
            Iterator itr = listaAgregados.iterator();
            while (itr.hasNext()) {
                Producto prod = (Producto)itr.next();
                if (prod.getIdProducto() == idProducto) {    
                    itr.remove();
                    break;
                }
            }
            
            //iteracion para calcular la suma del total
            Iterator itr2 = listaAgregados.iterator();
            total = 0.00f;
            while (itr2.hasNext()) {
                Producto prod = (Producto)itr2.next();
                if (prod.getIdProducto() != 0) {
                    total += (Float.parseFloat(prod.getExistencia()) * Float.parseFloat(prod.getPrecio()));
                }
            }
            
            //retorna los valores
            DecimalFormat df = new DecimalFormat("#.##");
            request.setAttribute("total", String.valueOf(df.format(total)));
            request.setAttribute("listar", listaAgregados);
            request.getRequestDispatcher("Pages/Venta/detalle.jsp").forward(request, response);
        }catch(Exception e) {
            this.defaultError(e, response);
        }
    }
    
    private void generarReporte (Connection cnx, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        try {
            JasperDesign jdesign = JRXmlLoader.load("D:\\Proyectos\\NetBeansProjects\\Progra2_Ferreteria\\src\\java\\Utils\\report1.jrxml");
            String query = "select c.id_cliente, c.nombre_completo, c.direccion as 'cliente_direccion', c.nit from cliente c where c.id_cliente = 3";
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
            out.println("<title>Error</title>");            
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
