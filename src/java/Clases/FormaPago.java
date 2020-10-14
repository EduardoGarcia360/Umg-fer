/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

/**
 *
 * @author Eduardo
 */
public class FormaPago {
    private int idFormaPago;
    private String codPago, nombre;

    public FormaPago(int idFormaPago, String codPago, String nombre) {
        this.idFormaPago = idFormaPago;
        this.codPago = codPago;
        this.nombre = nombre;
    }

    public int getIdFormaPago() {
        return idFormaPago;
    }

    public void setIdFormaPago(int idFormaPago) {
        this.idFormaPago = idFormaPago;
    }

    public String getCodPago() {
        return codPago;
    }

    public void setCodPago(String codPago) {
        this.codPago = codPago;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
}
