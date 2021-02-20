package com.qcby.service;

import com.qcby.entity.User;

import java.util.List;

public interface UserService {

    List<User> selectAll(User user,int page,int limit);

    int deleteById(Long id);

    int update(User user);

    int insert(User user);

    int selectCount();

    int updateUserStatus(User user);

    int updateAccStatus(User user);
}
