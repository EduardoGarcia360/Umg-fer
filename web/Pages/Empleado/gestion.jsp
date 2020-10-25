<%-- 
    Document   : gestion
    Created on : 15-oct-2020, 12:45:21
    Author     : Eduardo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Clases.Empleado"%>
<%@page import="Utils.Conexion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion - Empleado</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    </head>
    <body>
        <h1>Gestion de Empleado</h1>
        <form method="POST">
            <table border="1" class="table table-striped table-bordered">
                <tbody>
                    <%
                    ArrayList<Empleado> lista = (ArrayList<Empleado>)request.getAttribute("gestion");
                    for (int i = 0; i<lista.size(); i++){
                        Empleado emp = lista.get(i);
                        %>
                        <tr>
                            <td>CODIGO DE TRABAJADOR</td>
                            <td>
                                <input type="text" name="txtCodigo" value="<%= emp.getCodTrab()%>" required>
                            </td>
                        </tr>
                        <tr>
                            <td>USUARIO</td>
                            <td>
                                <input type="text" name="txtUsuario" value="<%= emp.getUsuario()%>" required>
                            </td>
                        </tr>
                        <tr>
                            <td>CONTRASEÑA</td>
                            <td>
                                <input id="pass1" type="password" name="txtPass" value="<%= emp.getPass()%>" required>
                                <input type="checkbox" onclick="verPass()">Ver contraseña
                            </td>
                        </tr>
                        <tr>
                            <td>NOMBRE</td>
                            <td>
                                <input type="text" name="txtNombre" value="<%= emp.getNombre()%>" required>
                            </td>
                        </tr>
                        <tr>
                            <td>APELLIDO</td>
                            <td>
                                <input type="text" name="txtApellido" value="<%= emp.getApellido()%>" required>
                            </td>
                        </tr>
                        <tr>
                            <td>FECHA DE NACIMIENTO</td>
                            <td>
                                <input type="date" name="txtFechanac" value="<%= emp.getFechaNacimiento()%>">
                            </td>
                        </tr>
                        <tr>
                            <td>DIRECCION</td>
                            <td>
                                <input type="text" name="txtDire" value="<%= emp.getDireccion()%>">
                            </td>
                        </tr>
                        <tr>
                            <td>TELEFONO</td>
                            <td>
                                <input type="text" name="txtTelefono" value="<%= emp.getTelefono()%>">
                            </td>
                        </tr>
                        <tr>
                            <td>D.P.I.</td>
                            <td>
                                <input type="text" name="txtDpi" value="<%= emp.getDpi()%>" required>
                            </td>
                        </tr>
                        <tr>
                            <td>CORREO ELECTRONICO</td>
                            <td>
                                <input type="text" name="txtCorreo" value="<%= emp.getCorreoElectronico()%>">
                            </td>
                        </tr>
                        <tr>
                            <td>PUESTO</td>
                            <td>
                                <select name="selectPuesto">
                                    <%
                                        try{
                                            Connection cnx = Conexion.getConexion();
                                            PreparedStatement sta = cnx.prepareStatement("{call SPR_SEL_COMBO_PUESTO}");
                                            ResultSet rs = sta.executeQuery();
                                            while (rs.next()) {
                                                int idPuesto = rs.getInt(1);
                                                String puesto = rs.getString(2);
                                                if (idPuesto == emp.getIdPuesto()) {
                                    %>
                                                <option value="<%= idPuesto%>" selected>
                                                    <%= puesto%>
                                                </option>
                                    <%
                                                } else {
                                    %>
                                                <option value="<%= idPuesto%>">
                                                    <%= puesto%>
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
                            if (emp.getIdEmpleado() == 0) {
                        %>
                        <tr>
                            <td></td>
                            <td>
                                <input type="submit" name="btnGuardar" value="Guardar" onclick="form.action='ServEmpleado?accion=insertar';">
                                <input type="button" value="Cancelar" onclick="location.href='ServEmpleado?accion=listar';" />
                            </td>
                        </tr>
                        <%
                            } else {
                        %>
                        <tr>
                            <td></td>
                            <td>
                                <input type="submit" name="btnGuardar" value="Actualizar" onclick="form.action='ServEmpleado?accion=actualizar&id=<%= emp.getIdEmpleado()%>';">
                                <input type="button" value="Cancelar" onclick="location.href='ServEmpleado?accion=listar';" />
                            </td>
                        </tr>
                        <%
                        }
                    }
                    %>
                </tbody>
            </table>
        </form>
        <script>
            function verPass() {
              var x = document.getElementById("pass1");
              if (x.type === "password") {
                x.type = "text";
              } else {
                x.type = "password";
              }
            }
        </script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    </body>
</html>
