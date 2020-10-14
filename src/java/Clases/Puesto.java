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
public class Puesto {
    private int idPuesto;
    private String codPuesto, nombre;

    public Puesto(int idPuesto, String codPuesto, String nombre) {
        this.idPuesto = idPuesto;
        this.codPuesto = codPuesto;
        this.nombre = nombre;
    }

    public int getIdPuesto() {
        return idPuesto;
    }

    public void setIdPuesto(int idPuesto) {
        this.idPuesto = idPuesto;
    }

    public String getCodPuesto() {
        return codPuesto;
    }

    public void setCodPuesto(String codPuesto) {
        this.codPuesto = codPuesto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
}
