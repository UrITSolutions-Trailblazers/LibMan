package com.uritsolutions.libman.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.uritsolutions.libman.dao.BookDao;
import com.uritsolutions.libman.dao.UserDao;
import com.uritsolutions.libman.pojos.Book;
import com.uritsolutions.libman.pojos.BookDetail;
import com.uritsolutions.libman.pojos.Response;
import com.uritsolutions.libman.pojos.User;

@RequestMapping("/admin")
@RestController
public class DataControllet {

	@Autowired
	BookDao bookDao;
	
	@Autowired
	UserDao userDao;
	
	@ResponseBody
	@RequestMapping("/getBookData")
	public ResponseEntity<List<Book>> sendAllBooks(){
		
		return new ResponseEntity<List<Book>>(bookDao.getAllBooks(), HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping("/getUserByBookNumber/{id}")
	public ResponseEntity<BookDetail> getBookById(@PathVariable int id){
		
		return new ResponseEntity<BookDetail>(bookDao.getBookDetailByBookNumber(id), HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping("/getBookDetailsData")
	public ResponseEntity<List<BookDetail>> sendAllBooksDetails(){
		
		return new ResponseEntity<List<BookDetail>>(bookDao.getAllBookDetails(), HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping("/addBookToShelf/{bookId}")
	public ResponseEntity<BookDetail> saveBookToShelf(@PathVariable int bookId){
		Book book = bookDao.getBookById(bookId);
		System.out.println("My Debug: Got book to add to shelf -> "+book.getTitle());
		
		BookDetail bookDetail = new BookDetail();
		bookDetail.setBook(book);
		
		bookDetail = bookDao.addBookDetail(bookDetail);
		
		bookDetail.setBookNumber(""+bookDetail.getId());
		bookDao.updateBookDetail(bookDetail);
		
		System.out.println("Bookdetail persisted -> " + bookDetail.getId());

		return new ResponseEntity<BookDetail>(bookDetail, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping("/getAllUsers")
	public ResponseEntity<List<User>> getAllUsers() {
		
		return new ResponseEntity<List<User>>(userDao.getAllUsers(),HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping("/issue/book/{bookNumber}/{returnDate}/{readerId}")
	public ResponseEntity<BookDetail> issueBook(@PathVariable int bookNumber, @PathVariable String returnDate, @PathVariable String readerId ) throws ParseException{
		
		System.out.println("Controller");
		BookDetail bookDetail = bookDao.getBookDetailById(bookNumber);
		System.out.println("Book details recieved");
		User user = userDao.getUser(readerId.toUpperCase());
		System.out.println("User recieved -> " + user.getFirstName());
		user.setEnabled(true);
		user.setBookCount(user.getBookCount() + 1);
		bookDetail.setUser(user);
		bookDetail.setIssueDate(new Date());
		
		Date rDate = new SimpleDateFormat("dd MMMM, yyyy").parse(returnDate);
		
		bookDetail.setReturnDate(rDate);
		bookDetail.setStatus(true);
		
		bookDao.updateBookDetail(bookDetail);
		
		System.out.println("Return Date : " + rDate);
		
		return new ResponseEntity<BookDetail>(bookDetail,HttpStatus.OK);
		
	}
	
	@ResponseBody
	@RequestMapping("/getBooksFromShelf/{id}")
	public ResponseEntity<List<BookDetail>> getBooksFromShelf(@PathVariable int id) {
		
		List<BookDetail> bookDetails = bookDao.getBookDetailsByBookId(id);
		for(BookDetail book : bookDetails) {
			System.out.println("Book : "+ book.getBook().getTitle());
		}
		
		return new ResponseEntity<List<BookDetail>>(bookDetails,HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping("/getBooksForUser/{id}")
	public ResponseEntity<List<BookDetail>> getBooksForUser(@PathVariable int id) {
		
		List<BookDetail> bookDetails = bookDao.getBookDetailsByUserId(id);
		for(BookDetail book : bookDetails) {
			System.out.println("Book : "+ book.getBook().getTitle());
		}
		
		return new ResponseEntity<List<BookDetail>>(bookDetails,HttpStatus.OK);
	}
	

	@ResponseBody
	@RequestMapping("/returnBook/{bookNumber}/{readerId}")
	public ResponseEntity<User> returnBook(@PathVariable int bookNumber,@PathVariable int readerId) {
		
		User user = userDao.getUserById(readerId);
		
		BookDetail bookDetail = bookDao.getBookDetailById(bookNumber);
		
		user.setBookCount(user.getBookCount() - 1);
		if(user.getBookCount() == 0) {
			
			user.setEnabled(false);
		}
		userDao.updateUser(user);
		
		bookDetail.setUser(null);
		bookDetail.setIssueDate(null);
		bookDetail.setReturnDate(null);
		bookDetail.setStatus(false);
		bookDao.updateBookDetail(bookDetail);
		
		return new ResponseEntity<User>(user,HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping("/delete/bookDetail/{id}")
	public ResponseEntity<Response> delteBookDetail(@PathVariable int id) {
			
		Response response = new Response();
		BookDetail bookDetail = bookDao.getBookDetailById(id);
		if(bookDetail.isStatus()) {
			response.setMessage("Cannot delete, the book is issued.");
			return new ResponseEntity<Response>(response,HttpStatus.OK);
		}
		
		bookDao.deleteBookDetail(bookDetail);
		response.setMessage("Book was successfully deleted.");
		return new ResponseEntity<Response>(response,HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping("/getBookTitles/for/autocomplete")
	public ResponseEntity<List<BookAuto>> getBookTitlesForAutoComp() {
		
		List<String> titles = bookDao.getBookTitles();
		List<BookAuto> bookAutos = new ArrayList<>();
		BookAuto title = new BookAuto();
		for (String auto : titles) {
			title = new BookAuto();
			title.title = auto;
			bookAutos.add(title);
		}
		if (!titles.isEmpty()) {
			return new ResponseEntity<List<BookAuto>>(bookAutos,HttpStatus.OK);
		} else {
			return new ResponseEntity<List<BookAuto>>(HttpStatus.NOT_FOUND);
		}
		
	}
}

class BookAuto{
	public String title;
	public String Null = null; 
}
