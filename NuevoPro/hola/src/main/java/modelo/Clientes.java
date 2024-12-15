package modelo;

public class Clientes {
    // Campos o Atributos
    private String IdCliente;
    private String Apellidos;
    private String Nombres;
    private String Direccion;
    private String FechaNacimiento;
    private char Sexo;
    private String Correo;
    private char Tipo;
    private String Password;
    private char Estado;

    // Métodos Constructores
    public Clientes() {
    }
        
    public Clientes(String idCliente, String apellidos, String nombres, String direccion, String fechaNacimiento,
			char sexo, String correo, char tipo, String password, char estado) {
		IdCliente = idCliente;
		Apellidos = apellidos;
		Nombres = nombres;
		Direccion = direccion;
		FechaNacimiento = fechaNacimiento;
		Sexo = sexo;
		Correo = correo;
		Tipo = tipo;
		Password = password;
		Estado = estado;
	}


	// Propiedades de Lectura y Escritura
    
	public String getIdCliente() {
		return IdCliente;
	}

	public void setIdCliente(String idCliente) {
		IdCliente = idCliente;
	}

	public String getApellidos() {
		return Apellidos;
	}

	public void setApellidos(String apellidos) {
		Apellidos = apellidos;
	}

	public String getNombres() {
		return Nombres;
	}

	public void setNombres(String nombres) {
		Nombres = nombres;
	}

	public String getDireccion() {
		return Direccion;
	}

	public void setDireccion(String direccion) {
		Direccion = direccion;
	}

	public String getFechaNacimiento() {
		return FechaNacimiento;
	}

	public void setFechaNacimiento(String fechaNacimiento) {
		FechaNacimiento = fechaNacimiento;
	}

	public char getSexo() {
		return Sexo;
	}

	public void setSexo(char sexo) {
		Sexo = sexo;
	}

	public String getCorreo() {
		return Correo;
	}

	public void setCorreo(String correo) {
		Correo = correo;
	}

	public char getTipo() {
		return Tipo;
	}

	public void setTipo(char tipo) {
		Tipo = tipo;
	}

	public String getPassword() {
		return Password;
	}

	public void setPassword(String password) {
		Password = password;
	}

	public char getEstado() {
		return Estado;
	}

	public void setEstado(char estado) {
		Estado = estado;
	}

        
}
