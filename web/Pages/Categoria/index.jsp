<%-- 
    Document   : index
    Created on : 11-oct-2020, 17:14:21
    Author     : Eduardo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Clases.Categoria"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Categoria</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    </head>
    <body>
        <h1>Listado de Categoria</h1>
        <table>
            <tbody>
                <tr>
                    <td>
                        <a href="ServCategoria?accion=nuevo">
                            <img src="imagenes/add_icon.png" width="30" title="Nuevo">
                        </a>
                    </td>
                    <td>
                        <a href="index.jsp">
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
                    <th>NOMBRE</th>
                    <th>ACCIONES</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ArrayList<Categoria> lista = (ArrayList<Categoria>)request.getAttribute("listar");
                    for (int i = 0; i<lista.size(); i++){
                        Categoria c = lista.get(i);
                        %>
                        <tr>
                            <td><%= c.getCodCategoria()%></td>
                            <td><%= c.getNombre()%></td>
                            <td>
                                <a href="ServCategoria?accion=consultar&id=<%= c.getIdCategoria()%>">
                                    <img src="imagenes/edit_icon.png" width="30" title="Editar">
                                </a>
                                <a href="ServCategoria?accion=eliminar&id=<%= c.getIdCategoria()%>" onclick="return confirm('¿Desea eliminar la Marca con codigo: <%= c.getCodCategoria()%>?')">
                                    <img src="imagenes/delete_icon.png" width="30" title="Editar">
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
