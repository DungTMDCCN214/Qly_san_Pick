/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class ServiceUsage {
    private int usage_id;
    private int booking_id;
    private int service_id;
    private int quantity;
    private double unit_price;
    private double total_price;
    
    public ServiceUsage(){
        
    }

    public ServiceUsage(int usage_id, int booking_id, int service_id, int quantity, double unit_price, double total_price) {
        this.usage_id = usage_id;
        this.booking_id = booking_id;
        this.service_id = service_id;
        this.quantity = quantity;
        this.unit_price = unit_price;
        this.total_price = total_price;
    }

    public int getUsage_id() {
        return usage_id;
    }

    public void setUsage_id(int usage_id) {
        this.usage_id = usage_id;
    }

    public int getBooking_id() {
        return booking_id;
    }

    public void setBooking_id(int booking_id) {
        this.booking_id = booking_id;
    }

    public int getService_id() {
        return service_id;
    }

    public void setService_id(int service_id) {
        this.service_id = service_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getUnit_price() {
        return unit_price;
    }

    public void setUnit_price(double unit_price) {
        this.unit_price = unit_price;
    }

    public double getTotal_price() {
        return total_price;
    }

    public void setTotal_price(double total_price) {
        this.total_price = total_price;
    }
    
}
