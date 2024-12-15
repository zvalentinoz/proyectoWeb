<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Productos" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Resultados de búsqueda</title>
    <!-- Agrega la referencia a Bootstrap -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Estilo personalizado para la lupa */
        .lupa {
            font-size: 24px;
        }
        /* Estilo para la separación entre las cards de productos sugeridos */
        .mb-4-s {
            margin-bottom: 1.5rem !important;
        }
        /* Estilo para la lupa */
        .magnify {
            position: relative;
            width: 100%;
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
    <%@ include file="menu.jsp" %> <!-- Aquí se incluye el archivo JSP del menú -->
    <div class="container">
        <h1 class="mt-5">Resultados de búsqueda</h1>

        <%-- Mostrar los productos encontrados --%>
        <div class="row justify-content-center">
            <% List<Productos> resultados = (List<Productos>) request.getAttribute("resultados"); %>
            <% for (Productos producto : resultados) { %>
                <div class="card m-3" style="width: 18rem;">
                    <div class="magnify">
                        <img src="img/<%= producto.getImagen() %>" class="card-img-top" alt="<%= producto.getDescripcion() %>">
                        <div class="lupa-icon">🔍</div>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title"><%= producto.getDescripcion() %></h5>
                        <p class="card-text">Precio: <%= producto.getPrecioUnidad() %></p>
                        <a href="#" class="btn btn-primary">Comprar</a>
                    </div>
                </div>
            <% } %>
        </div>

        <%-- Mostrar productos sugeridos --%>
        <h2 class="mt-5">Productos sugeridos:</h2>
        <div class="row">
            <% List<Productos> productosSugeridos = (List<Productos>) request.getAttribute("productosSugeridos"); %>
            <% for (Productos sugerido : productosSugeridos) { %>
                <div class="col-md-4 mb-4 mb-4-s">
                    <div class="card">
                        <img src="img/<%= sugerido.getImagen() %>" class="card-img-top" alt="<%= sugerido.getDescripcion() %>">
                        <div class="card-body">
                            <h5 class="card-title"><%= sugerido.getDescripcion() %></h5>
                            <p class="card-text">Precio: <%= sugerido.getPrecioUnidad() %></p>
                            <a href="#" class="btn btn-primary">Ver Detalle</a>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>

    <!-- Agrega la referencia a Bootstrap JavaScript -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
