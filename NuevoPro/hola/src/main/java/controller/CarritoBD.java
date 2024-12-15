package controller;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelo.*;

public class CarritoBD {
	// Campos o atributos
	private String Driver = "com.mysql.cj.jdbc.Driver";
	private String URL = "jdbc:mysql://localhost:3306/tienda2024";
	private String Usuario = "tino";
	private String Password = "escorpion";
	
	private Connection Cn;
	private Statement Cmd;
	private CallableStatement Stmt;
	private ResultSet Rs;   
	
	
	
	 
	private List<Categorias> ListaC;
	private List<Productos> ListaP;
	
	// Método Constructor
	public CarritoBD() {
		try {
				Class.forName(Driver);
				Cn = DriverManager.getConnection(URL, Usuario, Password);
		} catch (Exception e) {
				System.out.println("ERROR EN LA CONEXION:" + e.getMessage());
		}
	}
	
	// Método ListarCategorias
	public List<Categorias> ListarCategorias(){
		String SQL = "CALL ListarCategorias()";
		ListaC = new ArrayList<Categorias>();
		try {
				Stmt = Cn.prepareCall(SQL);
				Rs = Stmt.executeQuery();
				while(Rs.next()) {
					ListaC.add(new Categorias(Rs.getString("IdCategoria"), 
											Rs.getString("Descripcion"),
											Rs.getString("Imagen"),
											Rs.getString("Estado").charAt(0)));
				}
				Rs.close();
		} catch (Exception e) {
				System.out.println("ERROR EN CARGA DE TABLA CATEGORIAS :" + e.getMessage());
		}
		return ListaC;
	}
	
	// Método ListarProductos
	public List<Productos> ListarProductos(String IdCat){
		String SQL = "CALL ListarProductosXCategoria(?)";
		ListaP = new ArrayList<Productos>();
		try {
				Stmt = Cn.prepareCall(SQL);
				Stmt.setString(1, IdCat);
				Rs = Stmt.executeQuery();
				while(Rs.next()) {
					ListaP.add(new Productos(Rs.getString("IdProducto"), 
											Rs.getString("IdCategoria"),
											Rs.getString("Descripcion"),
											Rs.getDouble("PrecioUnidad"),
											Rs.getInt("Stock"),
											Rs.getString("Imagen"),
											Rs.getString("Estado").charAt(0)));
				}
				Rs.close();
		} catch (Exception e) {
				System.out.println("ERROR EN CARGA DE TABLA PRODUCTOS :" + e.getMessage());
		}
		return ListaP;
	}
	
	// Método InfoProducto
	public Productos InfoProducto(String IdPro) {
		String SQL = "CALL InfoProducto(?)";
		Productos ObjP = null;
		try {
				Stmt = Cn.prepareCall(SQL);
				Stmt.setString(1, IdPro);
				Rs = Stmt.executeQuery();
				if(Rs.next()) {
					ObjP = new Productos(Rs.getString("IdProducto"), 
										Rs.getString("IdCategoria"),
										Rs.getString("Descripcion"),
										Rs.getDouble("PrecioUnidad"),
										Rs.getInt("Stock"),
										Rs.getString("Imagen"),
										Rs.getString("Estado").charAt(0));
				}
				Rs.close();
		} catch (Exception e) {
			System.out.println("ERROR EN CARGA DE TABLA PRODUCTOS :" + e.getMessage());
		}
		return ObjP;
	}
	
	// Validar IdUsuario y Password
    public boolean VerificaUsuario(String IdCliente,String Password)
    { boolean estado = false;
        String SQL = "SELECT * FROM Clientes WHERE IdCliente='"+
                    IdCliente+"' AND Password='"+Password+"'";
        try {
            this.Cmd = this.Cn.createStatement();
            this.Rs = this.Cmd.executeQuery(SQL);
            if(this.Rs.next()){
                estado = true;
            }
        } catch (Exception e) {
            System.out.println("***ERROR:"+e.getMessage());
        }
      return estado;
    }
    
