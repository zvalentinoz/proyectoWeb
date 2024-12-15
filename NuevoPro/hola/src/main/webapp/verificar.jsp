<%@page session="true" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.DateFormat" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="modelo.*"%>
<%@page import="controller.*"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
<%
	CarritoBD ObjBD = new CarritoBD();	
	Clientes ObjC = new Clientes();
	String cadenaFecha = "";
	ArrayList<carrito> Lista = null;
	HttpSession MiSesion = null;
	try{
		
	    // Recuperar valores del formulario
	    String IdCliente = request.getParameter("txtid");
	    String Password = request.getParameter("txtpass");
	    if(!ObjBD.VerificaUsuario(IdCliente, Password)){
	        out.print("=== ERROR EN USUARIO O CONTRASEÑA ===");
	        out.print("<<br><a href=pagar.jsp>Identificarse otra vez</a>");
	    }else{
	    	// Recuperar informacion de cliente		    
		    ObjC = ObjBD.InfoCliente(IdCliente);
		 	// Recuperar la informacion del cesto
		    MiSesion = request.getSession();
		    Lista = new ArrayList<carrito>();
		    Lista = (ArrayList<carrito>)MiSesion.getAttribute("cesto");
		 	// Recuperando la fecha actual del sistema
		    Date fechaActual = new Date();
		    SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
		    cadenaFecha = formato.format(fechaActual);
		    // Guardar en la sesion actual los datos del cliente
		    MiSesion.setAttribute("IdCliente", IdCliente);
		    MiSesion.setAttribute("Fecha", cadenaFecha);
	    }	    	    	    
	}catch(Exception ex){
		out.print("ERROR :" + ex.getMessage());	
	}
%>
<center>
    <table class="table">
        <tr>
            <td colspan="6">DATOS DEL CLIENTE:<%=ObjC.getIdCliente()%>
                <br/>FECHA ACTUAL:<%=cadenaFecha%>
                <br/><h1><%=ObjC.getApellidos()%>,<%=ObjC.getNombres()%></h1>
            </td>
        </tr>
        <tr>
            <th>Item</th>
            <th>IdProducto</th>
            <th>Descripcion</th>
            <th>Cantidad</th>
            <th>PrecioUnidad</th>
            <th>SubTotal</th>
        </tr>
        <%  double Total = 0;
            for(int i = 0; i < Lista.size(); i++){ 
                Productos ObjP = new Productos();
                ObjP = ObjBD.InfoProducto(Lista.get(i).getIdProducto());
                int Cantidad = Lista.get(i).getCantidad();
                double Precio = ObjP.getPrecioUnidad();
                double SubTotal = Cantidad * Precio;
                Total += SubTotal;
        %>
            <tr>
                <td><%=(i+1)%></td>
                <td><%=ObjP.getIdProducto()%></td>
                <td><%=ObjP.getDescripcion()%></td>
                <td><%=Cantidad%></td>
                <td><%=Precio%></td>
                <td><%=SubTotal%></td>
            </tr>    
        <% } %>
        <tr>
            <td colspan="4">TOTAL A PAGAR</td>
            <td><%=Total%></td>
        </tr>
    </table>
<%
    // Guardar el total a pagar
    MiSesion.setAttribute("Total", Total);
%>        
<a href="pagarCompra.jsp">Hacer Click para pagar la Compra</a>
</center>
