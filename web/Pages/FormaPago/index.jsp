<%-- 
    Document   : index
    Created on : 14-oct-2020, 10:46:46
    Author     : Eduardo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Clases.FormaPago"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forma de Pago</title>
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
        <h1>Listado Formas de Pago</h1>
        <table>
            <tbody>
                <tr>
                    <td>
                        <a href="ServFormaPago?accion=nuevo">
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
                    <th>NOMBRE</th>
                    <th>ACCIONES</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ArrayList<FormaPago> lista = (ArrayList<FormaPago>)request.getAttribute("listar");
                    for (int i = 0; i<lista.size(); i++){
                        FormaPago fp = lista.get(i);
                        %>
                        <tr>
                            <td><%= fp.getCodPago()%></td>
                            <td><%= fp.getNombre()%></td>
                            <td>
                                <a href="ServFormaPago?accion=consultar&id=<%= fp.getIdFormaPago()%>">
                                    <img src="imagenes/edit_icon.png" width="30" title="Editar">
                                </a>
                                <a href="ServFormaPago?accion=eliminar&id=<%= fp.getIdFormaPago()%>" onclick="return confirm('¿Desea eliminar la forma de pago con codigo: <%= fp.getCodPago()%>?')">
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
