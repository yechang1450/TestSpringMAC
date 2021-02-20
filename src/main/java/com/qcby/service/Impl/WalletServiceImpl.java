package com.qcby.service.Impl;

import com.qcby.dao.WalletMapper;
import com.qcby.entity.Wallet;
import com.qcby.service.WalletService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class WalletServiceImpl implements WalletService {
    @Autowired
    private WalletMapper walletMapper;
    @Override

    public List<Wallet> findUserCharge(Wallet wallet,int page,int limit) {
        int pageIndex = (page-1) * limit;
        int pageSize = limit;
        return walletMapper.findUserCharge(wallet,pageIndex,pageSize);
    }

    @Override
    public int updateCharge(Wallet wallet) {
        return walletMapper.updateCharge(wallet);
    }

    @Override
    public int deleteId(Wallet wallet) {
        return walletMapper.deleteId(wallet);
    }

    @Override
    public int selectCount() {
        return walletMapper.selectCount();
    }
}
