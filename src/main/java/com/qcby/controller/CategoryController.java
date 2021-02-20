package com.qcby.controller;

import com.qcby.entity.Category;
import com.qcby.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.qcby.util.ObjtoLayJson;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @RequestMapping("")
    public String index1() {
        return "category";
    }

    @RequestMapping(value="findCategoryList",produces = "text/json;charset=utf-8")
    @ResponseBody
    public String findCategoryList(HttpServletRequest request,Category category) throws Exception {
        String pageString = request.getParameter("page");
        String limitString = request.getParameter("limit");
        Integer page = Integer.valueOf(pageString);
        Integer limit = Integer.valueOf(limitString);
        List<Category> categoryData = categoryService.findCategoryList(category,page,limit);
        String[] column = {"id","categoryName", "categoryStatus"};
        String data=ObjtoLayJson.ListtoJson(categoryData,column);
        System.out.println(data);
        return data;
    }
    @RequestMapping("deleteCategoryById")
    @ResponseBody
    public String deleteCategoryById(Category category) {
       categoryService.deleteCategoryById(category.getId());
        String data = "{\"data\":\"删除成功\"}";
        System.out.println(data);
        return data;
    }
    @RequestMapping("addCategory")
    @ResponseBody
    public String addCategory(Category category) {
        System.out.println(category);
        categoryService.addCategory(category);
        String data = "{\"data\":\"成功了\"}";
        System.out.println(data);
        return data;
    }
    @RequestMapping("updateCategory")
    @ResponseBody
    public String updateCategory(Category category) {
        System.out.println(category);
        categoryService.updateCategory(category);
        String data = "{\"data\":\"成功了\"}";
        System.out.println(data);
        return data;
    }
    @RequestMapping(value = "updateCategoryStatus", method = RequestMethod.GET)
    @ResponseBody
    public String updateCategoryStatus(Category category) {
        categoryService.updateCategoryStatus(category);
        return null;
    }
    @ResponseBody
    @RequestMapping(value = "selectCount", method = RequestMethod.GET, produces = "text/json;charset=utf-8")
    public String SelectCount(HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("utf-8");
        int count = categoryService.selectCount();
        String data = String.valueOf(count);
        String countData= "{"+"\"count\":"+data+"}";
        return countData;
    }
}
