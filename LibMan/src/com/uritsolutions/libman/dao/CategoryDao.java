package com.uritsolutions.libman.dao;

import java.util.List;

import com.uritsolutions.libman.pojos.Category;

public interface CategoryDao {

	
	public boolean addCategory(Category category);
	public Category persistCategory(Category category);
	public boolean updateCategory(Category category);
	public Category getCategoryById(int id);
	public boolean deleteCategory(Category category);
	public List<Category> getAllCtegory();
}
