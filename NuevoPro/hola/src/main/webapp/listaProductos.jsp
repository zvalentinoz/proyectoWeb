<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Productos" %>
<%@ page import="controller.CarritoBD" %>

<%
    CarritoBD carritoBD = new CarritoBD();
    List<Productos> productos = carritoBD.listarProductos();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    
    <title>Lista de Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body style="background-color: gray">
    <div class="container mt-5">
        <h1>Lista de Productos</h1>
        <table class="table">
            <thead>
                <tr>
                    <th>ID Producto</th>
                    <th>ID Categoría</th>
                    <th>Descripción</th>
                    <th>Precio Unidad</th>
                    <th>Stock</th>
                    <th>Imagen</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <% for (Productos producto : productos) { %>
                    <tr>
                        <td><%= producto.getIdProducto() %></td>
                        <td><%= producto.getIdCategoria() %></td>
                        <td><%= producto.getDescripcion() %></td>
                        <td><%= producto.getPrecioUnidad() %></td>
                        <td><%= producto.getStock() %></td>
                        <td><%= producto.getImagen() %></td>
                        <td><%= producto.getEstado() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
