<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="modelo.Categorias" %>
<%@ page import="controller.CarritoBD" %>




<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #fcc2bc;">
    <div class="container-fluid" >
        <!-- Logo de la barra de navegaci�n -->
        <a class="navbar-brand" href="#" style="background-color: #ffa59c; border: 20">
            <img src="img1/logo.png" alt="Logo de la panader�a" width="180" height="110" style="background-color: #ffa59c; border: 20">
        </a>

        <!-- Contenedor del men� de navegaci�n -->
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <!-- Barra de navegaci�n -->
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <!-- Opci�n de Categor�as -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        CATEGORIAS
                    </a>
                    
                </li>
                <!-- Otras opciones del men� -->
              
                <li class="nav-item">
                    <a class="nav-link" href="#">TIENDAS</a>
                </li>

            </ul>

         <!-- Barra de b�squeda -->
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
              
            </div>
        </div>
    </div>
</nav>
