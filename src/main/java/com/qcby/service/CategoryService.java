package com.qcby.service;

import com.qcby.entity.Category;

import java.util.List;

public interface CategoryService {

    List<Category> findCategoryList(Category category, int page, int limit);

    Integer deleteCategoryById(long id);

    Integer addCategory(Category category);

    Integer updateCategory(Category category);

    int selectCount();

    int updateCategoryStatus(Category category);
}
