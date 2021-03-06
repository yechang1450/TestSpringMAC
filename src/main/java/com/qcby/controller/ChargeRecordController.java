package com.qcby.controller;

import com.qcby.entity.ChargeRecord;
import com.qcby.service.ChargeRecordService;
import com.qcby.util.ObjtoLayJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("chargeRecord")
public class ChargeRecordController {
    @Autowired
    private ChargeRecordService chargeRecordService;
    @RequestMapping("findUserRecord")
    @ResponseBody
    public String findUserRecord(HttpServletRequest request,ChargeRecord chargeRecord) throws Exception {
        String pageString = request.getParameter("page");
        String limitString = request.getParameter("limit");
        Integer page = Integer.valueOf(pageString);
        Integer limit = Integer.valueOf(limitString);
        List<ChargeRecord> chargeRecordDate =chargeRecordService.findUserRecord(chargeRecord,page,limit);
        String[]column = {"id","userName","amount","amount_time"};
        String data = ObjtoLayJson.ListtoJson(chargeRecordDate,column);
        return data;
    }
    @ResponseBody
    @RequestMapping(value = "selectCount", method = RequestMethod.GET, produces = "text/json;charset=utf-8")
    public String SelectCount(HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("utf-8");
        int count = chargeRecordService.selectCount();
        String data = String.valueOf(count);
        String countData= "{"+"\"count\":"+data+"}";
        return countData;
    }
}
