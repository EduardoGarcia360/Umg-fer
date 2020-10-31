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
<!DOCTYPE html>
<html>
    <label for="listar">Listado de Pedidos</label><br>
    <table id="tablaPedidos">
            <tr>
              <th>PEDIDO-NO.</th>
              <th>CLIENTE</th>
              <th>TOTAL</th>
              <th>ACCION</th>
            <%
                ArrayList<Producto> lista = (ArrayList<Producto>)request.getAttribute("listar");
                for (int i = 0; i<lista.size(); i++){
                    Producto prod = lista.get(i);
                    if (prod.getIdProducto() != 0) {
            %>
              <!-- LA ACCION DEBE DECIR "LISTAR"-->
              
            </tr>
            <input type="submit" name="btnListar" value="Listar" onclick="form.action='ServListado?accion=detalle';">
            <!-- EL BOTON DE ACCION DE ESTA TABLA: onclick="form.action='ServListado?accion=detalle';" -->
    </table>
            
            <input type="submit" name="btnPagar" value="PAGAR" onclick="form.action='ServListado?accion=pedido';">
</html>
   
