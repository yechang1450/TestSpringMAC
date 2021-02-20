package com.qcby.dao;

import com.qcby.entity.Category;
import com.qcby.entity.Goods;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GoodsMapper {


    List<Goods> findGoodsList(@Param("goods") Goods goods, @Param("pageIndex") int pageIndex, @Param("pageSize") int pageSize);

    Integer deleteGoodsById(long id);

    Integer addGoods(Goods goods);

    Integer updateGoods(Goods goods);

    int selectCount();

    int updateStatus(Goods goods);
}