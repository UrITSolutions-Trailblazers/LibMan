package com.uritsolutions.libman.controller;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.logging.FileHandler;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.uritsolutions.ExcelToDb.ExcelToDb;
import com.uritsolutions.libman.dao.BookDao;
import com.uritsolutions.libman.dao.impl.BookDaoImpl;
import com.uritsolutions.libman.excelToDb.ExcelToDbService;
import com.uritsolutions.libman.pojos.Book;
import com.uritsolutions.libman.pojos.BookDetail;
import com.uritsolutions.libman.pojos.User;

@RequestMapping("/admin")
@Controller
public class ExcelDbBooksController {

	@Autowired
	ExcelToDb excelToDb;

	@Autowired
	BookDao bookDao;

	@ResponseBody
	@RequestMapping("/books/excel/file")
	public ResponseEntity<?> getExcelFileForBooks(MultipartHttpServletRequest request) throws IOException {
		MultipartFile data = null;
		Iterator fileIterator = request.getFileNames();
		while (fileIterator.hasNext()) {
			data = request.getFile(fileIterator.next().toString());
		}

		try {
			System.out.println("MyDebug: File-> " + data.getOriginalFilename());
		} catch (Exception e) {
			System.out.println("MyDebug: The file not uploaded");
		}
		HSSFSheet sheet = excelToDb.getDataFromExcelFile(data.getInputStream(), 0, 5);

		List<?> books = excelToDb.getData(sheet);

		Iterator iterator = books.iterator();

		int failCount = 0;
		int successCount = 0;
		while (iterator.hasNext()) {
			BookDetail bookDetail = new BookDetail();
			Book book = (Book) iterator.next();
			bookDetail.setBookNumber(""+book.getId());
			book.setId(0);
			if (!bookDao.persistBook(book,bookDetail)) {
				
				failCount++;
			} else {
				
				bookDetail.setBook(book);

				bookDetail = bookDao.addBookDetail(bookDetail);

				//System.out.println("Updating bookdetail -> " + bookDetail.getId());

				bookDao.updateBookDetail(bookDetail);
				successCount++;
			}

		}
		System.out.println("Write fail count -> "+failCount);
		System.out.println("Write success cout -> "+successCount);
		return new ResponseEntity<>(HttpStatus.OK);
	}

	@ResponseBody
	@RequestMapping("/readers/excel/file")
	public ResponseEntity<?> getExcelFileForReaders(MultipartHttpServletRequest request) throws IOException {
		MultipartFile data = null;
		Iterator fileIterator = request.getFileNames();
		while (fileIterator.hasNext()) {
			data = request.getFile(fileIterator.next().toString());
		}

		try {
			System.out.println("MyDebug: File-> " + data.getOriginalFilename());
		} catch (Exception e) {
			System.out.println("MyDebug: The file not uploaded");
		}
		HSSFSheet sheet = excelToDb.getDataFromExcelFile(data.getInputStream(), 0, 5);

		List<?> readers = excelToDb.getDataReaders(sheet);

		Iterator itrReader = readers.iterator();
		int count =0;
		while (itrReader.hasNext()) {
			User user = (User) itrReader.next();
			count++;
			System.out.println("MyDebug : User -> " + user.getFirstName() + " " + user.getEmail() + " "
					+ user.getType().getName());
		}
		System.out.println("Number of readers added -> " + count);
		return new ResponseEntity<>(HttpStatus.OK);
	}

}
