<%-- 
    Document   : Pedidos
    Created on : 29/10/2020, 02:20:58 AM
    Author     : juanc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Utils.Conexion"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Clases.Producto"%>
<%@page import="Clases.Factura"%>
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
        <table id="tablaPedidos">
            <tr>
              <th>PEDIDO-NO.</th>
              <th>CLIENTE</th>
              <th>TOTAL</th>
              <th>ACCION</th>
            </tr>
            <%
                ArrayList<Factura> lista = (ArrayList<Factura>)request.getAttribute("listar");
                for (int i = 0; i<lista.size(); i++){
                    Factura ft = lista.get(i);
                    if (ft.getIdFactura() != 0) {
                    %>
                        <tr>
                            <td><%= ft.getIdFactura()%></td>
                            <td><%= ft.getNombreCliente()%></td>
                            <td><%= ft.getTotal()%></td>
                            <td>
                            <input type="button" value="Listar" onclick="location.href='ServListado?accion=listar&id=<%= ft.getIdFactura()%>&idcliente=<%= ft.getIdCliente()%>';" />
                            </td>
                        </tr>
                    <%
                    }
                }
                %>
                
        </table>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    </body>
</html>
   
