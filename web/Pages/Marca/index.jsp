<%-- 
    Document   : index
    Created on : 11-oct-2020, 17:18:52
    Author     : Eduardo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Clases.Marca"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Marca</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    </head>
    <body>
        <h1>Listado de Marca</h1>
        <table>
            <tbody>
                <tr>
                    <td>
                        <a href="ServMarca?accion=nuevo">
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
                    ArrayList<Marca> lista = (ArrayList<Marca>)request.getAttribute("listar");
                    for (int i = 0; i<lista.size(); i++){
                        Marca m = lista.get(i);
                        %>
                        <tr>
                            <td><%= m.getCodMarca()%></td>
                            <td><%= m.getNombre()%></td>
                            <td>
                                <a href="ServMarca?accion=consultar&id=<%= m.getIdMarca()%>">
                                    <img src="imagenes/edit_icon.png" width="30" title="Editar">
                                </a>
                                <a href="ServMarca?accion=eliminar&id=<%= m.getIdMarca()%>" onclick="return confirm('¿Desea eliminar la Marca con codigo: <%= m.getCodMarca()%>?')">
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