    // Devolver Informacion de Cliente
    public Clientes InfoCliente(String IdCliente)
    { Clientes ObjP = null;      
        try {
            // Establece el nombre del SP a invocar
            Stmt = Cn.prepareCall("CALL InfoCliente(?)");
            // Asigna el valor del unico parametro del SP
            Stmt.setString(1, IdCliente);
            // Ejecuta el SP y almacena los resultados
            Rs = Stmt.executeQuery();
            // Si recupero filas guardalo en un objeto de tipo Clientes
            if(Rs.next()){
                ObjP = new Clientes(
                            Rs.getString("IdCliente"),
                            Rs.getString("Apellidos"),
                            Rs.getString("Nombres"),
                            Rs.getString("Direccion"),
                            Rs.getString("FechaNacimiento"),
                            Rs.getString("Sexo").charAt(0),
                            Rs.getString("Correo"),
                            Rs.getString("Tipo").charAt(0),
                            Rs.getString("Password"),
                            Rs.getString("Estado").charAt(0)
                        );
            }
        } catch (Exception e) {
            System.out.println("***ERROR:"+e.getMessage());
        }
      return ObjP;  
    }
    
    // Método para insertar filas en la tabla ventas
    public void InsertarVenta(Ventas ObjV)
    {
        try {
            Stmt = this.Cn.prepareCall("CALL InsertaVenta(?,?,?,?,?)");
            Stmt.setString(1, ObjV.getIdVenta());
            Stmt.setString(2, ObjV.getIdCliente());
            Stmt.setString(3, ObjV.getFechaVenta());
            Stmt.setDouble(4, ObjV.getMontoTotal());
            Stmt.setString(5, ObjV.getEstado()+"");
            Stmt.executeUpdate(); // INSERT, DELETE o UPDATE
        } catch (Exception e) {
            System.out.println("***ERROR:"+e.getMessage());        
        }
    }
    
    // Método para insertar filas en la tabla detalle
    public void InsertarDetalle(Detalle ObjD)
    {
        try {
            Stmt = this.Cn.prepareCall("CALL InsertaDetalle(?,?,?,?,?)");
            Stmt.setString(1, ObjD.getIdVenta());
            Stmt.setString(2, ObjD.getIdProducto());
            Stmt.setInt(3, ObjD.getCantidad());
            Stmt.setDouble(4, ObjD.getPrecioUnidad());
            Stmt.setString(5, ObjD.getEstado()+"");
            Stmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("***ERROR:"+e.getMessage());  
        }
    }
    
