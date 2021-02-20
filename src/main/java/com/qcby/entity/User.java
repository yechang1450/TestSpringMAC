package com.qcby.entity;

import lombok.Data;

@Data
public class User {

    private Long id;

    private String userName;

    private String userPhone;

    private Boolean userStatus;

    private String seatName;

    private Boolean accStatus;

    private Double balance;

}