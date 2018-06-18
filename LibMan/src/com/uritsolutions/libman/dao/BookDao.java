package com.uritsolutions.libman.dao;

import java.util.List;

import com.uritsolutions.libman.pojos.Book;
import com.uritsolutions.libman.pojos.BookDetail;
import com.uritsolutions.libman.pojos.Category;

public interface BookDao {

	public boolean addBook(Book book);
	public boolean addBookFromExel(Book book);
	public boolean persistBook(Book book,BookDetail bookDetail);
	public boolean updateBook(Book book);
	public boolean deleteBook(Book book);
	public List<Book> getAllBooks();
	public Book getBookById(int id);
	
	public BookDetail addBookDetail(BookDetail bookDetail);
	public boolean updateBookDetail(BookDetail bookDetail);
	public boolean deleteBookDetail(BookDetail bookDetail);
	public List<BookDetail> getAllBookDetails();
	public List<BookDetail> getBookDetailByCategory(Category category);
	public BookDetail getBookDetailByBookNumber(int bookNumber);
	public BookDetail getBookDetailById(int id);
	public List<BookDetail> getBookDetailsByBookId(int id);
	public List<BookDetail> getBookDetailsByUserId(int id);
	public List<String> getBookTitles();
	public String getLastBookNumber();
}
