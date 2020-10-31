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
public class DetalleFactura {
    private int IdDetalleFactura;
    private String CodProducto, nombreProducto , precio, cantidad;

    public DetalleFactura(int IdDetalleFactura, String CodProducto, String nombreProducto, String precio, String cantidad) {
        this.IdDetalleFactura = IdDetalleFactura;
        this.CodProducto = CodProducto;
        this.nombreProducto = nombreProducto;
        this.precio = precio;
        this.cantidad = cantidad;
    }

    public int getIdDetalleFactura() {
        return IdDetalleFactura;
    }

    public void setIdDetalleFactura(int IdDetalleFactura) {
        this.IdDetalleFactura = IdDetalleFactura;
    }

    public String getCodProducto() {
        return CodProducto;
    }

    public void setCodProducto(String CodProducto) {
        this.CodProducto = CodProducto;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    public String getPrecio() {
        return precio;
    }

    public void setPrecio(String precio) {
        this.precio = precio;
    }

    public String getCantidad() {
        return cantidad;
    }

    public void setCantidad(String cantidad) {
        this.cantidad = cantidad;
    }
    
}
