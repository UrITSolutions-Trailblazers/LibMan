package com.uritsolutions.libman.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.uritsolutions.libman.dao.BookDao;
import com.uritsolutions.libman.dao.CategoryDao;
import com.uritsolutions.libman.dao.UserDao;
import com.uritsolutions.libman.excelToDb.ExcelToDbService;
import com.uritsolutions.libman.pojos.Book;
import com.uritsolutions.libman.pojos.BookDetail;
import com.uritsolutions.libman.pojos.Category;
import com.uritsolutions.libman.pojos.Response;
import com.uritsolutions.libman.pojos.Type;
import com.uritsolutions.libman.pojos.User;

@RequestMapping("/admin")
@Controller
public class AdminController {

	@Autowired
	CategoryDao categoryDao;

	@Autowired
	BookDao bookDao;

	@Autowired
	UserDao userDao;
	
	@Autowired
	Response response;

	@ModelAttribute("user")
	public User createUserModel() {
		return new User();
	}
	
	@ModelAttribute("reader")
	public User createReaderModel() {
		return new User();
	}

	@ModelAttribute("book")
	public Book createBookModel() {
		return new Book();
	}

	@ModelAttribute("updateBook")
	public Book createUpdateBookModel() {
		return new Book();
	}
	
	@ModelAttribute("categoryBean")
	public Category createCategoryModel() {
		return new Category();
	}

	@ModelAttribute("bookDetail")
	public BookDetail createBookDetailModel() {
		BookDetail bookDetail = new BookDetail();
		bookDetail.setBookNumber(bookDao.getLastBookNumber());
		return bookDetail;
	}
	
	@ModelAttribute("bookNumber")
	public String setBookNumber() {
		
		return bookDao.getLastBookNumber();
	}
	
	@ModelAttribute("type")
	public Type createTypeModel() {
		return new Type();
	}
	
	@ModelAttribute("response")
	public Response responseModel() {
		return response;
	}
	
	@RequestMapping("/addReader")
	public String addReader(@RequestParam(required=false) boolean res,Model model) {
		
		if(res) {
			model.addAttribute("response", response);
		}else {
			response.setCode(0);
		}
		
		Date returnDate = new Date();
		returnDate.setDate(new Date().getDate()+7);
		model.addAttribute("returnDate",returnDate);
		
		model.addAttribute("types", userDao.getAllTypes());
		return "readers";
	}

	@RequestMapping("/addBook")
	public String addBook(Model model) {

		List<Category> categories = categoryDao.getAllCtegory();
		
		model.addAttribute("categories", categories);
	
		return "books";
	}

	@RequestMapping(value = "/addNewCategory", method = RequestMethod.POST)
	public String saveCategory(@ModelAttribute("categoryBean") Category category) {

		categoryDao.addCategory(category);
		return "redirect:/admin/addBook";
	}

	@RequestMapping(value = "/addNewBook", method = RequestMethod.POST)
	public String saveBook(@ModelAttribute("bookDetail") BookDetail bookDetail, BindingResult result) {

		Book book = bookDetail.getBook();
		
		bookDao.addBook(book);
		
		bookDetail.setBook(book);

		bookDetail = bookDao.addBookDetail(bookDetail);
//		bookDetail.setBookNumber(bookDetail.getId() + "");

		System.out.println("Updating bookdetail -> " + bookDetail.getId());

		bookDao.updateBookDetail(bookDetail);
		
		return "redirect:/admin/addBook";
	}

	@RequestMapping(value = "/saveReader", method = RequestMethod.POST)
	public String saveReader(@ModelAttribute User user, BindingResult result, Model model) {

		try {
			System.out.println("Saving reader with ID -> "+user.getId());
		} catch (Exception e) {
			System.out.println("Saving reader with Name -> "+user.getFirstName());
		}
		response = userDao.saveUser(user);
		
		return "redirect:/admin/addReader";
	}
	
	@RequestMapping(value="/saveReaderType", method = RequestMethod.POST)
	public String saveTypeOfReader(@ModelAttribute Type type, BindingResult result, Model model) {
		
		userDao.saveType(type);
		
		return "redirect:/admin/addReader";
	}
	
	@RequestMapping("/getBookById/{id}")
	public String returnBookById(@PathVariable int id,Model model) {
		response.setCode(0);
		model.addAttribute("response", response);
		Book book = bookDao.getBookById(id);
		model.addAttribute("updateBook", book);
		model.addAttribute("categories", categoryDao.getAllCtegory());
		return "books";
	}
	
	@RequestMapping("/delete/book/{id}")
	public String deleteBookById(@PathVariable int id,Model model) {
		
		Book book = bookDao.getBookById(id);
		List<BookDetail> bookDetails = bookDao.getBookDetailsByBookId(id);
		for (BookDetail bookDetail : bookDetails) {
			bookDao.deleteBookDetail(bookDetail);
		}
		bookDao.deleteBook(book);
		
		return "redirect:/admin/addBook";
	}
	
	@RequestMapping("/getReaderById/{id}")
	public String getReaderById(@PathVariable("id")int id , Model model) {
		
		response.setCode(0);
		model.addAttribute("response", response);
		
		model.addAttribute("reader", userDao.getUserById(id));
		Date returnDate = new Date();
		returnDate.setDate(new Date().getDate()+7);
		model.addAttribute("returnDate",returnDate);
		
		model.addAttribute("types", userDao.getAllTypes());
		return "readers";
		
	}
	
	@RequestMapping(value = "/updateReader", method = RequestMethod.POST)
	public String updateReader(@ModelAttribute User reader, BindingResult result, Model model) {

		try {
			System.out.println("Saving reader with ID -> "+reader.getId());
			System.out.println("Saving reader with Name -> "+reader.getFirstName());
		} catch (Exception e) {
			System.out.println("Saving reader with Name -> "+reader.getFirstName());
		}
		response = userDao.updateUser(reader);
		
		return "redirect:/admin/addReader";
	}
	
	@RequestMapping(value = "/deleteReader/{id}")
	public String deleteReader(@PathVariable int id, Model model) {

		if(!(bookDao.getBookDetailsByUserId(id)).isEmpty()) {
			response.setCode(200);
			response.setMessage("Opps books are pending with the Reader.");
			return "redirect:/admin/addReader?res=true";
		}
		
		User user = new User();
		user.setId(id);
		userDao.deleteUser(user);
		
		response.setCode(200);
		response.setMessage("Reader deleted.");
		return "redirect:/admin/addReader?res=true";
	}
	
	@RequestMapping(value = "/update/book", method = RequestMethod.POST)
	public String updateBook(@ModelAttribute("updateBook") Book updateBook, BindingResult result) {
		
		System.out.println("Updating book -> "+updateBook.getId()+" "+updateBook.getTitle()+" "+updateBook.getPrice());
		bookDao.updateBook(updateBook);
		
		return "redirect:/admin/addBook";
	}

}
