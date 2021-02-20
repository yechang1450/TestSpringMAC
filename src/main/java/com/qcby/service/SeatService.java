package com.qcby.service;

import com.qcby.entity.Seat;
import org.springframework.stereotype.Service;

import java.util.List;


public interface SeatService {

      int updateByPrimaryKey(Seat seat);

      int insert(Seat seat) ;

     List<Seat> findSeatList(Seat seat, int page, int limit);

     int deleteById(Long id);

    int selectCount();

    int updateSeatLightStatus(Seat seat);
}

