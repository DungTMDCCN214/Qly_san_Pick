/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Equipment {
    private int equipment_id;
    private String equipment_name;
    private int quantity;
    private String status;
    
    public Equipment(){
        
    }
    public Equipment(int equipment_id, String equipment_name, int quantity, String status){
        this.equipment_id = equipment_id;
        this.equipment_name = equipment_name;
        this.quantity = quantity;
        this.status = status;
        
    }

   

    public int getEquipment_id() {
        return equipment_id;
    }

    public void setEquipmet_id(int equipment_id) {
        this.equipment_id = equipment_id;
    }

    public String getEquipment_name() {
        return equipment_name;
    }

    public void setEquipment_name(String equipment_name) {
        this.equipment_name = equipment_name;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    
}
