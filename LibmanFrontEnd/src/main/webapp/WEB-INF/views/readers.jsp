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
		<%@include file="shared/header.jsp"%>

		<table class="highlight responsive-table" id="readerTable">
			<thead>
				<tr>
					<th>Member Code</th>
					<th>Name</th>
					<th>E-Mail</th>
					<th>Phone</th>
					<th>Books  </th>
					<th>Edit</th>
				</tr>
			</thead>
			<tbody id="tableBody">

			</tbody>
			<tfoot>

			</tfoot>
		</table>
	</div>

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
							<form:select path="type.id" multiple="false" required="true">
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
							<form:input path="firstName" id="firstName" class="validate"
								required="true" />
							<form:label path="firstName" for="firstName"
								data-error="Required">First Name</form:label>
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
							<form:label path="email" for="email" data-error="Wrong"
								data-success="Right">E-Mail</form:label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<i class="material-icons prefix">phone</i>
							<form:input path="phone" id="phone" class="validate"
								required="true" data-length="10" minlength="10" maxlength="10" />
							<form:label path="phone" for="phone" data-error="Please Check">Phone</form:label>
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
		Modal to update book.
	 -->
	<div id="updateReaderModal" class="modal">
		<div class="modal-content">

			<div class="row">
				<div class="col s10">
					<h4>${reader.firstName}</h4>
				</div>
				<div class="col s2">
					<a href="${contextPath}/admin/deleteReader/${reader.id}"
						class="btn red"> <i class="material-icons">delete</i></a>
				</div>
			</div>

			<div class="row">
				<form:form modelAttribute="reader" class="col s12"
					action="${contextPath}/admin/updateReader" method="POST">

					<form:hidden path="id" />
					<form:hidden path="type" />

					<div class="row">
						<div class="input-field col s8">
							<i class="material-icons prefix">lock_outline</i>
							<form:input path="readerNumber" id="readerNumber" class="validate"/>
							<form:label path="readerNumber" for="readerNumber">Member Code</form:label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s6">
							<i class="material-icons prefix">account_box</i>
							<form:input path="firstName" id="firstName" class="validate"
								required="true" />
							<form:label path="firstName" for="firstName"
								data-error="Required">First Name</form:label>
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
							<form:label path="email" for="email" data-error="Wrong"
								data-success="Right">E-Mail</form:label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<i class="material-icons prefix">phone</i>
							<form:input path="phone" id="phone" class="validate"
								required="true" data-length="10" minlength="10" maxlength="10" />
							<form:label path="phone" for="phone" data-error="Please Check">Phone</form:label>
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
							<form:input path="name" type="text" id="name" class="validate"
								required="true" />
							<form:label path="name" for="name" data-error="Required">Type of Reader</form:label>
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
		Book details modal.
	 -->
	<div id="userBookDetailsModal" class="modal" style="height: 100%">
		<div class="modal-content">
			<div id="content" style="padding-top: 30px">

				<div id="loader" class="preloader-wrapper big active">
					<div class="spinner-layer spinner-blue-only">
						<div class="circle-clipper left">
							<div class="circle"></div>
						</div>
						<div class="gap-patch">
							<div class="circle"></div>
						</div>
						<div class="circle-clipper right">
							<div class="circle"></div>
						</div>
					</div>
				</div>

				<table id="tableBookDetails">
					<thead>
						<tr>
							<th>Book Number</th>
							<th>Title</th>
							<th>Return Date</th>
							<th></th>
						</tr>
					</thead>
					<tbody id="userBookDetailsTable">

					</tbody>
				</table>
			</div>
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
	<div id="fileUploadModal" class="modal">
		<div class="modal-content">

			<h5>Please follow the following format.</h5>
			<img class="responsive" width="680px"
				src="${contextPath}/resources/images/reader_exel.jpg"> <br>

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
												$('#fileUploadModal').modal('close');
												$('#loaderModal').modal('open');
												console.log('Uploading file');

												var data = new FormData();
												jQuery.each(
																jQuery('#file')[0].files,
																function(i,file) {
																	data.append('file-'+ i,file);
																});

												jQuery.ajax({
															url : '${contextPath}/admin/readers/excel/file',
															data : data,
															cache : false,
															contentType : false,
															processData : false,
															method : 'POST',
															type : 'POST', // For jQuery < 1.9
															success : function(
																	data) {
																$('#loaderModal').modal('close');
																Materialize.toast('Readers successfuly uploaded from the excel file.',4000);
																setTimeout(function(){
																	document.location.href="${contextPath}/admin/addReader";
																}, 3000);
															},
															
														}).fail(function() {
															$('#loaderModal').modal('close');
															Materialize.toast('Oops there was an error.',4000);
															setTimeout(function(){
																document.location.href="${contextPath}/admin/addReader";
															}, 3000);
														});
											});
						});
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
				if (path.indexOf('getReaderById') > -1) {
					$('#updateReaderModal').modal('open');
				}
			},1000));
		});
	</script>

	<!-- 
		Reader Save status toast script. 
	 -->
	<script type="text/javascript">
	$(document).ready(function() {
		try {
			if(${response.code} != 0){
				Materialize.toast("${response.message}", 4000);
			}
		} catch (e) {
			console.log('No responce'); 
		}
	});
	</script>

	<!-- 
		Script to populate the table
	 -->
	<script type="text/javascript">

	$(document).ready(function() {
		$('select').material_select();
	});

	var table = $('#readerTable')
	.DataTable(
			{
				ajax : {
					url : '${contextPath}/admin/getAllUsers',
					dataSrc : ''
				},
				"fnInitComplete": function(oSettings, json) {
					$(document).ready(function(){
					    $('.tooltipped').tooltip({delay: 50});
					  });
			    },
				columns : [
						{
							data : 'readerNumber'
						},
						{
							data : 'firstName'
						},
						{
							data : 'email'
						},
						{
							data : 'phone',
							mRender : function(data, type, full){
								
								return ''+data+'';
							}
						},
						{
							data : {readerNumber : 'readerNumber',id : 'id',enabled : 'enabled'},
							mRender : function(data, type, full) {
								
								if(data.enabled){
									return '<a class="waves-effect waves-light btn red tooltipped" '
									+ 'onclick="showBook('+ data.id +')" '
									+' data-position="top" data-delay="50" data-tooltip="Pending books">'
									+ '<i class="material-icons">desktop_windows</i></a>';
								}else{
									return '----';
								}
							}
						}, 
						{
							data : 'id',
							mRender : function(data, type, full) {
								
								return '<a class="waves-effect waves-light btn green tooltipped" '
								+ 'href="${contextPath}/admin/getReaderById/'+data+'"'
								+' data-position="top" data-delay="50" data-tooltip="Edit reader">'
								+ '<i class="material-icons">edit</i></a>';
							}
						} ]
			});
 

	//	Script to render book issue form in the modal.
	
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
					
	//Script to send Book issue data to the app.
	
		function issue(id) {
			var bookNumber = $('input[name = bookNumber]').val();
			var returnDate = $('input[name = returnDate]').val();
			
			$.post(
					'${contextPath}/admin/issue/book/'
							+ bookNumber + '/' + returnDate + '/' + id, function(data, status) {
						console.log(data);
						bookDetail = data;
						$('#issueBookModal').modal('close');
					}).done(
					function() {
						Materialize.toast('Book issued', 4000);
					}).fail(function (status) {
						Materialize.toast('Error : '+status, 4000);
					});
		}

	//Script to show book details of a user

	function formatDate(date) {
		var monthNames = [ "January", "February", "March", "April",
				"May", "June", "July", "August", "September",
				"October", "November", "December" ];

		var day = date.getDate();
		var monthIndex = date.getMonth();
		var year = date.getFullYear();

		return day + ' ' + monthNames[monthIndex] + ' ' + year;
	}
	
	 	function showBook(id) {
	 		
	 		$('#userBookDetailsModal').modal('open');
	 		$('div[id=loader]').show();
	 		$('table[id=tableBookDetails]').hide();
	 		
	 		console.log('id -> ' + id);
	 		
	 		var books = [];
	 		$.post('${contextPath}/admin/getBooksForUser/'+id,
	 			function (data,status) {
					books = data;
				}		
	 		).then(
	 			function() {
	 				console.log(books);
	 				$('tbody[id=userBookDetailsTable]').empty();
	 				if(books !== []){
	 					books.forEach(function(item) {
			 				var tr = $('<tr/>').appendTo(
							'tbody[id = userBookDetailsTable ]');
					
					tr.append('<td>'
									+ item.id
									+ '</td><td>'
									+ item.book.title
									+ '</td><td>'
									+ formatDate(new Date(item.returnDate))
									+ '</td><td>'
									+ '<a class="waves-effect waves-light btn green" onclick="returnBook('
									+ item.id + ',' + id
									+ ')">'
									+ '<i class="material-icons left">clear_all</i></a></td>');
			 			});
	 				}else{
	 					$('div[id=tableBookDetails]').hide();
	 					$('div[id=content]').append('<h4>No Books</h4>');
	 				}
		 			$('div[id=loader]').hide();
		 			$('table[id=tableBookDetails]').show();
				}
	 		)};
	 		
	 		
	 function returnBook(bookNumber,readerId) {
		$.post("${contextPath}/admin/returnBook/"+bookNumber+"/"+readerId,function(data,status){
			
			table.ajax.reload();
			$('#userBookDetailsModal').modal('close');
		}).done(function() {
			Materialize.toast('Book returned', 4000);
		}).fail(function(status) {
			Materialize.toast('There was an error : '+status, 4000);
		});
	}
		
	 </script>


</body>
</html>