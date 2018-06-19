package com.uritsolutions.ExcelToDb;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

public abstract class ExcelToDb {

	public abstract List<?> getData(HSSFSheet sheet);
	
	public abstract List<?> getDataReaders(HSSFSheet sheet);
	
	public HSSFSheet getDataFromExcelFile(InputStream inputStream,int sheetNumber,int cellCount) throws IOException {
		
		/*
		 * Loading the file as excel/doc file.
		 * */
		POIFSFileSystem excelFile = new POIFSFileSystem(inputStream);
		HSSFWorkbook workbook = new HSSFWorkbook(excelFile);
		HSSFSheet sheet = workbook.getSheetAt(sheetNumber);
		
		return sheet;
		
	}
}
