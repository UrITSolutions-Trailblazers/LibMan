package com.uritsolutions.libman.config;

import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBuilder;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@ComponentScan("com.uritsolutions.libman")
@EnableTransactionManagement
public class HibernateConfig {
	
	/*
	 * Data Base Configurations
	 */
//	private final static String DATABASE_URL = "jdbc:h2:tcp://localhost/~/libMan";
	/*private final static String DATABASE_URL = "jdbc:derby:C:\\LibMan\\LibManDB;update=true";
	private final static String DATABASE_DRIVER = "org.apache.derby.jdbc.EmbeddedDriver";
	private final static String DATABASE_DIALECT = "org.hibernate.dialect.DerbyTenSixDialect";
	private final static String DATABASE_USERNAME = "admin";
	private final static String DATABASE_PASSOWRD = "admin";
	*/
	private final static String DATABASE_URL = "jdbc:hsqldb:file:C:\\LibMan\\LibManDB\\DB";
	private final static String DATABASE_DRIVER = "org.hsqldb.jdbc.JDBCDriver";
	private final static String DATABASE_DIALECT = "org.hibernate.dialect.HSQLDialect";
	private final static String DATABASE_USERNAME = "admin";
	private final static String DATABASE_PASSOWRD = "admin";

	/*
	 * DataSource Bean
	 */
	@Bean(name = "dataSource")
	public DataSource getDataSource() {

		BasicDataSource basicDataSource = new BasicDataSource();

		/*
		 * Giving Data Source Configuration
		 */
		basicDataSource.setDriverClassName(DATABASE_DRIVER);
		basicDataSource.setUrl(DATABASE_URL);
		basicDataSource.setUsername(DATABASE_USERNAME);
		basicDataSource.setPassword(DATABASE_PASSOWRD);

		return basicDataSource;
	}

	/*
	 * Session Factory Bean
	 */
	@Autowired
	@Bean(name = "sessionFactory")
	public SessionFactory getSessionFactory(DataSource dataSource) {

		LocalSessionFactoryBuilder sessionBuilder = new LocalSessionFactoryBuilder(dataSource);

		sessionBuilder.addProperties(getHibernateProperties());
		sessionBuilder.scanPackages("com.uritsolutions.libman");

		return sessionBuilder.buildSessionFactory();
	}

	/*
	 * For Hibernate Properties
	 */
	public Properties getHibernateProperties() {

		Properties properties = new Properties();

		properties.put("hibernate.dialect", DATABASE_DIALECT);
		/*properties.put("hibernate.show_sql", "true");
		properties.put("hibernate.format_sql", "true");*/
		properties.put("hibernate.hbm2ddl.auto", "update");

		return properties;
	}

	/*
	 * Hibernate Transaction Manager
	 */
	@Bean
	public HibernateTransactionManager getHibernateTransactionManager(SessionFactory sessionFactory) {

		HibernateTransactionManager transactionManager = new HibernateTransactionManager(sessionFactory);

		return transactionManager;
	}
}
