<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="modelo.DetalleVenta" %>
<%@ page import="controller.CarritoBD" %>
<%@ page import="modelo.Ventas" %>
<%@ page import="modelo.Productos" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Consulta de Venta</title>
</head>
<body style="background-color: gray">
    <h2>Consulta de Venta</h2>
    
    <form action="" method="post">
        <label for="venta">Selecciona la venta:</label>
        <select name="venta" id="venta">
            <% 
            // Obtener la lista de ventas desde la base de datos
            CarritoBD carritoBD = new CarritoBD();
            List<Ventas> ventas = carritoBD.listarVentas();
            for (Ventas venta : ventas) {
            %>
            <option value="<%= venta.getIdVenta() %>"><%= venta.getIdVenta() %></option>
            <% } %>
        </select>
        <button type="submit">Consultar Detalles</button>
    </form>

    <% 
    // Procesar la solicitud cuando se envíe el formulario
    if (request.getMethod().equals("POST")) {
        // Obtener el ID de la venta seleccionada
        String idVenta = request.getParameter("venta");
        
        // Consultar los detalles de la venta seleccionada en la base de datos
        List<DetalleVenta> detallesVenta = carritoBD.listarDetalleVenta(idVenta);
        
        // Mostrar los detalles de la venta en una tabla
        if (!detallesVenta.isEmpty()) {
    %>
    <h3>Detalles de la venta <%= idVenta %></h3>
    <table border="1">
        <thead>
            <tr>
                <th>Producto</th>
                <th>Cantidad</th>
                <th>Precio Unitario</th>
                <th>Total</th>
            </tr>
        </thead>
        <tbody>
           <% 
double totalVenta = 0;
for (DetalleVenta detalle : detallesVenta) {
    Productos producto = carritoBD.obtenerProducto(detalle.getIdProducto());
    double totalProducto = detalle.getCantidad() * detalle.getPrecioUnidad();
    totalVenta += totalProducto;
%>
            <tr>
                <td><%= producto.getDescripcion() %></td>
                <td><%= detalle.getCantidad() %></td>
                <td>$<%= detalle.getPrecioUnidad() %></td>
                <td>$<%= totalProducto %></td>
            </tr>
            <% } %>
        </tbody>
        <tfoot>
            <tr>
                <th colspan="3">Total Venta:</th>
                <td>$<%= totalVenta %></td>
            </tr>
        </tfoot>
    </table>
    <% } else { %>
    <p>No se encontraron detalles para la venta seleccionada.</p>
    <% } } %>

</body>
</html>
