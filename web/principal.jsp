<%-- 
    Document   : principal
    Created on : 25-oct-2020, 16:38:36
    Author     : Eduardo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Clases.Empleado"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Principal</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <style>
            .margen-der {
                margin-right: 10px;
            }
        </style>
    </head>
    <body>
        <% 
            String nombre = (String)session.getAttribute("nombre");
        %>
        <nav class="navbar navbar-expand-lg navbar-light bg-info">
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
              <ul class="navbar-nav">
                <li class="nav-item active margen-der">
                  <a class="btn btn-outline-light" href="ServEmpleado?accion=listar">Empleados</a>
                </li>
                <li class="nav-item active margen-der">
                  <a class="btn btn-outline-light" href="ServProducto?accion=listar">Productos</a>
                </li>
                <li class="nav-item active margen-der">
                    <a class="btn btn-outline-light" href="ServVenta?accion=nuevo" target="myFrame">Venta</a>
                </li>
                <li class="nav-item active dropdown margen-der">
                  <a class="btn btn-outline-light dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Catalogos
                  </a>
                  <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                    <a class="dropdown-item" href="ServCategoria?accion=listar">Categoría</a>
                    <a class="dropdown-item" href="ServFormaPago?accion=listar">Forma de Pago</a>
                    <a class="dropdown-item" href="ServMarca?accion=listar">Marca</a>
                    <a class="dropdown-item" href="ServProveedor?accion=listar">Proveedor</a>
                    <a class="dropdown-item" href="ServPuesto?accion=listar">Puesto</a>
                  </div>
                </li>
              </ul>
            </div>
            <div class="btn-group dropleft">
                <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <%= nombre%>
                </button>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                  <a class="dropdown-item" href="#">Action</a>
                  <a class="dropdown-item" href="#">Another action</a>
                  <a class="dropdown-item" href="#">Something else here</a>
                  <div class="dropdown-divider"></div>
                  <form action="Validar" method="POST" style="display:block; text-align: center;">
                      <input type="submit" name="accion" value="Salir" class="btn btn-primary">
                  </form>
                </div>
            </div>
        </nav>
        <div class="m-4" style="height: 1000px;">
            <iframe name="myFrame" style="height: 100%; width: 100%; border: none;"></iframe>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    </body>
</html>
