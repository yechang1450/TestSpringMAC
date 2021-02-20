package com.qcby.dao;

import com.qcby.entity.Wallet;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface WalletMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Wallet record);

    int insertSelective(Wallet record);

    Wallet selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Wallet record);

    int updateByPrimaryKey(Wallet record);

    List<Wallet> findUserCharge(@Param("wallet") Wallet wallet, @Param("pageIndex") int pageIndex, @Param("pageSize") int pageSize);

    int updateCharge(Wallet wallet);

    int deleteId(Wallet wallet);

    int selectCount();
}