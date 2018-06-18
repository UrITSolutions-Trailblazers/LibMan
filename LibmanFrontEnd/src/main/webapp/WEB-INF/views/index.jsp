<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<!--Let browser know website is optimized for mobile-->
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home</title>
</head>
<body>

	<div class="container">
		<%@include file="shared/header.jsp"%>
		<br />
		<security:authorize access="isAnonymous()">

			<center>
				<div class="row">
					<div class="col s0 m2"></div>
					<div class="col s12 m8">
						<div class="card">
							<div class="row">
								<div class="col s5">
									<div class="card-image">
										<img src="resources/images/lib.png">
									</div>
								</div>
								<div class="col s7">
									<div class="card-content">
										<div class="row">
											<form class="col s12" action="login" method="post">
												<div class="row">
													<div class="input-field col s12">
														<input id="username" name="username" type="text"
															class="validate"> <label for="username">Username</label>
													</div>
												</div>
												<div class="row">
													<div class="input-field col s12">
														<input id="password" name="password" type="password"
															class="validate"> <label for="password">Password</label>
													</div>
												</div>
												<div class="row">
													<div class="input-field col s11">
														<input class="btn" type="submit" value="Login">
													</div>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</center>

		</security:authorize>

		<security:authorize access="isAuthenticated()">


			<div class="row">
				<div class="input-field col s4 m4">
					<input name="min" id="min" type="text"> <label for="min">From
						Return Date (MM/DD/YYYY)</label>
				</div>
				<div class="input-field col s4 m4">
					<input name="max" id="max" type="text"> <label for="max">To
						Return Date (MM/DD/YYYY)</label>
				</div>
				<div class="col s4 m4">
					<button id="rd_rearch" class="btn waves-effect">
						<i class="material-icons">search</i>
					</button>
				</div>
			</div>

			<table class="highlight responsive-table" id="homeTable">
				<thead>
					<tr>
						<th>Book Number</th>
						<th>Book Name</th>
						<th>Issue Date</th>
						<th>Return Date</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody id="tableBody">

				</tbody>
				<tfoot>

				</tfoot>
			</table>
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
			<div id="userDetailsModal" class="modal" style="height: 100%">
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

						<table id="tableUserDetails">
							<thead>
								<tr>
									<th>Reader Number</th>
									<th>Name</th>
									<th>Phone</th>
								</tr>
							</thead>
							<tbody id="userDetailsTable">

							</tbody>
						</table>
					</div>
				</div>

				<div class="modal-footer">
					<div id="returnBtn"></div>
					<a href="#!"
						class="modal-action modal-close waves-effect waves-green btn-flat">Close</a>
				</div>
			</div>

		</security:authorize>
	</div>
	<script type="text/javascript">
		function myFormatDate(date) {
			var monthNames = [ "January", "February", "March", "April", "May",
					"June", "July", "August", "September", "October",
					"November", "December" ];

			var day = date.getDate();
			var monthIndex = date.getMonth();
			var year = date.getFullYear();

			return day + ' ' + monthNames[monthIndex] + ', ' + year;
		}

		function formatDate(date) {
			var monthNames = [ "January", "February", "March", "April", "May",
					"June", "July", "August", "September", "October",
					"November", "December" ];
			if (date.getDate() < 10) {
				var day = '0' + date.getDate();
			} else {
				var day = date.getDate();
			}
			if (date.getMonth() < 10) {
				var month = date.getMonth() + 1;
				var monthIndex = '0' + month;

			} else {
				var month = date.getMonth() + 1;
				var monthIndex = month;
			}

			var year = date.getFullYear();

			return monthIndex + '/' + day + '/' + year;
		}

		var table = $('#homeTable')
				.DataTable(
						{
							autoFill : true,
							responsive : true,
							ajax : {
								url : '${contextPath}/admin/getBookDetailsData',
								dataSrc : ''
							},
							columns : [
									{
										data : 'bookNumber'
									},
									{
										data : 'book.title'
									},
									{
										data : {
											issueDate : 'issueDate',
											id : 'id'
										},
										mRender : function(data, type, full) {
											if (data.issueDate == null) {
												return '<div id = "id_'+data.id+'">'
														+ '' + '</div>';
											}
											return '<div id = "id_'+data.id+'">'
													+ formatDate(new Date(
															data.issueDate))
													+ '</div>';
										}
									},
									{
										data : {
											returnDate : 'returnDate',
											id : 'id'
										},
										mRender : function(data, type, full) {
											if (data.returnDate == null) {
												return '<div id = "rd_'+data.id+'">'
														+ '' + '</div>';
											}
											return '<div id = "rd_'+data.id+'">'
													+ formatDate(new Date(
															data.returnDate))
													+ '</div>';
										}
									},
									{

										data : {
											status : 'status',
											id : 'id'
										},
										mRender : function(data, type, full) {
											var statusButton = '';
											if (data.status == true) {
												statusButton = '<button id ="re'
														+ data.id
														+ '" onclick="returnBookConfirmation('
														+ data.id
														+ ')" '
														+ 'class="waves-effect waves-light btn red">ISSUED</button>'
											} else {
												statusButton = '<button id ="av'
														+ data.id
														+ '" onclick="issueBook('
														+ data.id
														+ ')" '
														+ 'class="waves-effect waves-light btn ">AVAILABLE</button>'
											}

											return statusButton;
										}
									} ]
						});

		$(document).ready(function() {
			$.fn.dataTable.ext.search.push(function(settings, data, dataIndex) {
				var min = $('#min').val();
				var max = $('#max').val();
				var startDate = new Date(data[3]);

				if (max === "" && min === "") {
					//console.log('No Val');
					return true;
				}
				if (startDate <= new Date(max) && startDate >= new Date(min)) {
					//console.log('filtering');
					return true;
				}
				//console.log('skipped');
				return false;
			});

			var table = $('#homeTable').DataTable();

			// Event listener to the two range filtering inputs to redraw on input
			$('button[id="rd_rearch"]').on('click', function() {

				table.draw();
			});
		});

		$(document).ready(function() {
			// the "href" attribute of the modal trigger must specify the modal ID that wants to be triggered
			$('.modal').modal();

		});

		function issueBook(id) {
			var returnDate = new Date();
			var rDateConst = new Date();
			rDateConst.setDate(rDateConst.getDate() + 15);

			$('#issueBookForm').empty();
			$('#issueBookForm')
					.append(
							'<div class="row">'
									+ '<div class="input-field col s12">'
									+ '	<input type="text" name="readerNumber"> <label'+
					'		for="readerNumber">Reader Number</label>'
									+ '</div>'
									+ '</div>'
									+ '<div class="row">'
									+ '	<div class="input-field col s12">'
									+ '		<input type="text" value = "'
									+ myFormatDate(rDateConst)
									+ '" name="returnDate" class="datepicker"> <label'+
				'			for="returnDate" class = "active">Return Date</label>'
									+ '	</div>'
									+ '</div>'
									+ '<div class="row">'
									+ '	<div class="input-field col s11">'
									+ '		<input class="btn" type="button" value="Issue" onclick="issue('
									+ id + ')">' + '	</div>' + '</div>');
			$('.datepicker').pickadate({
				selectMonths : true, // Creates a dropdown to control month
				selectYears : new Date().getFullYear(), // Creates a dropdown of 15 years to control year,
				today : 'Today',
				clear : 'Clear',
				close : 'Ok',
				closeOnSelect : false
			// Close upon selecting a date,
			});

			$('#issueBookModal').modal('open');
		}

		function issue(bookId) {
			var bookDetail;
			var readerId = $('input[name="readerNumber"]').val();
			console.log('BookId -> ' + bookId);
			console.log('ReaderNumber -> ' + readerId);

			var returnDate = $('input[name = returnDate]').val();

			console.log('Return date => ' + returnDate);

			$.post(
					'${contextPath}/admin/issue/book/' + bookId + '/'
							+ returnDate + '/' + readerId,
					function(data, status) {
						console.log(data);
						bookDetail = data;

					}).done(function() {
				/* $('button[id="av' + bookId + '"]')
						.replaceWith(
								'<button id ="re'
										+ bookId
										+ '" onclick="returnBookConfirmation('
										+ bookId
										+ ')" '
										+ 'class="waves-effect waves-light btn red">ISSUED</button>');

				$('div[id="id_' + bookId + '"]').replaceWith(
						'<div id = "id_'+bookId+'">'
								+ formatDate(new Date())
								+ '</div>');

				$('div[id="rd_' + bookId + '"]').replaceWith(
						'<div id = "rd_'+bookId+'">'
								+ formatDate(new Date(
										bookDetail.returnDate))
								+ '</div>'); */
				$('#issueBookModal').modal('close');
				Materialize.toast('Book issued', 4000);
				table.ajax.reload();

			}).fail(function(status) {
				Materialize.toast('Error : ' + status, 4000);
			});

			$('#issueBookModal').modal('close');

		}

		function returnBookConfirmation(bookId) {

			$('#userDetailsModal').modal('open');
			$('div[id=loader]').show();
			$('table[id=tableUserDetails]').hide();

			var user = {};
			$.post('${contextPath}/admin/getUserByBookNumber/' + bookId,
					function(data, status) {
						user = data.user;

					}).then(
					function() {

						$('tbody[id=userDetailsTable]').empty();
						var tr = $('<tr/>').appendTo(
								'tbody[id = userDetailsTable ]');

						tr.append('<td>' + user.readerNumber + '</td><td>'
								+ user.firstName + '</td><td>' + user.phone
								+ '</td>')
						$('div[id="returnBtn"]').empty();
						$('div[id="returnBtn"]').append(
								'<a class=" waves-effect waves-green'
										+ ' btn red" onclick="returnBook('
										+ bookId + ',' + user.id
										+ ')">Return Book</a>');

						$('div[id=loader]').hide();
						$('table[id=tableUserDetails]').show();
					})
		}

		function returnBook(bookNumber, readerId) {
			var bookId = bookNumber;
			$.post(
					"${contextPath}/admin/returnBook/" + bookNumber + "/"
							+ readerId, function(data, status) {
						$('#userBookDetailsModal').modal('close');
					}).done(function() {
				$('#userDetailsModal').modal('close');
				Materialize.toast('Book returned', 4000);

				table.ajax.reload();

				/* $('button[id="re' + bookId + '"]')
						.replaceWith(
								'<button id ="av'
										+ bookId
										+ '" onclick="issueBook('
										+ bookId
										+ ')" '
										+ 'class="waves-effect waves-light btn ">AVAILABLE</button>');

				$('div[id="id_' + bookId + '"]').replaceWith(
						'<div id = "id_'+bookId+'">' + ''
								+ '</div>');

				$('div[id="rd_' + bookId + '"]').replaceWith(
						'<div id = "rd_'+bookId+'">' + ''
								+ '</div>'); */

			}).fail(function(status) {
				$('#userDetailsModal').modal('close');
				Materialize.toast('There was an error : ' + status, 4000);
			});
		}
	</script>

</body>
</html>
