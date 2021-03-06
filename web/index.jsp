<%-- 
    Document   : index
    Created on : 11-oct-2020, 17:11:43
    Author     : Eduardo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LOGIN</title>
        <!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->
    </head>
    <body>
        <div class="limiter">
            <div class="container-login100">
                <div class="wrap-login100 p-t-50 p-b-90">
                    <form class="login100-form validate-form flex-sb flex-w" action="Validar" method="POST">
                        <span class="login100-form-title p-b-51">
                            Sistema - Ferreteria
                        </span>


                        <div class="wrap-input100 validate-input m-b-16" data-validate = "Ingrese el usuario">
                            <input class="input100" type="text" name="txtUsuario" placeholder="Usuario">
                            <span class="focus-input100"></span>
                        </div>


                        <div class="wrap-input100 validate-input m-b-16" data-validate = "Ingrese la contraseña">
                            <input class="input100" type="password" name="txtPass" placeholder="Contraseña">
                            <span class="focus-input100"></span>
                        </div>

                        <div class="container-login100-form-btn m-t-17">
                            <input type="submit" name="accion" value="Ingresar" class="login100-form-btn">
                        </div>
                    </form>
                </div>
            </div>
	</div>
        <!--FUENTE: https://colorlib.com/wp/template/login-form-v10/ -->
        <!-- EJEMPLO AGREGAR JASPER REPORTS-->
        <!-- https://www.youtube.com/watch?v=39ERiBV4wAs 
            las librerias en el video se pueden descargar de:
            http://plugins.netbeans.org/plugin/4425/ireport
        -->
        <!-- https://www.youtube.com/watch?v=AbawnPImW_g 
            los archivos jar se pueden descargar de:
            https://jar-download.com/artifacts/net.sf.jasperreports/jasperreports/6.3.0/source-code
        -->
<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>
        <style>
            .login100-form-btn {
                background-color: #42A5F5 !important;
            }
        </style>
    </body>
</html>
