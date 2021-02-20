package com.qcby.entity;

public class Seat {
    private Long id;

    private Boolean seatLightStatus;

    private Long areaId;

    private Boolean vipStatus;

    private Integer state;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Boolean getSeatLightStatus() {
        return seatLightStatus;
    }

    public void setSeatLightStatus(Boolean seatLightStatus) {

        this.seatLightStatus = seatLightStatus;
    }

    public Long getAreaId() {
        return areaId;
    }

    public void setAreaId(Long areaId) {
        this.areaId = areaId;
    }

    public Boolean getVipStatus() {
        return vipStatus;
    }

    public void setVipStatus(Boolean vipStatus) {
        this.vipStatus = vipStatus;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }
}