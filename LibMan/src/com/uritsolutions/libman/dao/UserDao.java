package com.uritsolutions.libman.dao;

import java.util.List;

import com.uritsolutions.libman.pojos.Response;
import com.uritsolutions.libman.pojos.Type;
import com.uritsolutions.libman.pojos.User;

public interface UserDao {

	public Response saveUser(User user);
	public Response saveUserFromExcel(User user);
	public User getUserByEmail(String email);
	public Response updateUser(User user);
	public void updateUserForReturn(User user);
	public boolean deleteUser(User user);
	public List<User> getAllUsers(); 
	public User getUser(String readerId);
	public User getUserById(int id);
	public boolean saveType(Type type);
	public Type persistType(Type type);
	public boolean updateType(Type type);
	public boolean deleteType(Type type);
	public List<Type> getAllTypes();
	public Response saveUserFromExcel2(User user);

}
