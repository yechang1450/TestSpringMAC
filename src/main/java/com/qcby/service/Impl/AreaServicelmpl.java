package com.qcby.service.Impl;

import com.qcby.dao.AreaMapper;
import com.qcby.entity.Area;
import com.qcby.service.AreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("AreaService")
public class AreaServicelmpl implements AreaService {
    @Autowired
    private AreaMapper areaMapper;
    @Override
    public List<Area> selectall (int page,int limit){
        int pageIndex = (page-1) * limit;
        int pageSize = limit;
        return this.areaMapper.selectall(pageIndex,pageSize);
    }



    @Override
    public int insert(Area area) {
        return  areaMapper.insert(area);
    }

    @Override
    public int deleteById(Long id) {
        return areaMapper.deleteById(id);
    }

    @Override
    public int updateByPrimaryKey(Area area) {

        return areaMapper.updateByPrimaryKey(area);
    }

    @Override
    public int selectCount() {
        return this.areaMapper.selectCount();
    }


}
