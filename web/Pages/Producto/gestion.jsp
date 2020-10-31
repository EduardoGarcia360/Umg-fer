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
        <% 
            //cuando no hay sesion iniciada retorna al login
            String codEmp = (String)session.getAttribute("codEmp");
            if(codEmp == null){
                response.sendRedirect("index.jsp");
                return;
            }
        %>
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
                                                if (idMarca == pro.getIdMarca()) {
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
                        <tr>
                            <td>CATEGORIA</td>
                             <td>
                                <select name="selectCategoria">
                                    <%
                                        try{
                                            Connection cnx = Conexion.getConexion();
                                            PreparedStatement sta = cnx.prepareStatement("{call SPR_SEL_COMBO_CATEGORIA}");
                                            ResultSet rs = sta.executeQuery();
                                            while (rs.next()) {
                                                int idCat = rs.getInt(1);
                                                String cat = rs.getString(2);
                                                if (idCat == pro.getIdCategoria()) {
                                    %>
                                                <option value="<%= idCat%>" selected>
                                                    <%= cat%>
                                                </option>
                                    <%
                                                } else {
                                    %>
                                                <option value="<%= idCat%>">
                                                    <%= cat%>
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
                        <tr>
                            <td>PROVEEDOR</td>
                            <td>
                                <select name="selectProveedor">
                                    <%
                                        try{
                                            Connection cnx = Conexion.getConexion();
                                            PreparedStatement sta = cnx.prepareStatement("{call SPR_SEL_COMBO_PROVEEDOR}");
                                            ResultSet rs = sta.executeQuery();
                                            while (rs.next()) {
                                                int idProv = rs.getInt(1);
                                                String prov = rs.getString(2);
                                                if (idProv == pro.getIdProveedor()) {
                                    %>
                                                <option value="<%= idProv%>" selected>
                                                    <%= prov%>
                                                </option>
                                    <%
                                                } else {
                                    %>
                                                <option value="<%= idProv%>">
                                                    <%= prov%>
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
                        <tr>
                            <td>CODIGO DE PRODUCTO</td>
                            <td>
                                <input type="text" name="txtCodProducto" value="<%= pro.getCodProducto()%>" required>
                            </td>
                        </tr>
                        <tr>
                            <td>NOMBRE</td>
                            <td>
                                <input type="text" name="txtNombre" value="<%= pro.getNombre()%>" required>
                            </td>
                            </td>
                        </tr>
                        <tr>
                            <td>PRECIO</td>
                            <td>
                                <input type="number" name="txtPrecio" step="0.01" value="<%= pro.getPrecio()%>" required>
                            </td>
                            </td>
                        </tr>
                        <tr>
                            <td>EXISTENCIA</td>
                            <td>
                                <input type="number" name="txtExistencia" value="<%= pro.getExistencia()%>" required>
                            </td>
                            </td>
                        </tr>
                        <tr>
                            <td>ORDEN DE COMPRA</td>
                            <td>
                                <input type="text" name="txtOrden_Compra" value="<%= pro.getOrden_compra()%>" required>
                            </td>
                            </td>
                        </tr>
                        <tr>
                            <td>SERIE_FACTURA</td>
                            <td>
                                <input type="text" name="txtSerie_fac" value="<%= pro.getSerie_factura()%>" required>
                            </td>
                            </td>
                        </tr>
                        <tr>
                            <td>NUMERO_FACTURA</td>
                            <td>
                                <input type="text" name="txtNumero_fac" value="<%= pro.getNumero_factura()%>" required>
                            </td>
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

