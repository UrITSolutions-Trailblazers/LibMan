package com.uritsolutions.libman.dao.impl;

import java.util.List;

import javax.persistence.NoResultException;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.exception.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.uritsolutions.libman.dao.UserDao;
import com.uritsolutions.libman.pojos.Book;
import com.uritsolutions.libman.pojos.Response;
import com.uritsolutions.libman.pojos.Type;
import com.uritsolutions.libman.pojos.User;

@Transactional
@Repository("userDao")
public class UserDaoImpl implements UserDao {

	private Response response;

	Session session;
	Transaction transaction;

	@Autowired
	User tempUser;

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public Response saveUser(User user) {
		try {
			System.out.println("Line -> 1");
			session = sessionFactory.openSession();
			transaction = (Transaction) session.beginTransaction();
			session.createQuery("FROM User WHERE email = :email", User.class).setParameter("email", user.getEmail())
					.getSingleResult();
			transaction.commit();
			session.close();
			System.out.println("Line -> 2");
			System.out.println("E-Mail already present.");
			response = new Response();
			response.setCode(406);
			response.setMessage("E-Mail already present.");
			return response;
		} catch (Exception e) {
			System.out.println("Line -> 3");
			e.printStackTrace();
			System.out.println(e.getMessage());
			try {
				System.out.println("Line -> 4");
				transaction.rollback();
				session.close();

				System.out.println("Line -> 5");
				Type type = sessionFactory.getCurrentSession().get(Type.class, user.getType().getId());

				System.out.println("Line -> 6");
				user.setReaderNumber(type.getName() + user.getId());
				user.setId(0);
				System.out.println("Line -> 7");
				session = sessionFactory.openSession();
				transaction = (Transaction) session.beginTransaction();
				session.persist(user);
				transaction.commit();
				session.close();
				
				System.out.println("Line -> 8");
				System.out.println("Reader successfully");
				response = new Response();
				response.setCode(202);
				response.setMessage("Reader successfully Saved");
				return response;
			} catch (Exception e2) {
				System.out.println("Line -> 9");
				System.out.println(e2.getMessage());
				System.out.println("Reader with ID " + user.getId() + " already present.");
				response = new Response();
				response.setCode(406);
				response.setMessage("Reader with ID " + user.getId() + " already present.");
				return response;
			} finally {
				try {
					transaction.commit();
					session.close();
				} catch (Exception e3) {
					System.out.println("Session and transaction already closed.");
				}
				response.setCode(500);
				response.setMessage("Something went wrong.");
			}
		}

	}

	@Override
	public User getUserByEmail(String email) {

		User user;
		try {
			user = sessionFactory.getCurrentSession().createQuery("FROM User WHERE email = '" + email + "'", User.class)
					.getSingleResult();
			return user;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			user = null;
			return user;
		}
	}

	@Override
	public Response updateUser(User user) {

		user.setId(tempUser.getId());
		try {
			System.out.println("Line -> 1");

			if (tempUser.getEmail().equals(user.getEmail())) {
				throw new Exception();
			}

			session = sessionFactory.openSession();
			transaction = (Transaction) session.beginTransaction();
			session.createQuery("FROM User WHERE email = :email", User.class).setParameter("email", user.getEmail())
					.getSingleResult();
			transaction.commit();
			session.close();
			System.out.println("Line -> 2");
			System.out.println("E-Mail already present.");
			response = new Response();
			response.setCode(406);
			response.setMessage("E-Mail already present.");
			return response;
		} catch (Exception e) {
			System.out.println("Line -> 3");
			e.printStackTrace();
			System.out.println(e.getMessage());
			try {
				System.out.println("Line -> 4");
				try {
					transaction.rollback();
					session.close();
				} catch (Exception e2) {
					System.out.println("No session was created");
				}

				session = sessionFactory.openSession();
				transaction = (Transaction) session.beginTransaction();
				session.update(user);
				transaction.commit();
				session.close();

				System.out.println("Reader successfully");
				response = new Response();
				response.setCode(202);
				response.setMessage("Reader successfully");
				return response;
			} catch (Exception e2) {
				System.out.println("Line -> 9");
				e2.printStackTrace();
				System.out.println(e2.getMessage());
				System.out.println("Something went wrong.");
				response = new Response();
				response.setCode(406);
				response.setMessage("Something went wrong.");
				return response;
			} finally {
				try {
					transaction.commit();
					session.close();
				} catch (Exception e3) {
					e3.printStackTrace();
					System.out.println("Session and transaction already closed.");
				}
				response.setCode(500);
				response.setMessage("Something went wrong.");
			}
		}

	}

	@Override
	public boolean deleteUser(User user) {

		try {
			sessionFactory.getCurrentSession().delete(user);
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}
	}

	@Override
	public List<User> getAllUsers() {

		return sessionFactory.getCurrentSession().createQuery("FROM User", User.class).list();
	}

