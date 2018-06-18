package com.uritsolutions.libman.excelToDb;

import java.io.IOException;
import java.time.Year;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.logging.FileHandler;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;

import org.apache.derby.tools.sysinfo;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uritsolutions.ExcelToDb.ExcelToDb;
import com.uritsolutions.ExcelToDb.Readers.SplitReaderCode;
import com.uritsolutions.libman.dao.BookDao;
import com.uritsolutions.libman.dao.CategoryDao;
import com.uritsolutions.libman.dao.UserDao;
import com.uritsolutions.libman.pojos.Book;
import com.uritsolutions.libman.pojos.BookDetail;
import com.uritsolutions.libman.pojos.Category;
import com.uritsolutions.libman.pojos.Type;
import com.uritsolutions.libman.pojos.User;

@Service("excelToDb")
public class ExcelToDbService extends ExcelToDb {

	@Autowired
	BookDao bookDao;

	@Autowired
	CategoryDao categoryDao;

	@Autowired
	UserDao userDao;

	SplitReaderCode splitCode = new SplitReaderCode();

	@Override
	public List<Book> getData(HSSFSheet sheet) {
		
		int count = 0;
		int errorCount=0;

		List<Category> categories = categoryDao.getAllCtegory();

		boolean found_ = false;

		Iterator rows = sheet.rowIterator();

		List<Book> books = new ArrayList<Book>();
		Book book = null;
		Category category = null;

		while (rows.hasNext()) {

			book = new Book();
			category = new Category();
			HSSFRow row = (HSSFRow) rows.next();

			if (!found_) {
				found_ = true;
				continue;
			}

			/*try {
				System.out.println(row.getCell(3) + "  " + row.getCell(1) + "  " + row.getCell(5).getNumericCellValue()
						+ "  " + row.getCell(6).getNumericCellValue());
			} catch (Exception e) {
				System.out.println(row.getCell(3) + " Error -> " + e.getMessage());
			}*/
			book.setTitle(row.getCell(3).toString());
			book.setAuther(row.getCell(1).toString());

			String year;
			try {
				int year_ = (int) row.getCell(5).getNumericCellValue();
				year = new String(""+year_);
			} catch (Exception e) {
				errorCount++;
				year = new String("0000");
			}
			book.setYearOfPub(year);

			int price;
			try {
				price = (int) row.getCell(6).getNumericCellValue();
			} catch (Exception e) {
				errorCount++;
				price = 000;
			}

			book.setPrice(price);

			boolean found = false;
			for (Category category2 : categories) {

				if (category2.getCategory().equals(row.getCell(4).getStringCellValue())) {
					found = true;
					category = category2;
					//System.out.println("MyDebug : Category found -> " + category2.getCategory());
					break;
				}
			}

			if (!found) {
				category = new Category();

				category.setCategory(row.getCell(4).getStringCellValue());
				category = categoryDao.persistCategory(category);
				//System.out.println("MyDebug : Category NOT found -> " + category.getCategory());
				categories.add(category);
			}

			book.setCategory(category);
			book.setId((int)row.getCell(0).getNumericCellValue());
			books.add(book);
			count++;
		}
		System.out.println("Book read count -> "+count);
		return books;
	}

	@Override
	public List<?> getDataReaders(HSSFSheet sheet) {
		
		boolean found_ = false;
		List<Type> types = userDao.getAllTypes();

		Iterator rows = sheet.rowIterator();

		List<User> users = new ArrayList<>();

		User user = null;
		Type type = null;
		while (rows.hasNext()) {
			user = new User();
			type = new Type();
			HSSFRow row = (HSSFRow) rows.next();
			if (!found_) {
				found_ = true;
				continue;
			}
			System.out.println(
					"MyDebug : " + row.getCell(0).getStringCellValue() + " -- " + row.getCell(1).getStringCellValue());
			System.out.println("MyDebug : Splitiing the Reader Code");
			
			int readerId;
			String typeOfReader = new String();
			try {
				String code[] = splitCode.splitReaderCode01(row.getCell(0).getStringCellValue());
				System.out.println("MyDebug : Code -> " + code[0] + "_" + code[1]);

				readerId = Integer.parseInt(code[1]);
				System.out.println("MyDebug : ID parsed -> " + readerId);
				
				typeOfReader = new String(code[0]);
			} catch (Exception e) {
				
				System.out.println("MyDebug : Code -> " + 0 + "_" + "DEFAULT");

				readerId = 0;
				System.out.println("MyDebug : ID parsed -> " + readerId);
				
				typeOfReader = new String("DEFAULT");
			}
			

			boolean found = false;
			for (Type type_ : types) {

				if (typeOfReader.equals(type_.getName())) {
					found = true;
					type = type_;
					System.out.println("MyDebug : Type found in DB -> " + type.getName());
					break;
				}
			}

			if (!found) {
				type = new Type();

				type.setName(typeOfReader);
				type = userDao.persistType(type);
				System.out.println("MyDebug : Type NOT found in DB -> " + type.getName());
				types.add(type);
			}

			user.setId(readerId);
			user.setReaderNumber(row.getCell(0).getStringCellValue());
			user.setFirstName(row.getCell(1).getStringCellValue());
			user.setLastName(new String());
			String phone = new String();
			try {
				phone = new DataFormatter().formatCellValue(row.getCell(2));
			} catch (Exception e) {
				System.out.println(e.getMessage());
				// TODO: handle exception
			}
			user.setPhone(phone);
			try {
				user.setEmail(row.getCell(3).getStringCellValue());
			} catch (Exception e) {
				user.setEmail(new String());
			}
			user.setAddress(new String());
			user.setType(type);
			
			user.setId(0);
			userDao.saveUserFromExcel(user);
			
			users.add(user);

		}

		return users;
	}
}
