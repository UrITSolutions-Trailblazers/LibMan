package com.uritsolutions.libman.pojos;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.springframework.stereotype.Component;

@Component
@Entity
@Table(name = "USER_TABLE")
public class User implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4654779294190447833L;

	@Id
	@Basic(optional = false)
	@GenericGenerator(name = "idOrAutoGen", strategy = "com.uritsolutions.libman.generator.ManualIdGenerator")
	@GeneratedValue(generator = "idOrAutoGen")
	private int id;
	@ManyToOne(fetch = FetchType.EAGER)
	private Type type;
	private String readerNumber;
	private String firstName;
	private String lastName;
	private String email;
	private String phone;
	private String address;
	private int bookCount;
	private String role;
	private boolean enabled;
	/*
	 * Getters and Setters
	 */

	public int getId() {
		return id;
	}

	public String getReaderNumber() {
		return readerNumber;
	}

	public void setReaderNumber(String readerNumber) {
		this.readerNumber = readerNumber;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Type getType() {
		return type;
	}

	public void setType(Type type) {
		this.type = type;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public int getBookCount() {
		return bookCount;
	}

	public void setBookCount(int bookCount) {
		this.bookCount = bookCount;
	}

}
