<%-- 
    Document   : listado
    Created on : 29/10/2020, 02:22:05 AM
    Author     : juanc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Utils.Conexion"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Clases.DetalleFactura"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listado de Productos</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <style>
            table {
              font-family: arial, sans-serif;
              border-collapse: collapse;
              width: 100%;
              margin-bottom: 10px;
            }

            td, th {
              border: 1px solid #dddddd;
              text-align: left;
              padding: 8px;
            }

            tr:nth-child(even) {
              background-color: #dddddd;
            }
        </style>
    </head>
    <body>
        <% 
            //cuando no hay sesion iniciada retorna al login
            String codEmp = (String)session.getAttribute("codEmp");
            if(codEmp == null){
                response.sendRedirect("index.jsp");
                return;
            }
            String total = (String)request.getAttribute("total");
            String idFactura = (String)request.getAttribute("idFactura");
        %>
        <br>
        <br>
        <table id="tablaProductos">
            <label for="listar">Listado de Productos</label><br>
            <tr>
              <th>Codigo</th>
              <th>Producto</th>
              <th>Precio</th>
              <th>Cantidad</th>
            </tr>
            <%
                ArrayList<DetalleFactura> lista = (ArrayList<DetalleFactura>)request.getAttribute("listar");
                for (int i = 0; i<lista.size(); i++){
                    DetalleFactura df = lista.get(i);
                    if (df.getIdDetalleFactura() != 0) {
                    %>
                        <tr>
                            <td><%= df.getCodProducto()%></td>
                            <td><%= df.getNombreProducto()%></td>
                            <td><%= df.getPrecio()%></td>
                            <td><%= df.getCantidad()%></td>
                        </tr>
                    <%
                    }
                }
                %>
        </table>
        </table>
        <form method="POST" target="_blank">
            <label for="selectFormaPago">FormaPago</label><br>
            <select id="selFormaPago" name="selectFormaPago">
                <%
                    try{
                        Connection cnx = Conexion.getConexion();
                        PreparedStatement sta = cnx.prepareStatement("{call SPR_SEL_COMBO_FORMA_PAGO}");
                        ResultSet rs = sta.executeQuery();
                        while (rs.next()) {
                            int idFormaPago = rs.getInt(1);
                            String formapago = rs.getString(2);
                %>
                            <option value="<%= idFormaPago%>">
                                <%= formapago%>
                            </option>
                <%
                        }
                    } catch (Exception e) {
                        out.print(e.getMessage());
                    }
                %>
            </select>
            <br>
            <label for="pagar">Efectivo</label><br>
            <input type="number" name="txtEfectivo" min="0" value="0" step="any">
            <br>
            <label for="txtTotal">Total</label>
            <br>
            <input type="text" name="txtTotal" value="<%= total%>" disabled>
            <br>
            <input type="submit" name="btnGuardar" value="Pagar" onclick="form.action='ServListado?accion=pagar&idfactura=<%= idFactura%>';"
            <br>
        </form>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    </body>
</html>