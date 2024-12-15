<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<%@ page import="modelo.Productos" %>
<%@ page import="controller.CarritoBD" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Carrito de Compras</title>
    <!-- Agrega la referencia a Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa; /* Color de fondo */
            padding-top: 50px; /* Espacio superior */
        }
        .container {
            background-color: #ffffff; /* Color de fondo del contenedor */
            border-radius: 10px; /* Borde redondeado */
            padding: 20px; /* Espaciado interior */
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1); /* Sombra suave */
        }
        h1 {
            text-align: center; /* Centrar el título */
            margin-bottom: 30px; /* Espacio inferior */
        }
        form {
            max-width: 500px; /* Ancho máximo del formulario */
            margin: 0 auto; /* Centrar el formulario */
        }
        img {
            max-width: 100%; /* Ancho máximo de la imagen */
            height: auto; /* Altura automática para mantener la proporción */
            border-radius: 5px; /* Borde redondeado */
            margin-top: 10px; /* Espacio superior */
            box-shadow: 0px 0px 5px 0px rgba(0,0,0,0.2); /* Sombra suave */
            transition: transform 0.3s; /* Transición del efecto lupa */
        }
        img:hover {
            transform: scale(1.1); /* Escala aumentada al pasar el cursor sobre la imagen */
        }
        input[type="submit"] {
            width: 100%; /* Ancho completo del botón */
            margin-top: 20px; /* Espacio superior */
        }
        a {
            display: block; /* Convertir el enlace en un bloque */
            text-align: center; /* Centrar el texto */
            margin-top: 20px; /* Espacio superior */
            color: #007bff; /* Color del enlace */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Carrito de Compras</h1>
        <%
            String IdPro = request.getParameter("id");
            CarritoBD ObjBD = new CarritoBD();
            Productos ObjP = new Productos();
            ObjP = ObjBD.InfoProducto(IdPro);
        %>    
        <form action="carrito.jsp">
            <div class="mb-3">
                <label for="txtid" class="form-label">ID Producto</label>
                <input id="txtid" name="txtid" class="form-control" value="<%=ObjP.getIdProducto()%>" readonly />
            </div>
            <div class="mb-3">
                <label class="form-label">Descripción</label>
                <p class="form-control-static"><%=ObjP.getDescripcion()%></p>
            </div>
            <div class="mb-3">
                <label class="form-label">Precio</label>
                <p class="form-control-static">$<%=ObjP.getPrecioUnidad()%></p>
            </div>
            <div class="mb-3">
                <label class="form-label">Stock</label>
                <p class="form-control-static"><%=ObjP.getStock()%></p>
            </div>
            <div class="mb-3">
                <label class="form-label">Imagen</label>
                <img src="img/<%=ObjP.getImagen()%>" alt="<%=ObjP.getDescripcion()%>" class="img-fluid">
            </div>
            <div class="mb-3">
                <label for="txtcan" class="form-label">Cantidad</label>
                <input id="txtcan" name="txtcan" type="number" class="form-control" />
            </div>
            <input type="submit" class="btn btn-primary" value="Añadir al Carrito" />
        </form>
        <a href="javascript:history.back()">Seleccionar Otro Producto</a>
    </div>
</body>
</html>

