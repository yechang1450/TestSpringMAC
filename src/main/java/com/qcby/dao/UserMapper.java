package com.qcby.dao;

import com.qcby.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {

    List<User> selectAll(@Param("user") User user, @Param("pageIndex") int pageIndex, @Param("pageSize") int pageSize);

    int deleteById(Long id);

    int insert(User record);

    int update(User user);

    int selectCount();

    int updateUserStatus(User user);

    int updateAccStatus(User user);
}