package com.uritsolutions.libman.dao.impl;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.NoResultException;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.uritsolutions.libman.dao.BookDao;
import com.uritsolutions.libman.pojos.Book;
import com.uritsolutions.libman.pojos.BookDetail;
import com.uritsolutions.libman.pojos.Category;
import com.uritsolutions.libman.pojos.User;

@Repository("bookDao")
@Transactional
public class BookDaoImpl implements BookDao {

	@Autowired
	private SessionFactory sessionFactory;

	/*
	 * static Logger logger = Logger.getLogger("MyLog"); static FileHandler fh =
	 * null;
	 * 
	 * public static void loggerInit() { try { fh = new
	 * FileHandler("C:/LibMan/Log/BookLog.log"); logger.addHandler(fh);
	 * SimpleFormatter formatter = new SimpleFormatter();
	 * fh.setFormatter(formatter); logger.info("Write to DB from ecxel started.");
	 * System.out.println("Write to DB from ecxel started.");
	 * 
	 * } catch (SecurityException | IOException e1) { // TODO Auto-generated catch
	 * block e1.printStackTrace(); } }
	 */

	@Override
	public boolean addBook(Book book) {

		try {
			System.out.println("Saving book...");
			Session session = sessionFactory.openSession();
			Transaction transaction = (Transaction) session.beginTransaction();
			sessionFactory.getCurrentSession().persist(book);
			transaction.commit();
			session.close();

			System.out.println("Book saved -> " + book.getId());
			return true;

		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}
	}

	@Override
	public boolean updateBook(Book book) {

		try {
			Session session = sessionFactory.openSession();
			Transaction transaction = (Transaction) session.beginTransaction();
			session.update(book);
			transaction.commit();
			session.close();
			return true;

		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}

	}

	@Override
	public boolean deleteBook(Book book) {

		try {
			Session session = sessionFactory.openSession();
			Transaction transaction = (Transaction) session.beginTransaction();
			session.delete(book);
			transaction.commit();
			session.close();
			return true;

		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}

	}

	@Override
	public List<Book> getAllBooks() {
		Session session = sessionFactory.openSession();
		Transaction transaction = (Transaction) session.beginTransaction();
		List<Book> books = session.createQuery("FROM Book", Book.class).list();
		transaction.commit();
		session.close();
		return books;
	}

	@Override
	public Book getBookById(int id) {
		Session session = sessionFactory.openSession();
		Transaction transaction = (Transaction) session.beginTransaction();
		Book book = session.createQuery("FROM Book WHERE id = :id", Book.class).setParameter("id", id)
				.getSingleResult();
		transaction.commit();
		session.close();
		return book;

	}

	@Override
	public BookDetail addBookDetail(BookDetail bookDetail) {
		try {
			System.out.println("Saving bookdetail...");
			Session session = sessionFactory.openSession();
			Transaction transaction = (Transaction) session.beginTransaction();
			session.persist(bookDetail);
			System.out.println("Bookdetail persisted -> " + bookDetail.getId());
			transaction.commit();
			session.close();
			return bookDetail;

		} catch (Exception e) {
			System.out.println(e.getMessage());
			return new BookDetail();
		}
	}

