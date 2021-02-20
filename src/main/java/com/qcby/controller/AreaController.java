package com.qcby.controller;

import com.qcby.entity.Area;
import com.qcby.service.AreaService;
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
@RequestMapping("area")
public class AreaController {
    @Autowired
    private AreaService areaService;
@RequestMapping(value = "selectall")
@ResponseBody
    public String selectall(HttpServletRequest request) throws Exception{

    String pageString = request.getParameter("page");
    String limitString = request.getParameter("limit");
    Integer page = Integer.valueOf(pageString);
    Integer limit = Integer.valueOf(limitString);
    String[]column = {"id","areaLightStatus","areaPrice_hour","areaPrice_month","areaStatus","deleteStatus"};
    List<Area> areaDate = areaService.selectall(page,limit);
    String data = ObjtoLayJson.ListtoJson(areaDate,column);
    return data;
}
    @RequestMapping("insert")
    @ResponseBody
    public String insert(HttpServletRequest request, Area area) {
        areaService.insert(area);
        String data = "{\"data\":\"成功了\"}";
        System.out.println(data);
        return data;
    }
    @ResponseBody
    @RequestMapping(value="deleteById")
    public String deleteById(HttpServletRequest request,Area area) {

        areaService.deleteById(area.getId());
        String data = "{\"data\":\"删除成功\"}";
        System.out.println(data);
        return data;
    }
    @ResponseBody
    @RequestMapping(value="updateByPrimaryKey")
    public String updateByPrimaryKey(HttpServletRequest request,Area area) {
        areaService.updateByPrimaryKey(area);
        String data = "{\"data\":\"更新成功\"}";
        System.out.println(data);
        return data;
    }

    @RequestMapping("index")
    public String index(Model model, HttpServletRequest request) {
        model.addAttribute("name", "张三");
        return "Area";
    }
    @ResponseBody
    @RequestMapping(value = "selectCount", method = RequestMethod.GET, produces = "text/json;charset=utf-8")
    public String SelectCount(HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("utf-8");
        int count = areaService.selectCount();
        String data = String.valueOf(count);
        String countData= "{"+"\"count\":"+data+"}";
        return countData;
    }
}
