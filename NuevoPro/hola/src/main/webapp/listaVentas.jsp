s<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Ventas" %>
<%@ page import="modelo.DetalleVenta" %>
<%@ page import="controller.CarritoBD" %>

<%
    CarritoBD carritoBD = new CarritoBD();
    List<Ventas> ventas = carritoBD.listarVentas();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Lista de Ventas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body style="background-color: gray">
    <div class="container mt-5">
        <h1>Lista de Ventas</h1>
        <table class="table">
            <thead>
                <tr>
                    <th>ID Venta</th>
                    <th>ID Cliente</th>
                    <th>Fecha de Venta</th>
                    <th>Monto Total</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <% for (Ventas venta : ventas) { %>
                    <tr>
                        <td><%= venta.getIdVenta() %></td>
                        <td><%= venta.getIdCliente() %></td>
                        <td><%= venta.getFechaVenta() %></td>
                        <td><%= venta.getMontoTotal() %></td>
                        <td><%= venta.getEstado() %></td>
                        <td>
                            <form action="listaDetalle.jsp" method="post">
                                <input type="hidden" name="idVenta" value="<%= venta.getIdVenta() %>">
                                <button type="submit" class="btn btn-primary">Ver Detalles</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>

