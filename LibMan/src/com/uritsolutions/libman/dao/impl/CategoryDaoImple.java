package com.uritsolutions.libman.dao.impl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.uritsolutions.libman.dao.CategoryDao;
import com.uritsolutions.libman.pojos.Category;

@Transactional
@Repository("categoryDao")
public class CategoryDaoImple implements CategoryDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public boolean addCategory(Category category) {
		try {
			sessionFactory.getCurrentSession().save(category);
			return true;

		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}
	}

	@Override
	public boolean updateCategory(Category category) {
		try {
			sessionFactory.getCurrentSession().update(category);
			return true;

		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}
	}

	@Override
	public Category getCategoryById(int id) {
		try {
			return sessionFactory.getCurrentSession().get(Category.class, id);

		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
	}

	@Override
	public boolean deleteCategory(Category category) {
		try {
			sessionFactory.getCurrentSession().delete(category);
			return true;

		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}
	}

	@Override
	public List<Category> getAllCtegory() {
		try {
			return sessionFactory.getCurrentSession().createQuery("FROM Category", Category.class).list();

		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
	}

	@Override
	public Category persistCategory(Category category) {
		try {
			sessionFactory.getCurrentSession().persist(category);
			return category;

		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
	}

}
