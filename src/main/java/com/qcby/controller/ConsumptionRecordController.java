package com.qcby.controller;


import com.qcby.entity.ConsumptionRecord;
import com.qcby.service.ConsumptionRecordService;
import com.qcby.util.ObjtoLayJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("consumptionRecord")
public class ConsumptionRecordController {
    @Autowired
    private ConsumptionRecordService consumptionRecordService;

    @RequestMapping("findUserConsumptionRecord")
    @ResponseBody
    public String findUserConsumptionRecord(HttpServletRequest request,ConsumptionRecord consumptionRecord) throws Exception {
        String pageString = request.getParameter("page");
        String limitString = request.getParameter("limit");
        Integer page = Integer.valueOf(pageString);
        Integer limit = Integer.valueOf(limitString);
        List<ConsumptionRecord> consumptionRecordDate =consumptionRecordService.findUserConsumptionRecord(consumptionRecord,page,limit);
        String[]column = {"id","userName","consumption","consumption_time","consumption_detail"};
        String data = ObjtoLayJson.ListtoJson(consumptionRecordDate,column);
        return data;
    }
    @ResponseBody
    @RequestMapping(value = "selectCount", method = RequestMethod.GET, produces = "text/json;charset=utf-8")
    public String SelectCount(HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("utf-8");
        int count = consumptionRecordService.selectCount();
        String data = String.valueOf(count);
        String countData= "{"+"\"count\":"+data+"}";
        return countData;
    }
}
