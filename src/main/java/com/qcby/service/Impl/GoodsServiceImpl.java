package com.qcby.service.Impl;

import com.qcby.dao.GoodsMapper;
import com.qcby.entity.Goods;
import com.qcby.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class GoodsServiceImpl implements GoodsService {
    @Autowired
    public GoodsMapper goodsMapper;
    @Override
    public List<Goods> findGoodsList(Goods goods,int page,int limit) {
        int pageIndex = (page-1) * limit;
        int pageSize = limit;
        return goodsMapper.findGoodsList(goods,pageIndex,pageSize);
    }

    @Override
    public Integer deleteGoodsById(Long id) {
        return goodsMapper.deleteGoodsById(id);
    }

    @Override
    public Integer addGoods(Goods goods) {
        return goodsMapper.addGoods(goods);
    }

    @Override
    public Integer updateGoods(Goods goods) {
        return goodsMapper.updateGoods(goods);
    }

    @Override
    public int selectCount() {
        return goodsMapper.selectCount();
    }

    @Override
    public int updateStatus(Goods goods) {
        return goodsMapper.updateStatus(goods);
    }


}
