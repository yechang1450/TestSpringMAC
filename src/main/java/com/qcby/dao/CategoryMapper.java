package com.qcby.dao;

import com.qcby.entity.Category;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CategoryMapper {

    List<Category> findCategoryList(@Param("category") Category category, @Param("pageIndex") int pageIndex, @Param("pageSize") int pageSize);

    Integer deleteCategoryById(long id);

    Integer addCategory(Category category);

    Integer updateCategory(Category category);

    int selectCount();

    int updateCategoryStatus(Category category);
}