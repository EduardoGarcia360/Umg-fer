<%-- 
    Document   : detalle
    Created on : 28-oct-2020, 22:32:55
    Author     : Eduardo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Utils.Conexion"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Clases.Producto"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
        %>
        <form method="POST">
            <label for="selectProducto">Productos</label><br>
            <select id="selProductos" name="selectProducto">
                <%
                    try{
                        Connection cnx = Conexion.getConexion();
                        PreparedStatement sta = cnx.prepareStatement("{call SPR_SEL_COMBO_PRODUCTO}");
                        ResultSet rs = sta.executeQuery();
                        while (rs.next()) {
                            int idProducto = rs.getInt(1);
                            String producto = rs.getString(2);
                %>
                            <option value="<%= idProducto%>">
                                <%= producto%>
                            </option>
                <%
                        }
                    } catch (Exception e) {
                        out.print(e.getMessage());
                    }
                %>
            </select>
            <br>
            <label for="nit">Cantidad</label><br>
            <input type="number" name="txtCantidad" min="0" value="0" step="1">
            <br>
            <input type="submit" name="btnGuardar" value="Agregar" onclick="form.action='ServDetalle?accion=agregar';">
        </form>
        <br>
        <br>
        <table id="tablaProductos">
            <tr>
              <th>Codigo</th>
              <th>Producto</th>
              <th>Precio</th>
              <th>Cantidad</th>
            </tr>
            <%
                ArrayList<Producto> lista = (ArrayList<Producto>)request.getAttribute("listar");
                for (int i = 0; i<lista.size(); i++){
                    Producto prod = lista.get(i);
                    if (prod.getIdProducto() != 0) {
                    %>
                        <tr>
                            <td><%= prod.getCodProducto()%></td>
                            <td><%= prod.getNombre()%></td>
                            <td><%= prod.getPrecio()%></td>
                            <!-- deje existencia porque funciona como la cantidad ingresada -->
                            <td><%= prod.getExistencia()%></td>
                        </tr>
                    <%
                    }
                }
                %>
        </table>
        <br>
        <label for="txtTotal">Total</label>
        <br>
        <input type="text" name="txtTotal" value="<%= total%>" disabled>
        <br>
        <form method="POST">
            <input type="submit" name="btnPedido" value="Agregar Pedido" onclick="form.action='ServDetalle?accion=pedido';">
        </form>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    </body>
</html>
