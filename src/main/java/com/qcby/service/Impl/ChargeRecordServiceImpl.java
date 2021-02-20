package com.qcby.service.Impl;

import com.qcby.dao.ChargeRecordMapper;
import com.qcby.entity.ChargeRecord;
import com.qcby.service.ChargeRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ChargeRecordServiceImpl implements ChargeRecordService {

    @Autowired
    ChargeRecordMapper chargeRecordMapper;
    @Override
    public List<ChargeRecord> findUserRecord(ChargeRecord chargeRecord,int page,int limit) {
        int pageIndex = (page-1) * limit;
        int pageSize = limit;
        return chargeRecordMapper.findUserRecord(chargeRecord,pageIndex,pageSize);
    }

    @Override
    public int selectCount() {
        return chargeRecordMapper.selectCount();
    }
}
