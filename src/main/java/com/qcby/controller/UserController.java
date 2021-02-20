package com.qcby.controller;

import javax.servlet.http.HttpServletRequest;

import com.qcby.entity.User;
import com.qcby.service.UserService;
import com.qcby.util.ObjtoLayJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    private UserService userService;

    @ResponseBody
    @RequestMapping(value = "selectAll", method = RequestMethod.GET, produces = "text/json;charset=utf-8")
    public String selectAll(HttpServletRequest request,User user) throws Exception {
        request.setCharacterEncoding("utf-8");
        String pageString = request.getParameter("page");
        String limitString = request.getParameter("limit");
        Integer page = Integer.valueOf(pageString);
        Integer limit = Integer.valueOf(limitString);
        List<User> userData = userService.selectAll(user,page,limit);
        String[] column = {"id", "userName", "userPhone", "userStatus", "seatName", "accStatus", "balance"};
        String data = ObjtoLayJson.ListtoJson(userData, column);
//        System.out.println(data);
        return data;
    }
    @ResponseBody
    @RequestMapping(value="deleteById",method = RequestMethod.GET,produces = "text/json;charset=utf-8")
    public String deleteById(User user) {
        userService.deleteById(user.getId());
        String data = "{\"data\":\"删除成功\"}";
//        System.out.println(data);
        return data;
    }
    @ResponseBody
    @RequestMapping(value="insert",method = RequestMethod.GET,produces = "text/json;charset=utf-8")
    public String insert(User user) {
        userService.insert(user);
        String data = "{\"data\":\"添加成功\"}";
//        System.out.println(data);
        return data;
    }
    @ResponseBody
    @RequestMapping(value="update",method = RequestMethod.GET,produces = "text/json;charset=utf-8")
    public String update(User user) {
        userService.update(user);
        String data = "{\"data\":\"更新成功\"}";
//        System.out.println(data);
        return data;
    }
    @ResponseBody
    @RequestMapping(value="updateUserStatus",method = RequestMethod.GET,produces = "text/json;charset=utf-8")
    public String updateStatus(User user) {
        userService.updateUserStatus(user);
        String data = "{\"data\":\"更新成功\"}";
//        System.out.println(data);
        return data;
    }
    @ResponseBody
    @RequestMapping(value="updateAccStatus",method = RequestMethod.GET,produces = "text/json;charset=utf-8")
    public String updateAccStatus(User user) {
        if(user.getAccStatus()==false){
            user.setAccStatus(true);
        }else if(user.getAccStatus()==true){
            user.setAccStatus(false);
        }
        userService.updateAccStatus(user);
        String data = "{\"data\":\"更新成功\"}";
//        System.out.println(data);
        return data;
    }
    @ResponseBody
    @RequestMapping(value = "selectCount", method = RequestMethod.GET, produces = "text/json;charset=utf-8")
    public String SelectCount(HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("utf-8");
        int count = userService.selectCount();
        String data = String.valueOf(count);
        String countData= "{"+"\"count\":"+data+"}";
        return countData;
    }
}