<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="modelo.*"%>
<%@page import="controller.*"%>
<%@page session="true" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Verificar Usuario</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
	</head>
<body style="background-color: #ffa59c;">
	<%	CarritoBD ObjBD = new CarritoBD();
		Clientes ObjC = new Clientes();
		HttpSession MiSesion = null;
		String IdCliente, Password, Tipo;
		try{
			// Recuperar el id, clave y tipo de cliente
			IdCliente = request.getParameter("txtid");
		    Password = request.getParameter("txtpass");
		    Tipo = request.getParameter("cboClase").toString();
		    // Verificar si existe en la tabla Clientes
		    if(!ObjBD.VerificaUsuario(IdCliente, Password)){
		        out.print("!!!!!!Error en iniciar session algo va mal");
		        out.print("<a width:100  href=index.html>Intentar de nuevo</a>");
		    }else{
		    	// Recupera datos del clientes
		    	ObjC = ObjBD.InfoCliente(IdCliente);
		    	// Verificar si se encuentra la sesion activa del proyecto
		    	if(request.getSession() != null){
		    		// Crear la sesion del proyecto y guardar valores del cliente
		    		MiSesion = request.getSession();
		    		MiSesion.setAttribute("Id",ObjC.getIdCliente());
		    		MiSesion.setAttribute("Apellidos",ObjC.getApellidos());
		    		MiSesion.setAttribute("Nombres",ObjC.getNombres());
		    	}    	
		    	// Según el tipo de cliente redireccionar
		    	if(Tipo.equals("A"))response.sendRedirect("consultas.html");
		    	else response.sendRedirect("principal.jsp");
		    }
		}catch(Exception ex){
			
			}
	%>
</body>
</html>