<%-- 
    Document   : index
    Created on : 20/10/2020, 10:06:16 PM
    Author     : juanc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Clases.Producto"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Producto</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    </head>
    <body>
        <% 
            //cuando no hay sesion iniciada retorna al login
            String codEmp = (String)session.getAttribute("codEmp");
            if(codEmp == null){
                response.sendRedirect("index.jsp");
                return;
            }
        %>
        <h1>Listado de Productos</h1>
        <table>
            <tbody>
                <tr>
                    <td>
                        <a href="ServProducto?accion=nuevo">
                            <img src="imagenes/add_icon.png" width="30" title="Nuevo">
                        </a>
                    </td>
                    <td>
                        <a href="principal.jsp">
                            <img src="imagenes/exit_icon.png" width="30" title="Salir">
                        </a>
                    </td>
                </tr>
            </tbody>
        </table>
        <table border="1" class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>CODIGO</th>
                    <th>MARCA</th>
                    <th>CATEGORIA</th>
                    <th>PROVEEDOR</th>
                    <th>NOMBRE</th>
                    <th>PRECIO</th>
                    <th>EXISTENCIA</th>
                    <th>ORDEN COMPRA</th>
                    <th>SERIE FACTURA</th>
                    <th>NUMERO FACTURA</th>
                    <th>ACCIONES</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ArrayList<Producto> lista = (ArrayList<Producto>)request.getAttribute("listar");
                    for (int i = 0; i<lista.size(); i++){
                        Producto pro = lista.get(i);
                        %>
                        <tr>
                            <td><%= pro.getCodProducto()%></td>
                            <td><%= pro.getNombreMarca()%></td>
                            <td><%= pro.getNombreCate()%></td>
                            <td><%= pro.getNombreProv()%></td>
                            <td><%= pro.getNombre()%></td>
                            <td><%= pro.getPrecio()%></td>
                            <td><%= pro.getExistencia()%></td>
                            <td><%= pro.getOrden_compra()%></td>
                            <td><%= pro.getSerie_factura()%></td>
                            <td><%= pro.getNumero_factura()%></td>
                            <td>
                                <a href="ServProducto?accion=consultar&id=<%= pro.getIdProducto()%>">
                                    <img src="imagenes/edit_icon.png" width="30" title="Editar">
                                </a>
                                <a href="ServProducto?accion=eliminar&id=<%= pro.getIdProducto()%>" onclick="return confirm('¿Desea eliminar el Producto con codigo: <%= pro.getCodProducto()%>?')">
                                    <img src="imagenes/delete_icon.png" width="30" title="Borrar">
                                </a>
                            </td>
                        </tr>
                        <%
                    }
                %>
            </tbody>
        </table>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    </body>
</html>
