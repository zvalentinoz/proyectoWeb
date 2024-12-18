<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="modelo.Productos" %>
<%@ page import="modelo.Categorias" %>
<%@ page import="controller.CarritoBD" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%@ include file="menu.jsp" %> <!-- Incluye el archivo JSP del menú -->

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Carrito de Compras</title>
    <!-- Agrega la referencia a Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
        .card {
            width: 15rem; /* Reducir el tamaño de las tarjetas */
            margin-bottom: 20px; /* Espacio entre tarjetas */
        }
        .card-container {
            margin-right: -10px; /* Margen derecho negativo para compensar */
            margin-left: -10px; /* Margen izquierdo negativo para compensar */
        }
        .magnify {
            position: relative;
            display: inline-block;
            overflow: hidden;
        }
        .magnify img {
            display: block;
            width: 100%;
            height: auto;
            transition: transform 0.5s;
        }
        .magnify:hover img {
            transform: scale(1.5);
        }
        .lupa-icon {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: white;
            font-size: 24px;
            opacity: 0;
            transition: opacity 0.5s;
        }
        .magnify:hover .lupa-icon {
            opacity: 1;
        }
    </style>
</head>
<body>

<%
    String idCat = request.getParameter("id");
    CarritoBD carritoBD = new CarritoBD();
    List<Productos> listaProductos = new ArrayList<>();
    Categorias categoria = carritoBD.obtenerCategoria(idCat);
     
    if (categoria != null) {
        listaProductos = carritoBD.ListarProductos(idCat);
%>  

<h1 style="background-color: #fcc2bc;" class="text-center"><%= categoria.getDescripcion() %></h1 >
<div class="row justify-content-center card-container" style="background-color: #fcc2bc;">
<%
    for(Productos producto : listaProductos) {
%>
        <div class="col-md-4">
            <div class="card mx-auto">
                <div class="magnify">
                    <img src="img1/<%= producto.getImagen() %>" class="card-img-top" alt="<%= producto.getDescripcion() %>">
                    <div class="lupa-icon"></div>
                </div>
                <div class="card-body">
                    <h5 class="card-title text-center">Precio: $<%= producto.getPrecioUnidad() %></h5>
                    <p class="card-text text-center"><%= producto.getDescripcion() %></p>
                    <a href="verdetalle.jsp?id=<%= producto.getIdProducto() %>" class="btn btn-primary d-block mx-auto">Ver Detalle</a>
                </div>
            </div>
        </div>
<%
    }

%>
</div>

<a href="principal.jsp" class="btn btn-secondary d-block mx-auto mt-3">Regresar a la Página Principal</a>

<%
    } else {
        // Manejar el caso en el que no se encuentre la categoría
        out.println("No se encontró la categoría con ID: " + idCat);
    }
%>

</body>
</html>