    // Método para devolver el numero de filas de un tabla
    public int NumeroFilas(String NombreTabla)
    { 
    	int filas = 0;
      String SQL = "SELECT Count(*) FROM "+NombreTabla;
        try {
            this.Cmd = this.Cn.createStatement();
            this.Rs = this.Cmd.executeQuery(SQL);
            if(this.Rs.next()){
                filas = Rs.getInt(1);
            }
        } catch (Exception e) {
           System.out.println("***ERROR:"+e.getMessage());   
        }
      return filas;  
    }
    //
 // Método para listar clientes
    public List<Clientes> listarClientes() {
        String SQL = "SELECT * FROM Clientes";
        List<Clientes> clientes = new ArrayList<>();
        try {
            Statement stmt = Cn.createStatement();
            ResultSet rs = stmt.executeQuery(SQL);
            while (rs.next()) {
                String id = rs.getString("IdCliente");
                String nombres = rs.getString("Nombres");
                String apellidos = rs.getString("Apellidos");
                String direccion = rs.getString("Direccion");
                String fechaNacimiento = rs.getString("FechaNacimiento");
                char sexo = rs.getString("Sexo").charAt(0);
                String correo = rs.getString("Correo");
                char tipo = rs.getString("Tipo").charAt(0);
                String password = rs.getString("Password");
                char estado = rs.getString("Estado").charAt(0);
                
                Clientes cliente = new Clientes(id, nombres, apellidos, direccion, fechaNacimiento, sexo, correo, tipo, password, estado);
                clientes.add(cliente);
            }
            rs.close();
        } catch (SQLException e) {
            System.out.println("ERROR AL LISTAR CLIENTES: " + e.getMessage());
        }
        return clientes;
    }
 // Método para listar productos
    public List<Productos> listarProductos() {
        String SQL = "SELECT * FROM Productos";
        List<Productos> productos = new ArrayList<>();
        try {
            Statement stmt = Cn.createStatement();
            ResultSet rs = stmt.executeQuery(SQL);
            while (rs.next()) {
                String idProducto = rs.getString("IdProducto");
                String idCategoria = rs.getString("IdCategoria");
                String descripcion = rs.getString("Descripcion");
                double precioUnidad = rs.getDouble("PrecioUnidad");
                int stock = rs.getInt("Stock");
                String imagen = rs.getString("Imagen");
                char estado = rs.getString("Estado").charAt(0);
                
                Productos producto = new Productos(idProducto, idCategoria, descripcion, precioUnidad, stock, imagen, estado);
                productos.add(producto);
            }
            rs.close();
        } catch (SQLException e) {
            System.out.println("ERROR AL LISTAR PRODUCTOS: " + e.getMessage());
        }
        return productos;
    }
 // Método para listar ventas
    public List<Ventas> listarVentas() {
        String SQL = "SELECT * FROM Ventas";
        List<Ventas> ventas = new ArrayList<>();
        try {
            Statement stmt = Cn.createStatement();
            ResultSet rs = stmt.executeQuery(SQL);
            while (rs.next()) {
                String idVenta = rs.getString("IdVenta");
                String idCliente = rs.getString("IdCliente");
                String fechaVenta = rs.getString("FechaVenta");
                double montoTotal = rs.getDouble("MontoTotal");
                char estado = rs.getString("Estado").charAt(0);
                
                Ventas venta = new Ventas(idVenta, idCliente, fechaVenta, montoTotal, estado);
                ventas.add(venta);
            }
            rs.close();
        } catch (SQLException e) {
            System.out.println("ERROR AL LISTAR VENTAS: " + e.getMessage());
        }
        return ventas;
    }
    // Método para listar el detalle de una venta
    public List<DetalleVenta> listarDetalleVenta(String idVenta) {
    	String SQL = "SELECT * FROM Detalle WHERE IdVenta = ?";

        List<DetalleVenta> detalleVenta = new ArrayList<>();
        try {
            PreparedStatement pstmt = Cn.prepareStatement(SQL);
            pstmt.setString(1, idVenta);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                String idProducto = rs.getString("IdProducto");
                int cantidad = rs.getInt("Cantidad");
                double precioUnidad = rs.getDouble("PrecioUnidad");
                char estado = rs.getString("Estado").charAt(0);
                
                DetalleVenta detalle = new DetalleVenta(idVenta, idProducto, cantidad, precioUnidad, estado);
                detalleVenta.add(detalle);
            }
            rs.close();
        } catch (SQLException e) {
            System.out.println("ERROR AL LISTAR DETALLE DE VENTA: " + e.getMessage());
        }
        return detalleVenta;
    }
 // Método para obtener un producto por su ID
    public Productos obtenerProducto(String idProducto) {
        String SQL = "SELECT * FROM Productos WHERE IdProducto = ?";
        Productos producto = null;
        try {
            PreparedStatement pstmt = Cn.prepareStatement(SQL);
            pstmt.setString(1, idProducto);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                producto = new Productos(
                    rs.getString("IdProducto"),
                    rs.getString("IdCategoria"),
                    rs.getString("Descripcion"),
                    rs.getDouble("PrecioUnidad"),
                    rs.getInt("Stock"),
                    rs.getString("Imagen"),
                    rs.getString("Estado").charAt(0)
                );
            }
            rs.close();
        } catch (SQLException e) {
            System.out.println("ERROR AL OBTENER PRODUCTO: " + e.getMessage());
        }
        return producto;
    }
 // Método para buscar productos por nombre o descripción
    public List<Productos> buscarProductos(String criterio) {
        String SQL = "SELECT * FROM Productos WHERE Descripcion LIKE ?";
        List<Productos> resultados = new ArrayList<>();

        try (PreparedStatement pstmt = Cn.prepareStatement(SQL)) {
            // Agregar el '%' para buscar coincidencias parciales
            pstmt.setString(1, "%" + criterio + "%");
            ResultSet rs = pstmt.executeQuery();
            
            // Recorrer el resultado de la consulta y crear objetos Producto
            while (rs.next()) {
                Productos producto = new Productos(
                    rs.getString("IdProducto"), 
                    rs.getString("IdCategoria"),
                    rs.getString("Descripcion"),
                    rs.getDouble("PrecioUnidad"),
                    rs.getInt("Stock"),
                    rs.getString("Imagen"),
                    rs.getString("Estado").charAt(0)
                );
                resultados.add(producto);
            }
        } catch (SQLException e) {
            System.out.println("Error al buscar productos: " + e.getMessage());
        }

        return resultados;
    }
 // Método para obtener una categoría por su ID
    public Categorias obtenerCategoria(String idCategoria) {
        String SQL = "SELECT * FROM Categorias WHERE IdCategoria = ?";
        Categorias categoria = null;

        try (PreparedStatement pstmt = Cn.prepareStatement(SQL)) {
            pstmt.setString(1, idCategoria);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                categoria = new Categorias(
                    rs.getString("IdCategoria"),
                    rs.getString("Descripcion"),
                    rs.getString("Imagen"),
                    rs.getString("Estado").charAt(0)
                );
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener la categoría: " + e.getMessage());
        }

        return categoria;
    }
 // Método para buscar productos por descripción
    public List<Productos> buscarProductosPorDescripcion(String descripcion) {
        String SQL = "SELECT * FROM Productos WHERE Descripcion LIKE ?";
        List<Productos> resultados = new ArrayList<>();

        try (PreparedStatement pstmt = Cn.prepareStatement(SQL)) {
            pstmt.setString(1, "%" + descripcion + "%");
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Productos producto = new Productos(
                    rs.getString("IdProducto"), 
                    rs.getString("IdCategoria"),
                    rs.getString("Descripcion"),
                    rs.getDouble("PrecioUnidad"),
                    rs.getInt("Stock"),
                    rs.getString("Imagen"),
                    rs.getString("Estado").charAt(0)
                );
                resultados.add(producto);
            }
        } catch (SQLException e) {
            System.out.println("Error al buscar productos por descripción: " + e.getMessage());
        }

        return resultados;
    }
    public List<Productos> obtenerProductosPorCategoria(String idCategoria) {
        String SQL = "SELECT * FROM Productos WHERE IdCategoria = ?";
        List<Productos> resultados = new ArrayList<>();

        try (PreparedStatement pstmt = Cn.prepareStatement(SQL)) {
            pstmt.setString(1, idCategoria);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Productos producto = new Productos(
                    rs.getString("IdProducto"), 
                    rs.getString("IdCategoria"),
                    rs.getString("Descripcion"),
                    rs.getDouble("PrecioUnidad"),
                    rs.getInt("Stock"),
                    rs.getString("Imagen"),
                    rs.getString("Estado").charAt(0)
                );
                resultados.add(producto);
            }
        } catch (SQLException e) {
            System.out.println("Error al buscar productos por categoría: " + e.getMessage());
        }

        return resultados;
    }


}

