<%@page session="true" %>
<%@page import="java.util.ArrayList" %>
<%@page import="modelo.carrito" %>
<%@page import="java.util.Iterator" %>

<%
    // Recuperar el código del producto
    String IdPro = request.getParameter("id");
    
    // Recuperar o inicializar la lista de la sesión
    HttpSession MiSesion = request.getSession();
    ArrayList<carrito> Lista = (ArrayList<carrito>) MiSesion.getAttribute("cesto");
    
    // Verificar si la lista es nula antes de intentar acceder a su tamaño
    if (Lista != null) {
        // Utilizar un iterador para eliminar el producto seleccionado
        Iterator<carrito> iterator = Lista.iterator();
        while (iterator.hasNext()) {
            carrito item = iterator.next();
            if (item.getIdProducto().equalsIgnoreCase(IdPro)) {
                iterator.remove();
                break; // Una vez eliminado el producto, salimos del bucle
            }
        }
        
        // Actualizar el carrito en la sesión
        MiSesion.setAttribute("cesto", Lista);
    } else {
        // Si la lista es nula, puede que haya un problema en la lógica de tu aplicación
        // Debes manejar este caso apropiadamente, por ejemplo, redireccionando a una página de error.
        response.sendRedirect("error.jsp");
    }
    
    // Redireccionar a la página del carrito
    response.sendRedirect("carrito.jsp?txtid=&txtcan=0");
%>
