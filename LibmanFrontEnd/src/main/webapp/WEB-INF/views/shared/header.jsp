<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<link
	href="${contextPath}/resources/materialize/fonts/material-icons.css"
	rel="stylesheet">
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet"
	href="${contextPath}/resources/materialize/css/materialize.min.css"
	media="screen,projection" />
<link rel="stylesheet" type="text/css"
	href="${contextPath}/resources/Datatable/datatables.css">


<!--Let browser know website is optimized for mobile-->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

</head>
<body>
	<script type="text/javascript"
		src="${contextPath}/resources/materialize/jquery-3.2.1.min.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/materialize/js/materialize.min.js"></script>
	<script type="text/javascript"
		src="${contextPath}/resources/angular/angular.min.js"></script>
	<script type="text/javascript" charset="utf8"
		src="${contextPath}/resources/Datatable/datatables.min.js"></script>
	<nav class="navbar-fixed">
	<div class="nav-wrapper"> 
		<a href="#" class="brand-logo left"><i><img
			src="${contextPath}/resources/images/madrasLogo.png" height="65px"
			width="65px"></i>Madras Cricket Club</a> <!-- <a href="#"
			class="brand-logo left"><i class="large material-icons">local_library</i>LibMan</a> -->
		<ul id="nav-mobile" class="right hide-on-med-and-down">
			<li></li>
			<li><a href="${contextPath}/home"><i
					class="large material-icons left"> home </i>Home</a></li>

			<security:authorize access="isAuthenticated()">
				<li><a href="${contextPath}/admin/addBook"><i
						class="large material-icons left">storage</i>Book Master</a></li>
				<li><a href="${contextPath}/admin/addReader"><i
						class="large material-icons left">people_outline</i>Reader Master</a></li>
				<li><a href="${contextPath}/logout">Logout</a></li>
			</security:authorize>
		</ul>
	</div>
	</nav>

</body>
</html>
