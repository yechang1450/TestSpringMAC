package com.qcby.service.Impl;

import com.qcby.dao.CategoryMapper;
import com.qcby.entity.Category;
import com.qcby.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service

public class CategoryServiceImpl implements CategoryService {
    @Autowired
    private CategoryMapper categoryMapper;
    @Override
    public List<Category> findCategoryList(Category category,int page,int limit) {
        int pageIndex = (page-1) * limit;
        int pageSize = limit;
        return categoryMapper.findCategoryList(category,pageIndex,pageSize);
    }

    @Override
    public Integer deleteCategoryById(long id) {
        return categoryMapper.deleteCategoryById(id);
    }

    @Override
    public Integer addCategory(Category category) {
        return categoryMapper.addCategory(category);
    }

    @Override
    public Integer updateCategory(Category category) {
        return categoryMapper.updateCategory(category);
    }

    @Override
    public int selectCount() {
        return categoryMapper.selectCount();
    }

    @Override
    public int updateCategoryStatus(Category category) {
        return this.categoryMapper.updateCategoryStatus(category);
    }


}
