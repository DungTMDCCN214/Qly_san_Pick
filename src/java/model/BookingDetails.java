/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author ADMIN
 */
public class BookingDetails {
    private int id;
    private int bookingId;
    private int startTime;
    private int endTime;
    private Timestamp createdAt;

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public BookingDetails() {
        
    }

    public BookingDetails(int id, int bookingId, int startTime, int endTime) {
        this.id = id;
        this.bookingId = bookingId;
        this.startTime = startTime;
        this.endTime = endTime;
    }
    
    public BookingDetails(int bookingId, int gioBatDau, int gioKetThuc) {
        this.bookingId = bookingId;
        this.startTime = gioBatDau;
        this.endTime = gioKetThuc;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getStartTime() {
        return startTime;
    }

    public void setStartTime(int startTime) {
        this.startTime = startTime;
    }

    public int getEndTime() {
        return endTime;
    }

    public void setEndTime(int endTime) {
        this.endTime = endTime;
    }
    
    
}
