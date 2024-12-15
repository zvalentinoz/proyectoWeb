<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Clientes" %>
<%@ page import="controller.CarritoBD" %>

<%
    CarritoBD carritoBD = new CarritoBD();
    List<Clientes> clientes = carritoBD.listarClientes();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Lista de Clientes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body style="background-color: gray"> 
    <div class="container mt-5" >
        <h1>Lista de Clientes</h1>
        <table class="table">
            <thead>
            
                <tr>
                    <th>ID</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>Dirección</th>
                    <th>Fecha de Nacimiento</th>
                    <th>Correo</th>
                    <th>Tipo</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <% for (Clientes cliente : clientes) { %>
                    <tr>
                        <td><%= cliente.getIdCliente() %></td>
                        <td><%= cliente.getNombres() %></td>
                        <td><%= cliente.getApellidos() %></td>
                        <td><%= cliente.getDireccion() %></td>
                        <td><%= cliente.getFechaNacimiento() %></td>
                        <td><%= cliente.getCorreo() %></td>
                        <td><%= cliente.getTipo() %></td>
                        <td><%= cliente.getEstado() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
