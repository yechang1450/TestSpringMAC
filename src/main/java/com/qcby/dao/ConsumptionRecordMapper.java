package com.qcby.dao;

import com.qcby.entity.ConsumptionRecord;
import com.qcby.entity.Wallet;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ConsumptionRecordMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ConsumptionRecord record);

    int insertSelective(ConsumptionRecord record);

    ConsumptionRecord selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ConsumptionRecord record);

    int updateByPrimaryKey(ConsumptionRecord record);

    List<ConsumptionRecord> findUserConsumptionRecord(@Param("consumptionRecord") ConsumptionRecord consumptionRecord, @Param("pageIndex") int pageIndex, @Param("pageSize") int pageSize) ;

    int selectCount();
}