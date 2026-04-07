/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

public class Booking {
    private int bookingId;
    private int userId;
    private int courtId;
    private Date bookingDate;
    private String status;
    private Timestamp createdAt;
    private double totalPrice;
    
    private List<Integer> slots;
    private String courtName;

    public String getCourtName() {
        return courtName;
    }

    public void setCourtName(String courtName) {
        this.courtName = courtName;
    }

    public List<Integer> getSlots() {
        return slots;
    }

    public void setSlots(List<Integer> slots) {
        this.slots = slots;
    }
    

    // Constructor rỗng
    public Booking() {}

    // Constructor đầy đủ
    public Booking(int bookingId, int userId, int courtId, Date bookingDate, 
                   String status, Timestamp createdAt, double totalPrice) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.courtId = courtId;
        this.bookingDate = bookingDate;
        this.status = status;
        this.createdAt = createdAt;
        this.totalPrice = totalPrice;
    }

    // Getter & Setter
    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCourtId() {
        return courtId;
    }

    public void setCourtId(int courtId) {
        this.courtId = courtId;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }
}