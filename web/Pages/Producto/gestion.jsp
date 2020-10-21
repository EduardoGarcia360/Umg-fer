<%-- 
    Document   : gestion
    Created on : 20/10/2020, 10:06:46 PM
    Author     : juanc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Clases.Producto"%>
<%@page import="Utils.Conexion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion - Producto</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    </head>
    <body>
        <h1>Gestion de Productos</h1>
        <form method="POST">
            <table border="1" class="table table-striped table-bordered">
                <tbody>
                    <%
                    ArrayList<Producto> lista = (ArrayList<Producto>)request.getAttribute("gestion");
                    for (int i = 0; i<lista.size(); i++){
                        Producto pro = lista.get(i);
                        %>
                        <tr>
                            <td>CODIGO DE PRODUCTO</td>
                            <td>
                                <input type="text" name="txtCodigo" value="<%= pro.getCodProducto()%>">
                            </td>
                        </tr>
                        <tr>
                            <td>MARCA</td>
                            <td>
                                <input type="text" name="txtMarca" value="<%= pro.getIdMarca()%>">
                            </td>
                        </tr>
                        <tr>
                            <td>CATEGORIA</td>
                            <td>
                                <input type="text" name="txtCategoria" value="<%= pro.getIdCategoria()%>">
                            </td>
                        </tr>
                        <tr>
                            <td>NOMBRE</td>
                            <td>
                                <input type="text" name="txtNombre" value="<%= pro.getNombre()%>">
                            </td>
                        </tr>
                        <tr>
                            <td>PRECIO</td>
                            <td>
                                <input type="text" name="txtPrecio" value="<%= pro.getPrecio()%>">
                            </td>
                        </tr>
                        <tr>
                            <td>EXISTENCIA</td>
                            <td>
                                <input type="text" name="txtExistencia" value="<%= pro.getExistencia()%>">
                            </td>
                        </tr>
                        <tr>
                            <td>SERIE_FACTURA</td>
                            <td>
                                <input type="text" name="txtSerie_fac" value="<%= pro.getSerie_factura()%>">
                            </td>
                        </tr>
                        <tr>
                            <td>NUMERO_FACTURA</td>
                            <td>
                                <input type="text" name="txtNumero_fac" value="<%= pro.getNumero_factura()%>">
                            </td>
                        </tr>
                        <tr>
                            <td>MARCA</td>
                            <td>
                                <select name="selectMarca">
                                    <%
                                        try{
                                            Connection cnx = Conexion.getConexion();
                                            PreparedStatement sta = cnx.prepareStatement("{call SPR_SEL_COMBO_MARCA}");
                                            ResultSet rs = sta.executeQuery();
                                            while (rs.next()) {
                                                int idMarca = rs.getInt(1);
                                                String marca = rs.getString(2);
                                                if (idMarca == pro.getIdProducto()) {
                                    %>
                                                <option value="<%= idMarca%>" selected>
                                                    <%= marca%>
                                                </option>
                                    <%
                                                } else {
                                    %>
                                                <option value="<%= idMarca%>">
                                                    <%= marca%>
                                                </option>
                                    <%
                                                }
                                            }
                                        } catch (Exception e) {
                                            out.print(e.getMessage());
                                        }
                                    %>
                                </select>
                            </td>
                        </tr>
                        <% 
                            if (pro.getIdProducto() == 0) {
                        %>
                        <tr>
                            <td></td>
                            <td>
                                <input type="submit" name="btnGuardar" value="Guardar" onclick="form.action='ServProducto?accion=insertar';">
                                <input type="button" value="Cancelar" onclick="location.href='ServProducto?accion=listar';" />
                            </td>
                        </tr>
                        <%
                            } else {
                        %>
                        <tr>
                            <td></td>
                            <td>
                                <input type="submit" name="btnGuardar" value="Actualizar" onclick="form.action='ServProducto?accion=actualizar&id=<%= pro.getIdProducto()%>';">
                                <input type="button" value="Cancelar" onclick="location.href='ServProducto?accion=listar';" />
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

