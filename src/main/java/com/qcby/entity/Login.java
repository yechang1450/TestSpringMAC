package com.qcby.entity;

import lombok.Data;

@Data
public class Login {

    private Long id;

    private String adminName;

    private String password;

    private String sex;

    private Long phone;

    private String address;

    private Boolean status;

}