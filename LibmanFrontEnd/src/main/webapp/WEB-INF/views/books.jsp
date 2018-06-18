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
		<%@include file="shared/header.jsp"%>
		<table class="highlight responsive-table" id="booksTable">
			<thead>
				<tr>
					<th style="width: 24%">Book Name</th>
					<th style="width: 13%">Genre</th>
					<th style="width: 21%">Author</th>
					<th style="width: 10%">YOP</th>
					<th style="width: 32%">Status</th>
				</tr>
			</thead>
			<tbody id="tableBody">

			</tbody>
			<tfoot>

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
			<!-- <li><a class="btn-floating red"><i class="material-icons">insert_chart</i></a></li> -->
			<li><a class="btn-floating yellow darken-1 tooltipped"
				onclick="$('#fileUploadModal').modal('open');" data-position="top"
				data-delay="30" data-tooltip="Add using excel file"><i
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
				<form:form modelAttribute="bookDetail" class="col s12"
					action="${contextPath}/admin/addNewBook" method="POST">
					<form:hidden path="book.id" />
					<div class="row">
						<div class="input-field col s12">
							<form:input path="bookNumber" id="bookNumber" class="validate" required="true" />
							<form:label path="bookNumber" for="bookNumber">Book Number</form:label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<form:input path="book.title" id="title" class="validate"
								required="true" />
							<form:label path="book.title" for="title" data-error="Required">Title</form:label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<form:input path="book.auther" id="auther" class="validate"
								required="true" />
							<form:label path="book.auther" for="auther" data-error="Required">Author</form:label>
						</div>
					</div>
					<div class="row">
						<div class=" col s12">
							<label data-error="Required">Genre</label>
							<form:select path="book.category.id" multiple="false" required="true">
								<option value="" disabled selected>Choose your option</option>
								<form:options items="${categories}" itemLabel="category"
									itemValue="id" />
							</form:select>

						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<form:input path="book.price" id="price" class="validate"
								required="true" />
							<form:label path="book.price" for="price" data-error="Required">Price</form:label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<form:input path="book.yearOfPub" id="yearOfPub" class="validate"
								required="true" />
							<form:label path="book.yearOfPub" for="yearOfPub"
								data-error="Required">Year Of Publication</form:label>
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
		Modal to update book.
	 -->
	<div id="updateBookModal" class="modal">
		<div class="modal-content">
			<div class="row">
				<div class="col s10">
					<h4>${updateBook.title}</h4>
				</div>
				<div class="col s2">
					<a href="${contextPath}/admin/delete/book/${updateBook.id}"
						class="btn red"> <i class="material-icons">delete</i></a>
				</div>
			</div>
			<div class="row">
				<form:form modelAttribute="updateBook" class="col s12"
					action="${contextPath}/admin/update/book" method="POST">
					<form:hidden path="id" />
					<%-- <div class="row">
						<div class="input-field col s12">
							<form:input path="id" id="bookNumber" class="validate" required="true" />
							<form:label path="id" for="bookNumber">Book Number</form:label>
						</div>
					</div> --%> 
					<div class="row">
						<div class="input-field col s12">
							<form:input path="title" id="title" class="validate"
								required="true" />
							<form:label path="title" for="title" data-error="Required">Title</form:label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<form:input path="auther" id="auther" class="validate"
								required="true" />
							<form:label path="auther" for="auther" data-error="Required">Author</form:label>
						</div>
					</div>
					<div class="row">
						<div class=" col s12">
							<label data-error="Required">Genre</label>
							<form:select path="category.id" multiple="false" required="true">
								<option value="" disabled selected>Choose your option</option>
								<form:options items="${categories}" itemLabel="category"
									itemValue="id" />
							</form:select>

						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<form:input path="price" id="price" class="validate"
								required="true" />
							<form:label path="price" for="price" data-error="Required">Price</form:label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<form:input path="yearOfPub" id="yearOfPub" class="validate"
								required="true" />
							<form:label path="yearOfPub" for="yearOfPub"
								data-error="Required">Year Of Publication</form:label>
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
								class="validate" required="true" />
							<form:label path="category" for="category" data-error="Required">Category</form:label>
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
						<input id="bookNumber" type="text" name="bookNumber"
							class="validate" required="true" /> <label for="bookNumber"
							data-error="Required">Book Number</label>
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
						<th>Delete</th>
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
		Modal for pre-loader.
	 -->
	<div id="loaderModal" class="modal" style="height: auto;">
		<div class="modal-content">
			<center>
				<img alt="" src="${contextPath}/resources/images/spinner.gif">
			</center>
		</div>
		<div class="modal-footer"></div>
	</div>


	<!-- 
		Modal for file upload.
	 -->
	<div id="fileUploadModal" class="modal" style="width:900px">
		<div class="modal-content">
			<h5>Please follow the following format.</h5>
			<img class="responsive" height="65px" width="860px" src="${contextPath}/resources/images/book_exel.jpg">
			<br>

			<h6>Excel should be saved as -> "Excel 97-2003 Workbook"</h6>

			<br>
			<form>
				<div class="file-field input-field">
					<div class="btn">
						<span>File</span> <input type="file" id="file">
					</div>
					<div class="file-path-wrapper">
						<input class="file-path validate"
							placeholder="Upload EXcel file here" type="text">
					</div>
				</div>
				<div class="file-field input-field">
					<input id="upload" type="button" value="upload" class="btn red"
						style="float: right;">
				</div>
			</form>

		</div>
		<div class="modal-footer"></div>
	</div>

	<!-- 
		Script to add books by Excel file
	 -->
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$('input[id=upload]')
									.click(
											function() {
												$('#fileUploadModal').modal(
														'close');
												$('#loaderModal').modal('open');
												console.log('Uploading file');

												var data = new FormData();
												jQuery
														.each(
																jQuery('#file')[0].files,
																function(i,
																		file) {
																	data
																			.append(
																					'file-'
																							+ i,
																					file);
																});

												jQuery
														.ajax(
																{
																	url : '${contextPath}/admin/books/excel/file',
																	data : data,
																	cache : false,
																	contentType : false,
																	processData : false,
																	method : 'POST',
																	type : 'POST', // For jQuery < 1.9
																	success : function(
																			data) {
																		$(
																				'#loaderModal')
																				.modal(
																						'close');
																		Materialize
																				.toast(
																						'Books successfuly uploaded from the excel file.',
																						4000);
																		setTimeout(
																				function() {
																					document.location.href = "${contextPath}/admin/addBook";
																				},
																				3000);

																	},

																})
														.fail(
																function() {
																	$(
																			'#loaderModal')
																			.modal(
																					'close');
																	Materialize
																			.toast(
																					'Oops there was an error.',
																					4000);
																	setTimeout(
																			function() {
																				document.location.href = "${contextPath}/admin/addBook";
																			},
																			3000);
																});
											});
						});
	</script>

	<!-- 
		Script to populate the table
	 -->
	<script type="text/javascript">
		$('#booksTable')
				.DataTable(
						{
							ajax : {
								url : '${contextPath}/admin/getBookData',
								dataSrc : ''
							},
							"fnInitComplete" : function(oSettings, json) {
								$(document).ready(function() {
									$('.tooltipped').tooltip({
										delay : 50
									});
								});
							},
							columns : [
									{
										data : 'title'
									},
									{
										data : 'category.category'
									},
									{
										data : 'auther'
									},
									{
										data : 'yearOfPub'
									},
									{
										data : 'id',
										mRender : function(data, typr, full) {
											return '<a class="waves-effect waves-light btn btn-small red tooltipped" data-position="top"'
													+ 'data-delay="30" data-tooltip="Add book to shelf" onclick="setBook('
													+ data
													+ ')">'
													+ '<i class="large material-icons">clear_all</i></a><span>     </span>'
													+ '<a class="waves-effect waves-light btn btn-small green tooltipped" data-position="top" data-delay="30" data-tooltip="All Books" onclick="getBooksFromShelf('
													+ data
													+ ')">'
													+ '<i class="large material-icons">dvr</i></a><span>     </span>'
													+ '<a class="waves-effect waves-light btn btn-small blue" href="${contextPath}/admin/getBookById/'+data+'">'
													+ '<i class="large material-icons">edit</i></a>';
										}
									} ]
						});
	</script>

	<script type="text/javascript">
		var bookid = 0;
		function setBook(id) {
			$.post('${contextPath}/admin/addBookToShelf/' + id,
					function(data, status) {
						console.log(data);
						bookDetail = data;
					}).then(
					function() {
						Materialize.toast('Book added to shelf: '
								+ bookDetail.bookNumber, 4000);
					});

		}

		function addBookToShelf() {
			var id = $('input[name="bookNumber"]').val();
			console.log(id);
			/* $.post('${contextPath}/admin/addBookToShelf/' + bookid + '/' + id,
					function(data, status) {
						console.log(data);
						bookDetail = data;
					}).then(
					function() {
						Materialize.toast('Book added to shelf: '
								+ bookDetail.bookNumber, 4000);
					}); */
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

			$.post('${contextPath}/admin/getBooksFromShelf/' + id,
					function(data, status) {
						array = data;
						console.log(array);
					}).then(
					function() {
						$('tbody[id = shelfBody]').empty();
						$('div[id = title]').empty();
						$('div[id = title]').append(
								'<h4 class = "">' + array[0].book.title
										+ '</h4>');
						var count = 0;
						array.forEach(function(item) {

							var date = '';
							if (item.returnDate == null) {
								date = '--';
							} else {
								date = formatDate(new Date(item.returnDate));
							}
							console.log(item);
							// create an <tr> element, append it to the <tbody> and cache it as a variable:
							var tr = $('<tr/>').appendTo(
									'tbody[id = shelfBody]');
							// append <td> elements to previously created <tr> element:
							tr.append('<td>' + item.bookNumber + '</td><td>' + date
									+ '</td><td><button onclick="deleteBookDetail(' + item.id + ')" class="btn red"> <i class="material-icons">delete</i></button>');
							count++;
						});

						$('#BookShelfModal').modal('open');
					});
		}
		
		
		function deleteBookDetail(id){
			var message;
			$.post('${contextPath}/admin/delete/bookDetail/' + id,
					
					function(data, status) {
						message = data.message;
					}).done(function(){
						
						Materialize.toast(message, 4000);
						
						$('#BookShelfModal').modal('close');
					}).fail(function(){
						
						Materialize.toast('Opps something went wrong.', 4000);
						
						$('#BookShelfModal').modal('close');
					})
		}

		/*
		 * Function to get book to edit.
		 * */

		/* 
		function getBooksForEdit(id) {
		
		var book = {};
		
		$.post('${contextPath}/admin/getBookById/' + id,function(data,status){
			book = data;
		}).done(function (){
		
			$('#id').val(book.id);
			$('#title').val(book.title);
			$('#auther').val(book.auther);
			$('#price').val(book.price);
			$('#yearOfPub').val(book.yearOfPub.value);
			$('#cat').val(book.category.id);
			
			console.log('Book -> '+JSON.stringify(book));
			
			$('#addBookModal').modal('open');
		}).fail(function () {
			
		});
		} */
	</script>

	<!-- 
		Script to initialize Modal 
	-->
	<script type="text/javascript">
		$(document).ready(function() {
			// the "href" attribute of the modal trigger must specify the modal ID that wants to be triggered
			$('.modal').modal();
			$(setTimeout(function() {
				var path = window.location.href;
				if (path.indexOf('getBookById') > -1) {
					$('#updateBookModal').modal('open');
				}
			}, 1300));
		});
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$('select').material_select();
		});
	</script>
</body>
</html>