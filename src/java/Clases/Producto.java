/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

/**
 *
 * @author juanc
 */
public class Producto {
    private int idProducto, idMarca, idCategoria, idProveedor;
    private String codProducto, nombre, precio, existencia, orden_compra, serie_factura, numero_factura;
    private String nombreMarca, nombreCate, nombreProv;

    public Producto(int idProducto, int idMarca, int idCategoria, int idProveedor, String codProducto, String nombre, String precio, String existencia, String orden_compra, String serie_factura, String numero_factura, String nombreMarca, String nombreCate, String nombreProv) {
        this.idProducto = idProducto;
        this.idMarca = idMarca;
        this.idCategoria = idCategoria;
        this.idProveedor = idProveedor;
        this.codProducto = codProducto;
        this.nombre = nombre;
        this.precio = precio;
        this.existencia = existencia;
        this.orden_compra = orden_compra;
        this.serie_factura = serie_factura;
        this.numero_factura = numero_factura;
        this.nombreMarca = nombreMarca;
        this.nombreCate = nombreCate;
        this.nombreProv = nombreProv;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public int getIdMarca() {
        return idMarca;
    }

    public void setIdMarca(int idMarca) {
        this.idMarca = idMarca;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public int getIdProveedor() {
        return idProveedor;
    }

    public void setIdProveedor(int idProveedor) {
        this.idProveedor = idProveedor;
    }

    public String getCodProducto() {
        return codProducto;
    }

    public void setCodProducto(String codProducto) {
        this.codProducto = codProducto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPrecio() {
        return precio;
    }

    public void setPrecio(String precio) {
        this.precio = precio;
    }

    public String getExistencia() {
        return existencia;
    }

    public void setExistencia(String existencia) {
        this.existencia = existencia;
    }

    public String getOrden_compra() {
        return orden_compra;
    }

    public void setOrden_compra(String orden_compra) {
        this.orden_compra = orden_compra;
    }

    public String getSerie_factura() {
        return serie_factura;
    }

    public void setSerie_factura(String serie_factura) {
        this.serie_factura = serie_factura;
    }

    public String getNumero_factura() {
        return numero_factura;
    }

    public void setNumero_factura(String numero_factura) {
        this.numero_factura = numero_factura;
    }

    public String getNombreMarca() {
        return nombreMarca;
    }

    public void setNombreMarca(String nombreMarca) {
        this.nombreMarca = nombreMarca;
    }

    public String getNombreCate() {
        return nombreCate;
    }

    public void setNombreCate(String nombreCate) {
        this.nombreCate = nombreCate;
    }

    public String getNombreProv() {
        return nombreProv;
    }

    public void setNombreProv(String nombreProv) {
        this.nombreProv = nombreProv;
    }
    
}
