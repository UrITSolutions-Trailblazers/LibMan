package com.uritsolutions.libman.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.uritsolutions.libman.dao.BookDao;

@Controller
public class MainController {

	@Autowired
	BookDao bookDao;
	
	@RequestMapping(value = {"/","/index","/home"})
	public String getHomePage(Model model) {
	
		
		model.addAttribute("books", bookDao.getAllBooks());
		return "index";
	}
	
	
}
