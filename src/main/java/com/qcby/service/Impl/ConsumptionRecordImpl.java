package com.qcby.service.Impl;

import com.qcby.dao.ConsumptionRecordMapper;
import com.qcby.entity.ConsumptionRecord;
import com.qcby.service.ConsumptionRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ConsumptionRecordImpl implements ConsumptionRecordService {
    @Autowired
    ConsumptionRecordMapper consumptionRecordMapper;
    @Override
    public List<ConsumptionRecord> findUserConsumptionRecord(ConsumptionRecord consumptionRecord,int page,int limit) {
        int pageIndex = (page-1) * limit;
        int pageSize = limit;
        return consumptionRecordMapper.findUserConsumptionRecord(consumptionRecord,pageIndex,pageSize);
    }

    @Override
    public int selectCount() {
        return consumptionRecordMapper.selectCount();
    }
}
