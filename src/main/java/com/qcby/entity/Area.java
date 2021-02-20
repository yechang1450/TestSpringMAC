package com.qcby.entity;

public class Area {
    private Long id;

    private Boolean areaLightStatus;

    private String areaPrice_hour;

    private String areaPrice_month;

    private Boolean areaStatus;

    private Boolean deleteStatus;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Boolean getAreaLightStatus() {
        return areaLightStatus;
    }

    public void setAreaLightStatus(Boolean areaLightStatus) {
        this.areaLightStatus = areaLightStatus;
    }

    public String getAreaPrice_hour() {
        return areaPrice_hour;
    }

    public void setAreaPrice_hour(String areaPrice_hour) {
        this.areaPrice_hour = areaPrice_hour == null ? null : areaPrice_hour.trim();
    }

    public String getAreaPrice_month() {
        return areaPrice_month;
    }

    public void setAreaPrice_month(String areaPrice_month) {
        this.areaPrice_month = areaPrice_month == null ? null : areaPrice_month.trim();
    }

    public Boolean getAreaStatus() {
        return areaStatus;
    }

    public void setAreaStatus(Boolean areaStatus) {
        this.areaStatus = areaStatus;
    }

    public Boolean getDeleteStatus() {
        return deleteStatus;
    }

    public void setDeleteStatus(Boolean deleteStatus) {
        this.deleteStatus = deleteStatus;
    }
}