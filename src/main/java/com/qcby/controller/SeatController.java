package com.qcby.controller;

import com.qcby.entity.Seat;
import com.qcby.service.SeatService;
import com.qcby.util.ObjtoLayJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("seat")
public class SeatController {
    @Autowired
    private SeatService seatService;

    @RequestMapping("findSeatList")
    @ResponseBody
    public String findSeatList(HttpServletRequest request,Seat seat) throws Exception{
        String pageString = request.getParameter("page");
        String limitString = request.getParameter("limit");
        Integer page = Integer.valueOf(pageString);
        Integer limit = Integer.valueOf(limitString);
        List<Seat>seatData = seatService.findSeatList(seat,page,limit);
        String[]column = {"id","seatLightStatus","areaId","vipStatus","state"};
        String data = ObjtoLayJson.ListtoJson(seatData,column);
        return data;
    }
    @RequestMapping("insert")
    @ResponseBody
    public String addSeat(HttpServletRequest request,Seat seat) {
        seatService.insert(seat);
        String data = "{\"data\":\"成功了\"}";
        System.out.println(data);
        return data;
    }
    @ResponseBody
    @RequestMapping(value="deleteById")
    public String deleteById(HttpServletRequest request,Seat seat) {

        seatService.deleteById(seat.getId());
        String data = "{\"data\":\"删除成功\"}";
        System.out.println(data);
        return data;
    }
    @ResponseBody
    @RequestMapping(value="updateByPrimaryKey")
    public String update(HttpServletRequest request,Seat seat) {
        seatService.updateByPrimaryKey(seat);
        String data = "{\"data\":\"更新成功\"}";
        System.out.println(data);
        return data;
    }
    @ResponseBody
    @RequestMapping(value="updateSeatLightStatus")
    public String updateSeatLightStatus(Seat seat) {
        if(seat.getSeatLightStatus()==true){
            seat.setSeatLightStatus(false);
        }else if(seat.getSeatLightStatus()==false){
            seat.setSeatLightStatus(true);
        }
        seatService.updateSeatLightStatus(seat);
        return null;
    }
    @ResponseBody
    @RequestMapping(value = "selectCount", method = RequestMethod.GET, produces = "text/json;charset=utf-8")
    public String SelectCount(HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("utf-8");
        int count = seatService.selectCount();
        String data = String.valueOf(count);
        String countData= "{"+"\"count\":"+data+"}";
        return countData;
    }
}
