package com.qcby.service;

        import com.qcby.entity.Login;

        import java.util.List;

public interface LoginService {

    List<Login> selectAll(Login login,int page, int limit);

    int deleteById(Long id);

    int update(Login login);

    int insert(Login login);

    int selectCount();

    Login selectByName(String adminName);

    int updatePwd(Login login);

    Login selectByTel(Long phone);

    int updateStatus(Login login);

    int updateSex(Login login);
}
