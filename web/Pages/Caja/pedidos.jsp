<%-- 
    Document   : Pedidos
    Created on : 29/10/2020, 02:20:58 AM
    Author     : juanc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <label for="pagar">Listado de Pedidos</label><br>      
    <table id="tablaProductos">
            <tr>
              <th>PEDIDO NO.</th>
              <th>CLIENTE</th>
              <th>TOTAL</th>
              <th>ACCION</th>
            </tr>
    </table>
     <form method="POST">
            <input type="submit" name="btnPedido" value="Agregar Pedido" onclick="form.action='ServDetalle?accion=pedido';">
        </form>
</html>
   
