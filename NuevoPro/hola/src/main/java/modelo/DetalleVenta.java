package modelo;

//DetalleVenta.java
public class DetalleVenta {
 private String idVenta;
 private String idProducto;
 private int cantidad;
 private double precioUnidad;
 private char estado;
 
 // Constructor
 public DetalleVenta(String idVenta, String idProducto, int cantidad, double precioUnidad, char estado) {
     this.idVenta = idVenta;
     this.idProducto = idProducto;
     this.cantidad = cantidad;
     this.precioUnidad = precioUnidad;
     this.estado = estado;
 }
 
 // Getters
 public String getIdVenta() {
     return idVenta;
 }
 
 public String getIdProducto() {
     return idProducto;
 }
 
 public int getCantidad() {
     return cantidad;
 }
 
 public double getPrecioUnidad() {
     return precioUnidad;
 }
 
 public char getEstado() {
     return estado;
 }
}
