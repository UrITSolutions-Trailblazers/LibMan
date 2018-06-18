package com.uritsolutions.libman2.fxUI;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.uritsolutions.libman.dao.UserDao;
import com.uritsolutions.libman.pojos.Book;
import com.uritsolutions.libman.pojos.User;

import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.text.Text;
import javafx.stage.Stage;

@Component
public class AddUser  {
/*
	@Autowired
	User user;
	
	@Autowired
	UserDao userDao;
	
	public AddUser() {
		System.out.println("----------------- AddUser constructor called ---------------");
	}

	@Override
	public void start(Stage stage) throws Exception {

		
		 * Text for labels.
		 * 
		Text firstNameText = new Text("Name");
		Text lastNameText = new Text("Name");
		Text emailText = new Text("E-mail");
		Text phoneText = new Text("Phone Number");
		Text addressText = new Text("Address");
		
		
		 * TextFiels for input fields.
		 * 
		TextField firstNameTextField = new TextField();
		TextField lastNameTextField = new TextField();
		TextField emailTextField = new TextField();
		TextField phoneTextField = new TextField();
		TextField addressTextField = new TextField();
		
		
		 * Buttons for action.
		 * 
		Button submitButton = new Button("Submit");
		Button button2 = new Button("Clear");

		
		 * Inner layout definitions.
		 * 
		GridPane gridPane = new GridPane();
		gridPane.setMinSize(400, 500);

		gridPane.setPadding(new Insets(10, 10, 10, 10));

		gridPane.setVgap(5);
		gridPane.setHgap(5);
		gridPane.setAlignment(Pos.CENTER);

		
		 * Adding all the components 
		 * 
		gridPane.add(firstNameText, 0, 0);
		gridPane.add(firstNameTextField, 1, 0);
		gridPane.add(lastNameText, 0, 1);
		gridPane.add(lastNameTextField, 1, 1);
		gridPane.add(emailText, 0, 2);
		gridPane.add(emailTextField, 1, 2);
		gridPane.add(phoneText, 0, 3);
		gridPane.add(phoneTextField, 1, 3);
		gridPane.add(addressText, 0, 4);
		gridPane.add(addressTextField, 1, 4);
		gridPane.add(submitButton, 0, 5);

		
		 * Styling the components.
		 * 
		submitButton.setStyle("-fx-background-color: darkslateblue; -fx-text-fill: white;");
		button2.setStyle("-fx-background-color: darkslateblue; -fx-text-fill: white;");

		firstNameText.setStyle("-fx-font: normal bold 20px 'serif' ");
		lastNameText.setStyle("-fx-font: normal bold 20px 'serif' ");
		emailText.setStyle("-fx-font: normal bold 20px 'serif' ");
		phoneText.setStyle("-fx-font: normal bold 20px 'serif' ");
		addressText.setStyle("-fx-font: normal bold 20px 'serif' ");
		
		gridPane.setStyle("-fx-background-color: BEIGE;");

		
		 * Creating a scene.
		 * 
		Scene scene = new Scene(gridPane);
		stage.setTitle("Add User");
		stage.setScene(scene);

		
		 * Persisting the user to database.
		 * 
		submitButton.setOnMouseClicked((value)->{
			
			
			 * Setting the form values the User bean.
			 * 
			user.setFirstName(firstNameTextField.getText());
			user.setLastName(lastNameTextField.getText());
			user.setEmail(emailTextField.getText());
			user.setPhone(phoneTextField.getText());
			user.setAddress(addressTextField.getText());
			user.setEnabled(true);
			user.setRole("DFLT");
			user.setBookCount(0);
			user.setBooks(new ArrayList<Book>());
			
			userDao.saveUser(user);
		});
		
		
		 * Displaying the contents of the stage.
		 * 
		stage.show();
		
	}*/

}