	@Override
	public boolean updateBookDetail(BookDetail bookDetail) {
		try {
			System.out.println("Saving book...");
			Session session = sessionFactory.openSession();
			Transaction transaction = (Transaction) session.beginTransaction();
			session.update(bookDetail);
			transaction.commit();
			session.close();
			return true;

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean deleteBookDetail(BookDetail bookDetail) {
		try {
			System.out.println("Saving book...");
			Session session = sessionFactory.openSession();
			Transaction transaction = (Transaction) session.beginTransaction();
			session.delete(bookDetail);
			transaction.commit();
			session.close();
			return true;

		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}
	}

	@Override
	public List<BookDetail> getAllBookDetails() {
		Session session = sessionFactory.openSession();
		Transaction transaction = (Transaction) session.beginTransaction();
		List<BookDetail> bookDetails = session.createQuery("FROM BookDetail", BookDetail.class).list();
		transaction.commit();
		session.close();
		return bookDetails;
	}

	@Override
	public List<BookDetail> getBookDetailByCategory(Category category) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BookDetail getBookDetailByBookNumber(int bookNumber) {
		Session session = sessionFactory.openSession();
		Transaction transaction = (Transaction) session.beginTransaction();
		String bookNum = Integer.toString(bookNumber);
		BookDetail bookDetail = session.createQuery("FROM BookDetail WHERE bookNumber = :bn", BookDetail.class)
				.setParameter("bn", bookNum).getSingleResult();
		transaction.commit();
		session.close();
		return bookDetail;
	}

	@Override
	public List<BookDetail> getBookDetailsByBookId(int id) {

		List<BookDetail> bookDetails = null;

		try {
			Session session = sessionFactory.openSession();
			Transaction transaction = (Transaction) session.beginTransaction();
			bookDetails = session.createQuery("FROM BookDetail WHERE BOOK_ID = " + id, BookDetail.class)
					.getResultList();
			transaction.commit();
			session.close();
		} catch (Exception e) {
			bookDetails = new ArrayList<>();
		}

		return bookDetails;
	}

	@Override
	public List<BookDetail> getBookDetailsByUserId(int id) {

		List<BookDetail> bookDetails;
		try {
			Session session = sessionFactory.openSession();
			Transaction transaction = (Transaction) session.beginTransaction();
			bookDetails = session.createQuery("FROM BookDetail WHERE USER_ID = :id", BookDetail.class)
					.setParameter("id", id).getResultList();
			transaction.commit();
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
			bookDetails = new ArrayList<>();
		}

		return bookDetails;
	}

	@Override
	public boolean persistBook(Book book, BookDetail bookDetail) {
		try {
			Book temp = sessionFactory.getCurrentSession().createQuery("FROM Book WHERE title = :title", Book.class)
					.setParameter("title", book.getTitle()).getSingleResult();
			// logger.info("Book found in DB -> "+temp.getTitle());
			System.out.println("MyDebug : Book found in DB -> " + temp.getTitle());

			bookDetail.setBook(temp);
			sessionFactory.getCurrentSession().save(bookDetail);
			return false;

		} catch (NoResultException e) {
			sessionFactory.getCurrentSession().save(book);
			System.out.println(e.getMessage());
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean addBookFromExel(Book book) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<String> getBookTitles() {
		List<String> titles;
		try {
			Session session = sessionFactory.openSession();
			Transaction transaction = (Transaction) session.beginTransaction();
			titles = session.createSQLQuery("SELECT Title FROM BOOK").getResultList();
			transaction.commit();
			session.close();
		} catch (Exception e) {
			titles = new ArrayList<>();
		}

		return titles;
	}

	@Override
	public BookDetail getBookDetailById(int id) {

		BookDetail bookDetails;

		try {

			Session session = sessionFactory.openSession();
			Transaction transaction = (Transaction) session.beginTransaction();
			bookDetails = session.get(BookDetail.class, id);
			transaction.commit();
			session.close();

		} catch (Exception e) {

			e.printStackTrace();
			bookDetails = null;
		}

		return bookDetails;
	}

	@Override
	public String getLastBookNumber() {

		String lastBookNumber = null;

		try {

			Session session = sessionFactory.openSession();
			Transaction transaction = (Transaction) session.beginTransaction();
			String bookNum = ((Integer)session.createSQLQuery("SELECT MAX(CAST(BOOKNUMBER AS Int)) FROM BookDetail ").getSingleResult()).toString();
			transaction.commit();
			session.close();
			System.out.println("Last book number ---->>>>> " + bookNum);
			int num = Integer.parseInt(bookNum) + 1;
			lastBookNumber = new String(num + "");
		} catch (Exception e) {
			e.printStackTrace();
			lastBookNumber = new String("ERROR");
		}

		return lastBookNumber;
	}

}
