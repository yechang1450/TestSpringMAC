package com.qcby.dao;

import com.qcby.entity.Order;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderMapper {
//    Login selectByTel(Long phone);

    int deleteByPrimaryKey(Long id);

    int insert(Order order);

    int insertSelective(Order record);

    Order selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);

    List<Order> selectOrderList();

    String deleteById(Long id);

    int update(Order order);

    List<Order> selectOrderList(@Param("order") Order order, @Param("pageIndex") int pageIndex, @Param("pageSize") int pageSize);

    int selectCount();

    String selectbyId(long id);

    int updateByOrderStatus(Order order);
}