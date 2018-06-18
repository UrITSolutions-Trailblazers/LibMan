package com.uritsolutions.libman.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.uritsolutions.libman.dao.UserDao;
import com.uritsolutions.libman.pojos.User;

@RequestMapping("/admin")
@Controller
public class UserController {

	@Autowired
	UserDao userDao;
	
	

}
