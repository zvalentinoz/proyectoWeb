<%@page import="java.awt.geom.Path2D"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<%@ page import="modelo.Categorias" %>
<%@ page import="modelo.Productos" %>
<%@ page import="controller.CarritoBD" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    CarritoBD carritoBD = new CarritoBD();
    List<Categorias> Lista = new ArrayList<>(); // Definir la lista aquí
    try {
        Lista = carritoBD.ListarCategorias();
    } catch (Exception e) {
        // Manejar el error adecuadamente
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>

    <meta charset="ISO-8859-1">
    <title>Carrito de Compras</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    
</head>
<body>
    <%@ include file="menu.jsp" %> <!-- Aquí se incluye el archivo JSP del menú -->
    
    
    
<div style="border: 1px solid #ced4da; border-radius: 5px; overflow: hidden; max-width: 1550px; margin: 0 auto;">
  <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img src="img/productos-carrusel1.jpg" class="d-block w-100" style="height: 530px;" alt="...">
      </div>
      <div class="carousel-item">
        <img src="img/producto-carrusel2.jpg" class="d-block w-100" style="height: 530px;" alt="...">
      </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Next</span>
    </button>
  </div>
</div>
<br>
<br>

<!-- Encabezado -->
<h2>Ofertas del día</h2>

<% 
for(Categorias c : Lista){
    String imagen = "<img src=img/" + c.getImagen() + " width=150 height=150";
    String enlace = "verproductos.jsp?id=" + c.getIdCategoria();
%>

<!-- Sección de la categoría y carrusel de productos -->
<section class="mb-4">
    <div class="row">
        <!-- Columna para la categoría -->
        <div class="col-md-6 mb-4">
            <div class="card" style="width: 15rem; position: relative;">
                <!-- Enlace sobre la imagen -->
                <a href="<%= enlace %>">
                    <img src="img/<%= c.getImagen() %>" class="card-img-top" alt="">
                </a>
                <div class="card-body">
                    <!-- Contenido de la tarjeta -->
                    <!-- Puedes agregar contenido adicional si es necesario -->
                </div>
            </div>
        </div>
       <!-- Columna para el carrusel de productos -->
<div class="col-md-6 mb-4">
    <div id="carouselProductos<%= c.getIdCategoria() %>" class="carousel slide">
        <div class="carousel-inner">
            <% 
            List<Productos> productos = carritoBD.ListarProductos(c.getIdCategoria());
            int count = 0;
            for(Productos producto : productos){
            %>
            <!-- Agrupar cada 3 productos en un div "carousel-item" para mostrar horizontalmente -->
            <% if (count % 2 == 0) { %>
                <div class="carousel-item <%= count == 0 ? "active" : "" %>">
                    <div class="d-flex justify-content-around">
            <% } %>
                        <!-- Tarjeta de producto -->
                        <div class="card" style="width: 19rem;">
                            <img src="img/<%= producto.getImagen() %>" class="card-img-top" alt="...">
                            <div class="card-body">
                                <h5 class="card-title"><%= producto.getDescripcion() %></h5>
                                <p class="card-text">Precio: <%= producto.getPrecioUnidad() %></p>
                                <!-- Puedes agregar más información del producto aquí si lo deseas -->
                            </div>
                        </div>
            <% count++;
               if (count % 2 == 0 || count == productos.size()) { %>
                    </div>
                </div>
            <% } %>
            <% } %>
        </div>
        
        <!-- Botones de navegación del carrusel -->
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselProductos<%= c.getIdCategoria() %>" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselProductos<%= c.getIdCategoria() %>" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</div>
       
</section>
<% } %>



<script>
$(document).ready(function(){
    // Paused carousel on load
    $('.carousel').carousel('pause');

    // Pause carousel on slide change
    $('.carousel').on('slide.bs.carousel', function () {
        $('.carousel').carousel('pause');
    });
});
</script>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    
</body>
<%@ include file="Footer.jsp" %> <!-- Aquí se incluye el archivo JSP del footer -->
</html>
