package com.qcby.dao;

import com.qcby.entity.Seat;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface SeatMapper {


    int deleteByPrimaryKey(Integer id);



    int insertSelective(Seat record);

    Seat selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Seat record);

    int updateByPrimaryKey(Seat record);

    List<Seat> findSeatList(@Param("seat") Seat seat, @Param("pageIndex") int pageIndex, @Param("pageSize") int pageSize);

    int insert(Seat seat) ;
    int deleteById(Long id);


    int selectCount();

    int updateSeatLightStatus(Seat seat);
}