<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Readers</title>
</head>
<body>
	<div class="container">
<%-- 		<%@include file="shared/header.jsp"%>
 --%>
		<table class="highlight responsive-table">
			<thead>
				<tr>
					<th>Member Code</th>
					<th>Name</th>
					<th>E-Mail</th>
					<th>Phone</th>
					<th></th>
				</tr>
			</thead>
			<tbody id="tableBody">
				<tr id="progressBar">
					<td></td>
					<td></td>
					<td>
						<div class="progress">
							<div class="indeterminate"></div>
						</div>
					</td>
					<td></td>
					<td></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td style="width: 300px">
						<ul class="pagination">
							<li class="disabled"><a href="#!"><i
									class="material-icons">chevron_left</i></a></li>
							<li class="active"><a href="#!">1</a></li>
							<li class="waves-effect"><a href="#!">2</a></li>
							<li class="waves-effect"><a href="#!">3</a></li>
							<li class="waves-effect"><a href="#!">4</a></li>
							<li class="waves-effect"><a href="#!">5</a></li>
							<li class="waves-effect"><a href="#!"><i
									class="material-icons">chevron_right</i></a></li>
						</ul>
					</td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</tfoot>
		</table>
	</div>

	<div class="fixed-action-btn horizontal">
		<a class="btn-floating btn-large red"> <i
			class="large material-icons">mode_edit</i>
		</a>
		<ul>
			<li><a class="btn-floating red"><i class="material-icons">insert_chart</i></a></li>
			<li><a class="btn-floating yellow darken-1"><i
					class="material-icons">format_quote</i></a></li>
			<li><a class="btn-floating green tooltipped"
				onclick="$('#addReaderTypeModal').modal('open');"
				data-position="top" data-delay="30"
				data-tooltip="Add a type of Reader"><i class="material-icons">publish</i></a></li>
			<li><a class="btn-floating blue tooltipped"
				onclick="$('#addReaderModal').modal('open');" data-position="top"
				data-delay="30" data-tooltip="Add a Reader"><i
					class="material-icons">attach_file</i></a></li>
		</ul>
	</div>

	<!-- 
		Modal to add book.
	 -->
	<div id="addReaderModal" class="modal">
		<div class="modal-content">
			<h4>Add a Reader</h4>
			<div class="row">
				<form:form modelAttribute="user" class="col s12"
					action="${contextPath}/admin/saveReader" method="POST">

					<div class="row">
						<div class=" col s4">
							<label>Type</label>
							<form:select path="type.id" multiple="false">
								<form:option value="0" disabled="true" selected="true">Choose your option</form:option>
								<form:options items="${types}" itemLabel="name" itemValue="id" />
							</form:select>
						</div>
						<div class="input-field col s8">
							<i class="material-icons prefix">lock_outline</i>
							<form:input path="id" id="id" class="validate" />
							<form:label path="id" for="id">Member Code</form:label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s6">
							<i class="material-icons prefix">account_box</i>
							<form:input path="firstName" id="firstName" class="validate" />
							<form:label path="firstName" for="firstName">First Name</form:label>
						</div>
						<div class="input-field col s6">
							<form:input path="lastName" id="lastName" class="validate" />
							<form:label path="lastName" for="lastName">Last Name</form:label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<i class="material-icons prefix">mail_outline_box</i>
							<form:input path="email" type="email" id="email" class="validate" />
							<form:label path="email" for="email" data-error="wrong"
								data-success="right">E-Mail</form:label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<i class="material-icons prefix">phone</i>
							<form:input path="phone" id="phone" class="validate" />
							<form:label path="phone" for="phone">Phone</form:label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<i class="material-icons prefix">home</i>
							<form:textarea path="address" id="address"
								class="validate materialize-textarea" />
							<form:label path="address" for="address">Address</form:label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s11">
							<input class="btn" type="submit" value="Submit">
						</div>
					</div>
				</form:form>
			</div>
		</div>
		<div class="modal-footer">
			<a href="#!"
				class="modal-action modal-close waves-effect waves-green btn-flat">Close</a>
		</div>
	</div>

	<!-- 
		Modal to add type of reader.
	 -->
	<div id="addReaderTypeModal" class="modal">
		<div class="modal-content">
			<h4>Add a type of Reader</h4>
			<div class="row">
				<form:form modelAttribute="type" class="col s12"
					action="${contextPath}/admin/saveReaderType" method="POST">
					<div class="row">
						<div class="input-field col s12">
							<i class="material-icons prefix">mail_outline_box</i>
							<form:input path="name" type="text" id="name" class="validate" />
							<form:label path="name" for="name" data-error="wrong"
								data-success="right">Type of Reader</form:label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s11">
							<input class="btn" type="submit" value="Submit">
						</div>
					</div>
				</form:form>
			</div>
		</div>
		<div class="modal-footer">
			<a href="#!"
				class="modal-action modal-close waves-effect waves-green btn-flat">Close</a>
		</div>
	</div>

	<!-- 
		Issue book modal.
	 -->
	<div id="issueBookModal" class="modal" style="height: 100%">
		<div class="modal-content">
			<div id="content" style="padding-top: 30px">
				<div id="issueBookForm"></div>
			</div>
		</div>

		<div class="modal-footer">
			<a href="#!"
				class="modal-action modal-close waves-effect waves-green btn-flat">Close</a>
		</div>
	</div>

	<!-- 
		Script to initialize Modal 
	-->
	<script type="text/javascript">
		$(document).ready(function() {
			// the "href" attribute of the modal trigger must specify the modal ID that wants to be triggered
			$('.modal').modal();
		});
	</script>

	<!-- 
		Reader Save status toast script.
	 -->
	<script type="text/javascript">
		$(document).ready(function() {
			if(${status}){
				Materialize.toast('Reader was successfuly saved.', 4000);
			}else if(${!status}){
				Materialize.toast('Opps the reader was not saved..', 4000);
			}
		});
	</script>

	<!-- 
		Script to populate the table
	 -->
	<script type="text/javascript">
		//reset the count:
		var count = 0;

		console.log('MyBebug: Populating table started');
		var array = {};
		var tbody = $('#tableBody');
		$
				.get('http://localhost:8080/LibmanFrontEnd/admin/getAllUsers',
						function(data, status) {
							array = data;
							$("#progressBar").hide();
							console.log(array[0]);
						})
				.then(
						// cache <tbody> element:
						function() {
							for (var i = 0; i < 10; i++) {
								// create an <tr> element, append it to the <tbody> and cache it as a variable:
								var tr = $('<tr/>').appendTo(tbody);
								// append <td> elements to previously created <tr> element:
								tr
										.append('<td>'
												+ array[count].type.name
												+' '
												+ array[count].id
												+ '</td><td>'
												+ array[count].firstName
												+ '</td><td>'
												+ array[count].email
												+ '</td><td>'
												+ array[count].phone
												+ '</td><td>'
												+ '<a class="waves-effect waves-light btn red" onclick="issueBook('
												+ array[count].id
												+ ')">'
												+ '<i class="material-icons left">burst_mode</i> Issue</a></td>');
								count++;
							}
						});
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$('select').material_select();
		});
	</script>

	<!-- 
		Script to render book issue form in the modal.
	 -->
	<script type="text/javascript">
			
			var returnDate = new Date();
			function issueBook(id) {
				$('#issueBookForm').empty();
				$('#issueBookForm').append(
				'<div class="row">'+
					'<div class="input-field col s12">'+
					'	<input type="text" name="bookNumber"> <label'+
					'		for="bookNumber">Book Number</label>'+
					'</div>'+
				'</div>'+
				'<div class="row">'+
				'	<div class="input-field col s12">'+
				'		<input type="text" name="returnDate" class="datepicker"> <label'+
				'			for="returnDate">Return Date</label>'+
				'	</div>'+
				'</div>'+
				'<div class="row">'+
				'	<div class="input-field col s11">'+
				'		<input class="btn" type="button" value="Issue" onclick="issue('+id+')">'+
				'	</div>'+
				'</div>'
						);
				$('.datepicker').pickadate({
				    selectMonths: true, // Creates a dropdown to control month
				    selectYears: new Date().getFullYear(), // Creates a dropdown of 15 years to control year,
				    today: 'Today',
				    clear: 'Clear',
				    close: 'Ok',
				    closeOnSelect: false // Close upon selecting a date,
				  });
				
				$('#issueBookModal').modal('open');
			}
					
	</script>

	<!-- 
	
	 -->
	<script type="text/javascript">
	
		function issue(id) {
			var bookNumber = $('input[name = bookNumber]').val();
			var returnDate = $('input[name = returnDate]').val();
			
			$.post(
					'http://localhost:8080/LibmanFrontEnd/admin/issue/book/'
							+ bookNumber + '/' + returnDate + '/' + id, function(data, status) {
						console.log(data);
						bookDetail = data;
					}).then(
					function() {
						Materialize.toast('Book issued', 4000);
					});
		}
	</script>

</body>
</html>