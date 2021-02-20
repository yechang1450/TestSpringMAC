package com.qcby.service;

import com.qcby.entity.Goods;
import org.springframework.stereotype.Service;

import java.util.List;

public interface GoodsService {
    List<Goods> findGoodsList(Goods goods, int page, int limit);



    Integer deleteGoodsById(Long id);

    Integer addGoods(Goods goods);

    Integer updateGoods(Goods goods);


    int selectCount();

    int updateStatus(Goods goods);
}
