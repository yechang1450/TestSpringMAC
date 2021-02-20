package com.qcby.entity;

import java.util.Date;

public class ChargeRecord {
    private Integer id;

    private String userName;

    private String amount;

    private Date amount_time;

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

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount == null ? null : amount.trim();
    }

    public Date getAmount_time() {
        return amount_time;
    }

    public void setAmount_time(Date amount_time) {
        this.amount_time = amount_time;
    }
}