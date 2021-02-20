package com.qcby.controller;

import com.alibaba.fastjson.JSON;
import com.qcby.entity.Login;
import com.qcby.service.LoginService;
import com.qcby.util.ObjtoLayJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.List;

@Controller
@RequestMapping("login")
public class LoginController {

    @Autowired
    private LoginService loginService;

    @ResponseBody
    @RequestMapping(value = "selectByName", method = RequestMethod.GET, produces = "text/json;charset=utf-8")
    public String selectByName(HttpServletRequest request) {
        Login login = loginService.selectByName(request.getParameter("adminName"));
        if(login!=null){
            String data = JSON.toJSONString(login);
            return data;
        }else{
            return "0";
        }
    }
    @ResponseBody
    @RequestMapping(value = "selectByTel", produces = "text/json;charset=utf-8")
    public String selectByTel(HttpServletRequest request) {
        Long phone = Long.valueOf(request.getParameter("phone"));
        Login login = loginService.selectByTel(phone);
        if(login!=null){
            String data = JSON.toJSONString(login);
            return data;
        }else{
            return "0";
        }
    }
    @ResponseBody
    @RequestMapping(value="updatePwd",produces = "text/json;charset=utf-8")
    public String updatePwd(HttpServletRequest request) {
        String adminName = request.getParameter("adminName");
        String password = request.getParameter("password");
        Login login = new Login();
        login.setAdminName(adminName);
        login.setPassword(password);
        loginService.updatePwd(login);
        String data = "{\"data\":\"修改密码成功\"}";
//        System.out.println(data);
        return data;
    }
    @ResponseBody
    @RequestMapping(value = "selectAll", method = RequestMethod.GET, produces = "text/json;charset=utf-8")
    public String selectAll(HttpServletRequest request,Login login) throws Exception {
        request.setCharacterEncoding("utf-8");
        String pageString = request.getParameter("page");
        String limitString = request.getParameter("limit");
        Integer page = Integer.valueOf(pageString);
        Integer limit = Integer.valueOf(limitString);
        List<Login> userData = loginService.selectAll(login, page, limit);
        String[] column = {"id", "adminName", "password", "sex", "phone", "address", "status"};
        String data = ObjtoLayJson.ListtoJson(userData, column);
        return data;
    }
    @ResponseBody
    @RequestMapping(value="deleteById",method = RequestMethod.GET,produces = "text/json;charset=utf-8")
    public String deleteById(Login login) {
        loginService.deleteById(login.getId());
        String data = "{\"data\":\"删除成功\"}";
//        System.out.println(data);
        return data;
    }
    @ResponseBody
    @RequestMapping(value="insert",method = RequestMethod.GET,produces = "text/json;charset=utf-8")
    public String insert(Login login) {
        loginService.insert(login);
        String data = "{\"data\":\"添加成功\"}";
//        System.out.println(data);
        return data;
    }
    @ResponseBody
    @RequestMapping(value="update",method = RequestMethod.GET,produces = "text/json;charset=utf-8")
    public String update(Login login) {
        loginService.update(login);
        String data = "{\"data\":\"更新成功\"}";
//        System.out.println(data);
        return data;
    }
    @ResponseBody
    @RequestMapping(value="updateSex",method = RequestMethod.GET,produces = "text/json;charset=utf-8")
    public String updateSex(Login login) {
        if(login.getSex().equals("男")){
            login.setSex("女");
        }else if(login.getSex().equals("女")){
            login.setSex("男");
        }
        loginService.updateSex(login);
        return null;
    }
    @ResponseBody
    @RequestMapping(value="updateStatus",method = RequestMethod.GET,produces = "text/json;charset=utf-8")
    public String updateStatus(Login login) {
        loginService.updateStatus(login);
        return null;
    }
    @ResponseBody
    @RequestMapping(value = "selectCount", method = RequestMethod.GET, produces = "text/json;charset=utf-8")
    public String SelectCount(HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("utf-8");
        int count = loginService.selectCount();
        String data = String.valueOf(count);
        String countData= "{"+"\"count\":"+data+"}";
        return countData;
    }
}
