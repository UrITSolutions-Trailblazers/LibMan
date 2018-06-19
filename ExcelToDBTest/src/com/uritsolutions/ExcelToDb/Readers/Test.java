package com.uritsolutions.ExcelToDb.Readers;

public class Test {

	public static void main(String[] args) {
		
		String code = new String("AM002");
		String afterSplit[] = code.split("[^A-Z0-9]+|(?<=[A-Z])(?=[0-9])|(?<=[0-9])(?=[A-Z])");
		
		
		System.out.println("Code -> "+afterSplit[0]+"----"+afterSplit[1] );
	}

}
