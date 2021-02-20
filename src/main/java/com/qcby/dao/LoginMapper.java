package com.qcby.dao;

import com.qcby.entity.Login;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface LoginMapper {

    List<Login> selectAll(@Param("login") Login login,@Param("pageIndex") int pageIndex,@Param("pageSize") int pageSize);

    int deleteById(Long id);

    int insert(Login record);

    int update(Login login);

    int selectCount();

    Login selectByName(String adminName);

    int updatePwd(Login login);

    Login selectByTel(Long phone);

    int updateStatus(Login login);

    int updateSex(Login login);
}