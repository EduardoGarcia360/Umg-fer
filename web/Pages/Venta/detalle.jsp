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
        <label for="selectProducto">Productos</label><br>
        <select id="selProductos" name="selectProducto" onchange="clickSelectProducto()">
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
        <button type="button" onclick="agregarFila()">Agregar</button>
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
                %>
        </table>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
        <script>
            function agregarFila() {
              var table = document.getElementById("tablaProductos");
              var row = table.insertRow(-1);
              var cell1 = row.insertCell(0);
              var cell2 = row.insertCell(1);
              var cell3 = row.insertCell(2);
              var cell4 = row.insertCell(3);
              cell1.innerHTML = "NEW CELL1";
              cell2.innerHTML = "NEW CELL2";
              cell3.innerHTML = "NEW CELL2";
              cell4.innerHTML = "NEW CELL2";
            }
            /*function clickSelectProducto() {
                var selectBox = document.getElementById("selProductos");
                var selectedValue = selectBox.options[selectBox.selectedIndex].value;
                try{
                    Connection cnx = Conexion.getConexion();
                    PreparedStatement sta = cnx.prepareStatement("{call SPR_SEL_COMBO_PRODUCTO}");
                    ResultSet rs = sta.executeQuery();
                    while (rs.next()) {
                        //int idProducto = rs.getInt(1);
                        String producto = rs.getString(2);
                        alert(producto);
                    }
                } catch (Exception e) {
                    out.print(e.getMessage());
                }
                //alert(selectedValue);
            }*/
        </script>
    </body>
</html>
