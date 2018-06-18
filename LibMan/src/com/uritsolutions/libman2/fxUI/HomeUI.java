package com.uritsolutions.libman2.fxUI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.stereotype.Component;

import com.uritsolutions.libman.config.HibernateConfig;
import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.text.Text;
import javafx.stage.Stage;

@Component
public class HomeUI extends Application {

	@Autowired(required = true)
	AddUser addUser;
	
/*	public static void main(String[] args) {
		
		System.out.println("------------- Initializing Application context -------------");

		ApplicationContext context = new AnnotationConfigApplicationContext("com.uritsolutions.libman");
		context.getBean(HibernateConfig.class);
		context.getBean(SpringBeansInitializer.class);
		context.getBean(HomeUI.class);
		context.getBean(AddUser.class);

		System.out.println("------------- Application Context initialized --------------");
		
		launch(args);

	}

*/	@Override
	public void start(Stage stage) throws Exception {
		// creating label email
		Text usernameText = new Text("Username");

		// creating label password
		Text passwordText = new Text("Password");

		// Creating Text Filed for email
		TextField usernameTextField = new TextField();

		// Creating Text Filed for password
		PasswordField passwordTextField = new PasswordField();

		// Creating Buttons
		Button loginButton = new Button("Login");

		// Creating a Grid Pane
		GridPane gridPane = new GridPane();

		// Setting size for the pane
		gridPane.setMinSize(400, 200);

		// Setting the padding
		gridPane.setPadding(new Insets(10, 10, 10, 10));

		// Setting the vertical and horizontal gaps between the columns
		gridPane.setVgap(5);
		gridPane.setHgap(5);

		// Setting the Grid alignment
		gridPane.setAlignment(Pos.CENTER);

		// Arranging all the nodes in the grid
		gridPane.add(usernameText, 0, 0);
		gridPane.add(usernameTextField, 1, 0);
		gridPane.add(passwordText, 0, 1);
		gridPane.add(passwordTextField, 1, 1);
		gridPane.add(loginButton, 0, 2);

		// Styling nodes
		loginButton.setStyle("-fx-background-color: darkslateblue; -fx-text-fill: white;");

		usernameText.setStyle("-fx-font: normal bold 20px 'serif' ");
		passwordText.setStyle("-fx-font: normal bold 20px 'serif' ");
		gridPane.setStyle("-fx-background-color: BEIGE;");

		// Creating a scene object
		Scene scene = new Scene(gridPane);

		// Setting title to the Stage
		stage.setTitle("CSS Example");

		// Adding scene to the stage
		stage.setScene(scene);

		loginButton.setOnMouseClicked((value) -> {
			if(usernameTextField.getText().equals("admin") && passwordTextField.getText().equals("password")) {
				try {
					stop();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				try {
//					addUser.start(stage);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		});

		// Displaying the contents of the stage
		stage.show();

	}
}
