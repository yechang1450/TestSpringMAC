package com.qcby.service.Impl;


import com.qcby.dao.OrderMapper;
import com.qcby.entity.Order;
import com.qcby.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

//    @Override
//    public Login selectByTel(Long phone) {
//        return this.loginMapper.selectByTel(phone);
//    }

    @Override
    public List<Order> selectOrderList(Order order,int page,int limit) {
//        因为你的时候需要2个参数，page（当前页数），第二个pageSize(每页显示的记录数)。
//        假设shu你每页显示10条，第一页：0-10，第二页：10-20，第三页：20-30。
//        然后你在根据规律计算的出来的规律就是pageindex=(page - 1) * pagesize;
//        第二页的开始记录是：10=(2-1)*10 ；


        int pageIndex = (page-1) * limit;
        int pageSize = limit;

        return orderMapper.selectOrderList(order,pageIndex,pageSize);
    }



    @Override
    public int insert(Order order) {
        return orderMapper.insert(order);
    }

    @Override
    public String deleteById(Long id) {
        return orderMapper.deleteById(id);
    }

    @Override
    public int update(Order order) {
        return orderMapper.update(order);
    }

    @Override
    public int selectCount() {
        return  this.orderMapper.selectCount();
    }

    @Override
    public String selectbyId(long id) {
        return this.orderMapper.selectbyId(id);
    }

    @Override
    public int updateByOrderStatus(Order order) {
        System.out.println(order.getOrderStatus());
        return this.orderMapper.updateByOrderStatus(order);
    }
}
