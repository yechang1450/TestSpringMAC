package com.qcby.service;

import com.qcby.entity.ConsumptionRecord;

import java.util.List;

public interface ConsumptionRecordService {
    List<ConsumptionRecord> findUserConsumptionRecord(ConsumptionRecord consumptionRecord, int page, int limit);

    int selectCount();
}
