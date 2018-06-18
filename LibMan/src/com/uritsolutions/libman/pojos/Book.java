package com.uritsolutions.libman.pojos;

import java.time.Year;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Book {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String title;
	private String auther;
	private int price;
	private String yearOfPub;

	@ManyToOne(fetch = FetchType.EAGER)
	private Category category;

	/*
	 * Getters and setters.
	 */

	public String getTitle() {
		return title;
	}

	public String getYearOfPub() {
		return yearOfPub;
	}

	public void setYearOfPub(String yearOfPub) {
		this.yearOfPub = yearOfPub;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuther() {
		return auther;
	}

	public void setAuther(String auther) {
		this.auther = auther;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

}
