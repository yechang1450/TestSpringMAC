package com.qcby.service;

import com.qcby.entity.Order;

import java.util.List;

public interface OrderService {
//    Login selectByTel(Long phone);

    List<Order> selectOrderList(Order order, int page, int limit);

    int insert(Order order);

    String deleteById(Long id);

    int update(Order order);

    int selectCount();

    String selectbyId(long id);

    int updateByOrderStatus(Order order);




}
