<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Books</title>
</head>
<body>
	<div class="container">
<%-- 		<%@include file="shared/header.jsp"%>
 --%>		<table class="highlight responsive-table">
			<thead>
				<tr>
					<th>Book Name</th>
					<th>Author</th>
					<th>Status</th>
				</tr>
			</thead>
			<tbody id="tableBody">
				<tr id="progressBar">
					<td></td>
					<td>
						<div class="progress">
							<div class="indeterminate"></div>
						</div>
					</td>
					<td></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
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
				</tr>
			</tfoot>
		</table>
	</div>

	<!-- 
		Floating action button
	 -->
	<div class="fixed-action-btn horizontal">
		<a class="btn-floating btn-large red pulse"> <i
			class="large material-icons">mode_edit</i>
		</a>
		<ul>
			<li><a class="btn-floating red"><i class="material-icons">insert_chart</i></a></li>
			<li><a class="btn-floating yellow darken-1"><i
					class="material-icons">format_quote</i></a></li>
			<li><a class="btn-floating green tooltipped"
				onclick="$('#addCategoryModal').modal('open');" data-position="top"
				data-delay="30" data-tooltip="Add a Category"><i
					class="material-icons">publish</i></a></li>
			<li><a class="btn-floating blue tooltipped"
				onclick="$('#addBookModal').modal('open');" data-position="top"
				data-delay="30" data-tooltip="Add a Book"><i
					class="material-icons">cloud_upload</i></a></li>
		</ul>
	</div>

	<!-- 
		Modal to add book.
	 -->
	<div id="addBookModal" class="modal">
		<div class="modal-content">
			<h4>Add Book</h4>
			<div class="row">
				<form:form modelAttribute="book" class="col s12"
					action="${contextPath}/admin/addNewBook" method="POST">
					<form:hidden path="id" />
					<div class="row">
						<div class="input-field col s12">
							<form:input path="title" id="title" class="validate" />
							<form:label path="title" for="title">Title</form:label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<form:input path="auther" id="auther" class="validate" />
							<form:label path="auther" for="auther">Author</form:label>
						</div>
					</div>
					<div class="row">
						<div class=" col s12">
							<label>Genre</label>
							<form:select path="category.id" multiple="false">
								<option value="" disabled selected>Choose your option</option>
								<form:options items="${categories}" itemLabel="category"
									itemValue="id" />
							</form:select>

						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<form:input path="price" id="price" class="validate" />
							<form:label path="price" for="price">Price</form:label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<form:input path="yearOfPub" id="yearOfPub" class="validate" />
							<form:label path="yearOfPub" for="yearOfPub">Year Of Publication</form:label>
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
		Modal to add Category
	 -->
	<div id="addCategoryModal" class="modal">
		<div class="modal-content">
			<h4>Add Book</h4>
			<div class="row">
				<form:form modelAttribute="categoryBean" class="col s12"
					action="${contextPath}/admin/addNewCategory" method="post">
					<div class="row">
						<div class="input-field col s12">
							<form:input path="category" id="category" type="text"
								class="validate" />
							<form:label path="category" for="category">Category</form:label>
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
		Modal to add book to shelf.
	 -->
	<div id="addBookToShelfModal" class="modal">
		<div class="modal-content">
			<h4>Add To Shelf</h4>
			<div class="row">
				<div class="row">
					<div class="input-field col s12">
						<input id="bookNumber" name="bookNumber" class="validate" /> <label
							for="bookNumber">Book Number</label>
					</div>
				</div>
				<div class="row">
					<div class="input-field col s11">
						<button class="btn" onclick="addBookToShelf()">Submit</button>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<a href="#!"
				class="modal-action modal-close waves-effect waves-green btn-flat">Close</a>
		</div>
	</div>

	<!-- 
		Modal for book shelf.
	 -->
	<div id="BookShelfModal" class="modal" style="height: 100%">
		<div class="modal-content">
			<div id="title"></div>
			<table class="highlight">
				<thead>
					<tr>
						<th>Book Number</th>
						<th>Return Date</th>
						<th>Issue Status</th>
					</tr>
				</thead>
				<tbody id="shelfBody">

				</tbody>
			</table>
		</div>
		<div class="modal-footer">
			<a href="#!"
				class="modal-action modal-close waves-effect waves-green btn-flat">Close</a>
		</div>
	</div>

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
				.get('http://localhost:8080/LibmanFrontEnd/admin/getBookData',
						function(data, status) {
							array = data;
							$("#progressBar").hide();
						})
				.then(
						// cache <tbody> element:
						function() {

							for (var i = 0; i < 10; i++) {
								// create an <tr> element, append it to the <tbody> and cache it as a variable:
								var tr = $('<tr/>').appendTo(
										'tbody[id = tableBody]');
								// append <td> elements to previously created <tr> element:
								tr
										.append('<td>'
												+ array[count].title
												+ '</td><td>'
												+ array[count].auther
												+ '</td><td>'
												+ '<a class="waves-effect waves-light btn red tooltipped" data-position="top"'
												+ 'data-delay="30" data-tooltip="Add book to shelf" onclick="setBook('
												+ array[count].id
												+ ')">'
												+ '<i class="large material-icons">clear_all</i></a><span>     </span><a class="waves-effect waves-light btn green" onclick="getBooksFromShelf('
												+ array[count].id
												+ ')">'
												+ '<i class="large material-icons">dvr</i></a></td>');
								count++;
							}
						});
	</script>

	<script type="text/javascript">
		var bookid = 0;
		function setBook(id) {
			var bookDetail = '';
			bookid = id;
			$('#addBookToShelfModal').modal('open');

		}

		function addBookToShelf() {
			var id = $('input[name="bookNumber"]').val();
			console.log(id);
			$.post(
					'http://localhost:8080/LibmanFrontEnd/admin/addBookToShelf/'
							+ bookid + '/' + id, function(data, status) {
						console.log(data);
						bookDetail = data;
					}).then(
					function() {
						Materialize.toast('Book added to shelf: '
								+ bookDetail.bookNumber, 4000);
					});
		}

		/*
			Function to populate the showFelfModal.
		 */
		function getBooksFromShelf(id) {

			var array = [];
			function formatDate(date) {
				var monthNames = [ "January", "February", "March", "April",
						"May", "June", "July", "August", "September",
						"October", "November", "December" ];

				var day = date.getDate();
				var monthIndex = date.getMonth();
				var year = date.getFullYear();

				return day + ' ' + monthNames[monthIndex] + ' ' + year;
			}

			$
					.post(
							'http://localhost:8080/LibmanFrontEnd/admin/getBooksFromShelf/'
									+ id, function(data, status) {
								array = data;
								console.log(array);
							})
					.then(
							function() {
								$('tbody[id = shelfBody]').empty();
								$('div[id = title]').empty();
								$('div[id = title]').append(
										'<h4 class = "">' + array[0].book.title
												+ '</h4>');
								var count = 0;
								array
										.forEach(function(item) {

											var date = '';
											if(item.returnDate == null){
												date = '--';
											}else{
												date = formatDate(new Date(item.returnDate));
											}
											console.log(item);
											// create an <tr> element, append it to the <tbody> and cache it as a variable:
											var tr = $('<tr/>').appendTo(
													'tbody[id = shelfBody]');
											// append <td> elements to previously created <tr> element:
											tr
													.append('<td>'
															+ item.bookNumber
															+ '</td><td>'
															+ date
															+ '</td><td>'
															+ '<a class="waves-effect waves-light btn red" onclick="setBook('
															+ item.status
															+ ')">'
															+ '<i class="material-icons left">clear_all</i></a></td>');
											count++;
										});

								$('#BookShelfModal').modal('open');
							});
		}
	</script>

	<!-- 
		Script to initialize Modal 
	-->
	<script type="text/javascript">
		$(document).ready(function() {
			// the "href" attribute of the modal trigger must specify the modal ID that wants to be triggered
			$('.modal').modal();
		});
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$('select').material_select();
		});
	</script>
</body>
</html>