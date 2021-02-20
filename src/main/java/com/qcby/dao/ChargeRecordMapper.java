package com.qcby.dao;

import com.qcby.entity.ChargeRecord;
import com.qcby.entity.Wallet;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ChargeRecordMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ChargeRecord record);

    int insertSelective(ChargeRecord record);

    ChargeRecord selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ChargeRecord record);

    int updateByPrimaryKey(ChargeRecord record);

    List<ChargeRecord> findUserRecord(@Param("chargeRecord") ChargeRecord chargeRecord, @Param("pageIndex") int pageIndex, @Param("pageSize") int pageSize);

    int selectCount();
}