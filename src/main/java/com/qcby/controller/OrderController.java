package com.qcby.controller;


import com.qcby.entity.Order;
import com.qcby.service.OrderService;
import com.qcby.util.ObjtoLayJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @ResponseBody
    @RequestMapping(value = "updateByOrderStatus",method=RequestMethod.GET,produces = "text/json;charset=utf-8")
    public String updateByOrderStatus(Order order) {
//        if(order.getOrderStatus()=='0'){
////            order.setOrderStatus(1);
////        }else if(order.getOrderStatus()=='1'){
////            order.setOrderStatus(0);
////        }
        System.out.println(order.getOrderStatus());
        if(order.getOrderStatus().equals("true")) {
            order.setOrderStatus("已送达");
        }
        else if(order.getOrderStatus().equals("false")){
            order.setOrderStatus("未送达");
        }
         orderService.updateByOrderStatus(order);
        String data="{\"data\":\"更新成功\"}";
        return data;
    }
//思路:前台如何自动更新?
//    自动更新总价(){
//        a=查单价;   假设所有单价都是10块!!!!
//        b=查数量;
//        c=a*b;
//        根据总价更新(c);
//    }
//@ResponseBody
//@RequestMapping(value="updatetotleMoney",produces = "text/json;charset=utf-8")
//public int updatetotleMoney(HttpServletRequest request, Order order) throws Exception {
//    request.setCharacterEncoding("utf-8");
//
//    Integer number=Integer.valueOf(order.getNumber());
//    number = number *10;
//    String num=String.valueOf(number);
//
//
//    selectOrderList( order.getNumber())
//
//    order.setTotleMoney(num);
//    orderService.updatetotleMoney(order);
//
//    order.setTotleMoney(order.getNumber()*10);
//    orderService.selectOrderList(order.getNumber());  //查数量
//    orderService.updatetotleMoney(order);
//    String data = "{\"data\":\"更新成功\"}";
//    System.out.println(data);
//    return data;
//}
    @ResponseBody
    @RequestMapping(value = "/selectOrderList", produces = "text/json;charset=utf-8")
    public String  selectOrderList(HttpServletRequest request,Order order) throws Exception {
        String pageString = request.getParameter("page");
        String limitString = request.getParameter("limit");
        Integer page = Integer.valueOf(pageString);
        Integer limit = Integer.valueOf(limitString);
        System.out.println(order.getUserId());
        List<Order> orderData=orderService.selectOrderList(order,page,limit);
//        System.out.println(request.getParameter("number"));
//        List<Order> orderData = orderService.selectOrderList();
        String[] column = {"id", "userId", "seatId", "goods", "number", "totleMoney", "orderStatus","orderTime"};
        String data = ObjtoLayJson.ListtoJson(orderData, column);
        //System.out.println(data);
        return data;
    }
        @ResponseBody
        @RequestMapping(value = "/selcetbyId")
        public String selectbyId(HttpServletRequest request,Order order) throws Exception {
            String orderData=orderService.selectbyId(order.getId());
            String data = "[{\"status\":0}, {\"message\": \"成功\" }, {\"count\": 1000},"
                    + "{\"rows\":{\"item\":[{\"goods\": \""+orderData+"\"} ]}}]";
//            String[] column = {"id","categoryId", "goodsId","goodsName","goodsPrice","goodsStock","goodsStatus","describe","deleteStatus"};
//            String data= ObjtoLayJson.ListtoJson(orderData,column);
            return data;
        }
    @ResponseBody
    @RequestMapping(value = "/insert", produces = "text/json;charset=utf-8")
    public String insert(Order order){
        orderService.insert(order);
        String data = "{\"data\":\"添加成功\"}";
        System.out.println(data);
        return data;
    }
    @ResponseBody
    @RequestMapping(value="deleteById",produces = "text/json;charset=utf-8")
    public String deleteById(Order order) {
        orderService.deleteById(order.getId());
        return null;
    }
    @ResponseBody
    @RequestMapping(value="update",produces = "text/json;charset=utf-8")
    public String update(HttpServletRequest request, Order order) throws Exception {
        request.setCharacterEncoding("utf-8");
        orderService.update(order);
        String data = "{\"data\":\"更新成功\"}";
        System.out.println(data);
        return data;
    }
    @ResponseBody
    @RequestMapping(value = "selectCount", method = RequestMethod.GET, produces = "text/json;charset=utf-8")
    public String SelectCount(HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("utf-8");
        int count = orderService.selectCount();
        String data = String.valueOf(count);
        String countData= "{"+"\"count\":"+data+"}";
        return countData;
    }
//    @ResponseBody
//    @RequestMapping(value="update",produces = "text/json;charset=utf-8")
//    public String update(User user) {
//        userService.update(user);
////        String data = "{\"data\":\"更新成功\"}";
////        System.out.println(data);
//        return null;
//    }
//    List<User> userData = userService.selectAll(page,limit);
//    String[] column = {"id", "userName", "userPhone", "userStatus", "seatName", "accStatus", "balance"};
//    String data = ObjtoLayJson.ListtoJson(userData, column);
}
