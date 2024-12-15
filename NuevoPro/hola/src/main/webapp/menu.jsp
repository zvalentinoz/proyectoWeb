<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="modelo.Categorias" %>
<%@ page import="controller.CarritoBD" %>




<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #FFFFFF;">
    <div class="container-fluid">
        <!-- Logo de la barra de navegación -->
        <a class="navbar-brand" href="#">
            <img src="img/shop.png" alt="Logo de la panadería" width="200" height="110">
        </a>

        <!-- Contenedor del menú de navegación -->
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <!-- Barra de navegación -->
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <!-- Opción de Categorías -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        CATEGORIAS
                    </a>
                    
                </li>
                <!-- Otras opciones del menú -->
                <li class="nav-item">
                    <a class="nav-link" href="#">PROMOCIONES</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">TIENDAS</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">CONTACTOS</a>
                </li>
            </ul>

         <!-- Barra de búsqueda -->
<form action="BusquedaProductosServlet" method="GET" class="d-flex">
    <input class="form-control me-2" type="search" placeholder="Buscar productos..." aria-label="Search" name="descripcion">
    <button class="btn btn-outline-light" type="submit">Buscar</button>
</form>
         

            <!-- Icono de carrito -->
            <div>
                <a href="#" class="nav-link">
                    <i class="bi bi-cart"></i>
                    <span class="badge bg-primary"><%= session.getAttribute("numarticulos") %></span>
                </a>
                <span class="navbar-text" style="font-size: 18px;">
                    TOTAL: $<%= session.getAttribute("total") %>
                </span>
            </div>
        </div>
    </div>
</nav>
