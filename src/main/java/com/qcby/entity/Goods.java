package com.qcby.entity;

import lombok.Data;

import java.math.BigDecimal;
@Data
public class Goods {
    private Long id;

    private Long categoryId;

    private Long goodsId;

    private String goodsName;

    private BigDecimal goodsPrice;

    private String goodsStock;

    private Boolean goodsStatus;

    private String describe;

    private Boolean deleteStatus;


}