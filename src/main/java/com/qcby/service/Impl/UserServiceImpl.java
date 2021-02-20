package com.qcby.service.Impl;

import com.qcby.dao.UserMapper;
import com.qcby.entity.User;
import com.qcby.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("UserService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public List<User> selectAll(User user,int page,int limit) {
        int pageIndex = (page-1) * limit;
        int pageSize = limit;
        return this.userMapper.selectAll(user,pageIndex,pageSize);
    }

    @Override
    public int deleteById(Long id) {
        return this.userMapper.deleteById(id);
    }

    @Override
    public int update(User user) {
        return this.userMapper.update(user);
    }

    @Override
    public int insert(User user) {
        return this.userMapper.insert(user);
    }

    @Override
    public int selectCount() {
        return this.userMapper.selectCount();
    }

    @Override
    public int updateUserStatus(User user) {
        return this.userMapper.updateUserStatus(user);
    }

    @Override
    public int updateAccStatus(User user) {
        return this.userMapper.updateAccStatus(user);
    }
}
