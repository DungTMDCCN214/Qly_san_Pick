/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class ImportOrderDetail {
    private  int detail_id;
    private int order_id;
    private int equipment_id;
    private int quantity;
    private double price;
    public ImportOrderDetail(){
        
    }
    
    public ImportOrderDetail(int detail_id, int order_id, int equipment_id, int quantity, double price){
        this.detail_id = detail_id;
        this.order_id = order_id;
        this.equipment_id = equipment_id;
        this.quantity = quantity;
        this.price = price;
               
    }

    public int getDetail_id() {
        return detail_id;
    }

    public void setDetail_id(int detail_id) {
        this.detail_id = detail_id;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getEquipment_id() {
        return equipment_id;
    }

    public void setEquipment_id(int equipment_id) {
        this.equipment_id = equipment_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
           
}
