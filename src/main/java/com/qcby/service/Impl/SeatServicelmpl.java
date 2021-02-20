package com.qcby.service.Impl;

import com.qcby.dao.SeatMapper;
import com.qcby.entity.Seat;
import com.qcby.service.SeatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service("SeatService")
public class SeatServicelmpl implements SeatService {

    @Autowired
    private SeatMapper seatMapper;

    @Override
    public int updateByPrimaryKey(Seat seat) {
        return this.seatMapper.updateByPrimaryKey(seat);
    }

    @Override
    public int insert(Seat seat) {
        return this.seatMapper.insert(seat);
    }

    @Override
    public List<Seat> findSeatList(Seat seat, int page,int limit){
        int pageIndex = (page-1) * limit;
        int pageSize = limit;
        return seatMapper.findSeatList(seat, pageIndex, pageSize);
   }

    @Override
    public int deleteById(Long id) {
        return seatMapper.deleteById(id);
    }

    @Override
    public int selectCount() {
        return this.seatMapper.selectCount();
    }

    @Override
    public int updateSeatLightStatus(Seat seat) {
        return this.seatMapper.updateSeatLightStatus(seat);
    }

}
