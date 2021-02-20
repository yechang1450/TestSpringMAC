package com.qcby.controller;

        import com.qcby.entity.Goods;
        import com.qcby.service.GoodsService;
        import org.springframework.beans.factory.annotation.Autowired;
        import org.springframework.stereotype.Controller;
        import org.springframework.web.bind.annotation.RequestMapping;
        import org.springframework.web.bind.annotation.RequestMethod;
        import org.springframework.web.bind.annotation.ResponseBody;
        import com.qcby.util.ObjtoLayJson;

        import javax.servlet.http.HttpServletRequest;
        import java.util.List;

@Controller
@RequestMapping("goods")

public class GoodsController {

    @Autowired
    private GoodsService goodsService;

    @RequestMapping("")
    public String index1(){
        return "goods";
    }


    @RequestMapping(value="findGoodsList",produces = "text/json;charset=utf-8")
    @ResponseBody

    public String findGoodsList(HttpServletRequest request,Goods goods) throws Exception {
        String pageString = request.getParameter("page");
        String limitString = request.getParameter("limit");
        Integer page = Integer.valueOf(pageString);
        Integer limit = Integer.valueOf(limitString);


        List<Goods> goodsData=goodsService.findGoodsList(goods,page,limit);
        String[] column = {"id","categoryId", "goodsId","goodsName","goodsPrice","goodsStock","goodsStatus","describe","deleteStatus"};
        String data= ObjtoLayJson.ListtoJson(goodsData,column);
        return data;
    }

    @RequestMapping("deleteGoodsById")
    @ResponseBody
    public String deleteGoodsById(Goods goods){
        goodsService.deleteGoodsById(goods.getId());
        String data = "{\"data\":\"删除成功\"}";
        System.out.println(data);
        return data;

    }
    @RequestMapping("addGoods")
    @ResponseBody
    public String addGoods(Goods goods){
        System.out.println(goods);
        goodsService.addGoods(goods);
        String data = "{\"data\":\"成功了\"}";
        System.out.println(data);
        return data;
    }
    @RequestMapping("updateGoods")
    @ResponseBody
    public String updateGoods(Goods goods){
        System.out.println(goods);
        goodsService.updateGoods(goods);
        String data = "{\"data\":\"成功了\"}";
        System.out.println(data);
        return data;
    }
    @RequestMapping("SelectCount")
    @ResponseBody
    public String SelectCount(HttpServletRequest request) throws Exception {


        request.setCharacterEncoding("utf-8");
        int count = goodsService.selectCount();
        String data = String.valueOf(count);
        String countData= "{"+"\"count\":"+data+"}";
        return countData;
    }
    @ResponseBody
    @RequestMapping(value="updateStatus",method = RequestMethod.GET,produces = "text/json;charset=utf-8")
    public String updateStatus(Goods goods) {
        goodsService.updateStatus(goods);
        return null;
    }


}

