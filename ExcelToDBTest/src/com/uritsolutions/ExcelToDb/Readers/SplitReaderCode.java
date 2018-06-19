package com.uritsolutions.ExcelToDb.Readers;

public class SplitReaderCode {
	
	public String[] splitReaderCode01(String code) {
		return code.split("[^A-Z0-9]+|(?<=[A-Z])(?=[0-9])|(?<=[0-9])(?=[A-Z])");
	}

}
