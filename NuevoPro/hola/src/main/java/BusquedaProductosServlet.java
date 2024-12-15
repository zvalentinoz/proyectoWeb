import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import controller.CarritoBD;
import modelo.Productos;
import java.util.List;

public class BusquedaProductosServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener la descripción del parámetro de solicitud
        String descripcion = request.getParameter("descripcion");

        // Realizar la búsqueda de productos por descripción
        CarritoBD carritoBD = new CarritoBD();
        List<Productos> resultados = carritoBD.buscarProductosPorDescripcion(descripcion);

        // Establecer los resultados como un atributo de solicitud
        request.setAttribute("resultados", resultados);

        // Obtener el primer producto de la lista de resultados (suponiendo que solo buscamos por uno)
        Productos primerResultado = resultados.get(0);
        
        // Obtener productos sugeridos de la misma categoría que el primer resultado
        List<Productos> productosSugeridos = carritoBD.obtenerProductosPorCategoria(primerResultado.getIdCategoria());

        // Establecer los productos sugeridos como un atributo de solicitud
        request.setAttribute("productosSugeridos", productosSugeridos);

        // Redireccionar a la página de resultados de búsqueda
        RequestDispatcher dispatcher = request.getRequestDispatcher("resultados_busqueda.jsp");
        dispatcher.forward(request, response);
    }
    
    
}
