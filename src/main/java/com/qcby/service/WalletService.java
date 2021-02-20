package com.qcby.service;

import com.qcby.entity.Wallet;

import java.util.List;

public interface WalletService {
    List<Wallet> findUserCharge(Wallet wallet, int page, int limit);

    int updateCharge(Wallet wallet);

    int deleteId(Wallet wallet);

    int selectCount();
}
