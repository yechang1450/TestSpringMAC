package com.qcby.dao;

import com.qcby.entity.Area;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface AreaMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Area area);

    int insertSelective(Area record);

    Area selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Area record);

    int updateByPrimaryKey(Area area);

    List<Area> selectall(int page, int limit);
    int deleteById(Long id);
    int selectCount();
}