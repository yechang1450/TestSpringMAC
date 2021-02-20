package com.qcby.service;

import com.qcby.entity.ChargeRecord;

import java.util.List;

public interface ChargeRecordService {
    List<ChargeRecord> findUserRecord(ChargeRecord chargeRecord, int page, int limit);

    int selectCount();
}
