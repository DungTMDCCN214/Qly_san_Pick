/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;

/**
 *
 * @author Admin
 */
public class Court {
    private int court_id;
    private String court_name;
    private double price_per_hour;
    private String status;
    private String description;
    private String imgUrl;
    
    // Getter và Setter cho imgUrl
    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    // Constructor đầy đủ 6 tham số (CÓ imgUrl)
    public Court(int court_id, String court_name, double price_per_hour, String status, String description, String imgUrl) {
        this.court_id = court_id;
        this.court_name = court_name;
        this.price_per_hour = price_per_hour;
        this.status = status;
        this.description = description;
        this.imgUrl = imgUrl;
    }
    
    // Constructor 5 tham số (KHÔNG imgUrl) - GIỮ LẠI ĐỂ TƯƠNG THÍCH VỚI CODE CŨ
    public Court(int court_id, String court_name, double price_per_hour, String status, String description) {
        this.court_id = court_id;
        this.court_name = court_name;
        this.price_per_hour = price_per_hour;
        this.status = status;
        this.description = description;
        this.imgUrl = null; // Mặc định null nếu không có ảnh
    }
    
    // Constructor mặc định
    public Court() {}

    // Getter và Setter
    public int getCourt_id() {
        return court_id;
    }

    public void setCourt_id(int court_id) {
        this.court_id = court_id;
    }

    public String getCourt_name() {
        return court_name;
    }

    public void setCourt_name(String court_name) {
        this.court_name = court_name;
    }

    public double getPrice_per_hour() {
        return price_per_hour;
    }

    public void setPrice_per_hour(double price_per_hour) {
        this.price_per_hour = price_per_hour;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}