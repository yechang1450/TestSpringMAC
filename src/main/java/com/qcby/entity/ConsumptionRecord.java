package com.qcby.entity;

import java.util.Date;

public class ConsumptionRecord {
    private Integer id;

    private String userName;

    private String consumption;

    private Date consumption_time;

    private String consumption_detail;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public String getConsumption() {
        return consumption;
    }

    public void setConsumption(String consumption) {
        this.consumption = consumption == null ? null : consumption.trim();
    }

    public Date getConsumption_time() {
        return consumption_time;
    }

    public void setConsumption_time(Date consumption_time) {
        this.consumption_time = consumption_time;
    }

    public String getConsumption_detail() {
        return consumption_detail;
    }

    public void setConsumption_detail(String consumption_detail) {
        this.consumption_detail = consumption_detail == null ? null : consumption_detail.trim();
    }
}