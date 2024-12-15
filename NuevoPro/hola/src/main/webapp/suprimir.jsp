<%@page session="true" %>
<%@page import="java.util.ArrayList" %>
<%@page import="modelo.carrito" %>
<%@page import="java.util.Iterator" %>

<%
    // Recuperar el c�digo del producto
    String IdPro = request.getParameter("id");
    
    // Recuperar o inicializar la lista de la sesi�n
    HttpSession MiSesion = request.getSession();
    ArrayList<carrito> Lista = (ArrayList<carrito>) MiSesion.getAttribute("cesto");
    
    // Verificar si la lista es nula antes de intentar acceder a su tama�o
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
        
        // Actualizar el carrito en la sesi�n
        MiSesion.setAttribute("cesto", Lista);
    } else {
        // Si la lista es nula, puede que haya un problema en la l�gica de tu aplicaci�n
        // Debes manejar este caso apropiadamente, por ejemplo, redireccionando a una p�gina de error.
        response.sendRedirect("error.jsp");
    }
    
    // Redireccionar a la p�gina del carrito
    response.sendRedirect("carrito.jsp?txtid=&txtcan=0");
%>