	@Override
	public boolean saveType(Type type) {
		try {
			sessionFactory.getCurrentSession().save(type);
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}
	}

	@Override
	public boolean updateType(Type type) {
		try {
			sessionFactory.getCurrentSession().update(type);
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}
	}

	@Override
	public boolean deleteType(Type type) {
		try {
			sessionFactory.getCurrentSession().delete(type);
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}
	}

	@Override
	public List<Type> getAllTypes() {

		return sessionFactory.getCurrentSession().createQuery("FROM Type", Type.class).list();
	}

	@Override
	public User getUser(String readerId) {

		User user;

		try {
			session = sessionFactory.openSession();
			transaction = (Transaction) session.beginTransaction();
			tempUser = session.createQuery("FROM User WHERE readerNumber = :rn ", User.class)
					.setParameter("rn", readerId).getSingleResult();
			transaction.commit();
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
			tempUser = new User();
		}

		return tempUser;
	}

	@Override
	public Type persistType(Type type) {
		try {
			sessionFactory.getCurrentSession().persist(type);
			return type;

		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
	}

	@Override
	public Response saveUserFromExcel(User user) {
		
		try {
			Session session = sessionFactory.openSession();
			Transaction transaction = (Transaction) session.beginTransaction();
			session.save(user);
			transaction.commit();
			session.close();
			
			return new Response();
		} catch (Exception e) {
			return new Response();
		}
		/*try {
			
			if(user.getEmail().isEmpty()) {
				throw new Exception("Empty E-mail");
			}
			sessionFactory.getCurrentSession().createQuery("FROM User WHERE email = :email", User.class)
					.setParameter("email", user.getEmail()).getSingleResult();
			// sessionFactory.close();
			System.out.println("E-Mail already present.");
			response = new Response();
			response.setCode(406);
			response.setMessage("E-Mail already present.");
			return response;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			try {
				User temp = new User();
				if (user.getId() != 0) {
					try {
						sessionFactory.openSession();
						temp = sessionFactory.getCurrentSession()
								.createQuery("FROM User WHERE id = :readerId OR readerNumber = :readerNumber",
										User.class)
								.setParameter("readerId", user.getId())
								.setParameter("readerNumber", user.getReaderNumber()).getSingleResult();
				
					} catch (Exception e2) {
						// sessionFactory.close();
						e2.printStackTrace();
						sessionFactory.getCurrentSession().save(user);
						System.out.println("Reader added successfully");
						response = new Response();
						response.setCode(202);
						response.setMessage("Reader added successfully");
						return response;
					}
					if (temp.getId() == user.getId() && !temp.getReaderNumber().equals(user.getReaderNumber())) {
						// sessionFactory.close();
						user.setId(0);
						Session session = sessionFactory.openSession();
						Transaction transaction = (Transaction) session.beginTransaction();
						session.save(user);
						transaction.commit();
						session.close();
						System.out.println("Reader added successfully");
						response = new Response();
						response.setCode(202);
						response.setMessage("Reader added successfully");
						return response;
					} else if (temp.getReaderNumber().equals(user.getReaderNumber())) {
						System.out.println(e.getMessage());
						System.out.println("Reader with Reader Number " + user.getReaderNumber() + " already present.");
						response = new Response();
						response.setCode(406);
						response.setMessage(
								"Reader with Reader Number " + user.getReaderNumber() + " already present.");
						return response;
					}
				}
				// sessionFactory.close();
				// sessionFactory.openSession();
				sessionFactory.getCurrentSession().save(user);
				System.out.println("Reader added successfully");
				response = new Response();
				response.setCode(202);
				response.setMessage("Reader added successfully");
				return response;
			} catch (Exception e2) {
				e2.printStackTrace();
				System.out.println(e2.getMessage());
				System.out.println("Reader with ID " + user.getId() + " already present.");
				response = new Response();
				response.setCode(406);
				response.setMessage("Reader with ID " + user.getId() + " already present.");
				return response;
			}
		}*/
	}

	@Override
	public User getUserById(int id) {
		User user;

		try {
			session = sessionFactory.openSession();
			transaction = (Transaction) session.beginTransaction();
			user = session.createQuery("FROM User WHERE id = :id",User.class).setParameter("id", id).getSingleResult();
			System.out.println("User fetched for update -> " + user.getFirstName());
			transaction.commit();
			session.close();
		} catch (Exception e) {
			e.printStackTrace();
			user = new User();
		}

		return user;
	}

	@Override
	public void updateUserForReturn(User user) {
		Session session = sessionFactory.openSession();
		Transaction transaction = (Transaction) session.beginTransaction();
		session.update(user);
		transaction.commit();
		session.close();

	}

	@Override
	public Response saveUserFromExcel2(User user) {
		Session session = sessionFactory.openSession();
		Transaction transaction = (Transaction) session.beginTransaction();
		session.save(user);
		transaction.commit();
		session.close();
		response = new Response();
		response.setCode(202);
		response.setMessage("Reader added successfully");
		return response;
	}
}
