<%-- 
    Document   : gestion
    Created on : 11-oct-2020, 21:21:07
    Author     : Eduardo
&txtCodigo=<%= p.getCodPuesto()%>&txtNombre=<%= p.getNombre()%>
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Clases.Puesto"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion - Paciente</title>
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
        <h1>Gestion de Puestos</h1>
        <form method="POST">
            <table border="1" class="table table-striped table-bordered">
                <tbody>
                    <%
                    ArrayList<Puesto> lista = (ArrayList<Puesto>)request.getAttribute("gestion");
                    for (int i = 0; i<lista.size(); i++){
                        Puesto p = lista.get(i);
                        %>
                        <tr>
                            <td>CODIGO</td>
                            <td>
                                <input type="text" name="txtCodigo" value="<%= p.getCodPuesto()%>">
                            </td>
                        </tr>
                        <tr>
                            <td>NOMBRE</td>
                            <td>
                                <input type="text" name="txtNombre" value="<%= p.getNombre()%>">
                            </td>
                        </tr>
                        <% 
                            if (p.getIdPuesto() == 0) {
                        %>
                        <tr>
                            <td></td>
                            <td>
                                <input type="submit" name="btnGuardar" value="Guardar" onclick="form.action='ServPuesto?accion=insertar';">
                                <input type="button" value="Cancelar" onclick="location.href='ServPuesto?accion=listar';" />
                            </td>
                        </tr>
                        <%
                            } else {
                        %>
                        <tr>
                            <td></td>
                            <td>
                                <input type="submit" name="btnGuardar" value="Actualizar" onclick="form.action='ServPuesto?accion=actualizar&id=<%= p.getIdPuesto()%>';">
                                <input type="button" value="Cancelar" onclick="location.href='ServPuesto?accion=listar';" />
                            </td>
                        </tr>
                        <%
                        }
                    }
                    %>
                </tbody>
            </table>
        </form>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    </body>
</html>
