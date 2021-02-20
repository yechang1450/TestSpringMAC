package com.qcby.service.Impl;

import com.qcby.dao.LoginMapper;
import com.qcby.entity.Login;
import com.qcby.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("LoginService")
public class LoginServiceImpl implements LoginService {

    @Autowired
    private LoginMapper loginMapper;

    @Override
    public List<Login> selectAll(Login login, int page, int limit) {
        int pageIndex = (page-1) * limit;
        int pageSize = limit;
        return this.loginMapper.selectAll(login,pageIndex,pageSize);
    }

    @Override
    public int deleteById(Long id) {
        return this.loginMapper.deleteById(id);
    }

    @Override
    public int update(Login login) {
        return this.loginMapper.update(login);
    }

    @Override
    public int insert(Login login) {
        return this.loginMapper.insert(login);
    }

    @Override
    public int selectCount() {
        return this.loginMapper.selectCount();
    }

    @Override
    public Login selectByName(String adminName) {
        return this.loginMapper.selectByName(adminName);
    }

    @Override
    public int updatePwd(Login login) {
        return this.loginMapper.updatePwd(login);
    }

    @Override
    public Login selectByTel(Long phone) {
        return this.loginMapper.selectByTel(phone);
    }

    @Override
    public int updateStatus(Login login) {
        return this.loginMapper.updateStatus(login);
    }

    @Override
    public int updateSex(Login login) {
        return this.loginMapper.updateSex(login);
    }

}
