package com.qcby.service;

import com.qcby.entity.Area;
import com.qcby.entity.Seat;
import org.springframework.stereotype.Service;

import java.util.List;



public interface AreaService {

     List<Area> selectall(int page, int limit);


     int insert(Area area);

   int deleteById(Long id);

    int updateByPrimaryKey(Area area);

    int selectCount();
}
