package com.qcby.controller;

import com.qcby.entity.Wallet;
import com.qcby.service.WalletService;

import com.qcby.util.ObjtoLayJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("wallet")
public class WalletController {
    @Autowired
    private WalletService walletService;

    @RequestMapping("findUserCharge")
    @ResponseBody
    public String findUserCharge(HttpServletRequest request,Wallet wallet) throws Exception {
        String pageString = request.getParameter("page");
        String limitString = request.getParameter("limit");
        Integer page = Integer.valueOf(pageString);
        Integer limit = Integer.valueOf(limitString);
        List<Wallet> walletData = walletService.findUserCharge(wallet,page,limit);
        String[]column = {"id","userName","charge"};
        String data = ObjtoLayJson.ListtoJson(walletData,column);
        return data;
    }
    @RequestMapping("updateCharge")
    @ResponseBody
    public String addCharge(HttpServletRequest request,Wallet wallet){
        System.out.println(wallet);
        walletService.updateCharge(wallet);
        String data = "{\"data\":\"成功了\"}";
        System.out.println(data);
        return data;
    }
    @RequestMapping("deleteId")
    @ResponseBody
    public String deleteId(HttpServletRequest request,Wallet wallet){
        System.out.println(wallet);
        walletService.deleteId(wallet);
        String data = "{\"data\":\"成功了\"}";
        System.out.println(data);
        return data;
    }
    @ResponseBody
    @RequestMapping(value = "selectCount", method = RequestMethod.GET, produces = "text/json;charset=utf-8")
    public String SelectCount(HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("utf-8");
        int count = walletService.selectCount();
        String data = String.valueOf(count);
        String countData= "{"+"\"count\":"+data+"}";
        return countData;
    }
}
