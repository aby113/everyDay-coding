<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<style media="screen">
.wrap {
	margin: 0px;
	padding-top: 20px;
	width: 2000px;
	height: 2000px;
	text-align: center;
	background-color: gray;
}

.white_block {
	margin-left: 200px;
	margin-top: 10px;
	padding: 10px;
	width: 1000px;
	height: 1000px;
	background-color: white;
}

.item>li {
	list-style: none;
	float: left;
	margin-left: 15px;
	margin-right: 90px;
	margin-top: 20px;
}

li {
	width: 16.6666% height: 70px;
}

img {
	margin: 0px;
	padding: 0px;
}

a {
	text-decoration: none !important
}

div.nav {
	border-bottom: 1px solid blue;
}

.header {
	width: 100%;
	height: 50px;
	background-color: green;
}

form div {
	border: 1px solid blue;
	float: left;
	margin: 5px;
}

.insert1 {
	width: 10%;
}

.insert2 {
	width: 130px;
}

.insert3 {
	width: 115spx;
}

.category {
	width: 500px;
}

.clear {
	clear: both;
}

.insert4 {
	float: left;
	width: 40%;
	display: inline;
}

.insert5 {
	float: left;
	width: 40%;
}

input {
	width: 100%;
}

table, th, td {
	text-align: center !important;
}

.btn-group {
	float: right;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">

<title>Jumbotron Template for Bootstrap</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Bootstrap core CSS -->
<link href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/resources/bootstrap-3.3.2-dist/css/jumbotron.css"
	rel="stylesheet">

<!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
<!--[if lt IE 9]><script src="//assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
<script
	src="/resources/bootstrap-3.3.2-dist/js/ie-emulation-modes-warning.js"></script>

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>

				<a class="navbar-brand" href="#">HOME</a> <a class="navbar-brand"
					href="#">게시판</a> <a class="navbar-brand" href="#">도움말</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<form class="navbar-form navbar-right">
					<div class="form-group">
						<input type="text" placeholder="ID" class="form-control">
					</div>
					<div class="form-group">
						<input type="password" placeholder="Password" class="form-control">
					</div>
					<button type="submit" class="btn btn-success">로그인</button>
				</form>
			</div>
			<!--/.navbar-collapse -->

		</div>
	</nav>

	<!-- Main jumbotron for a primary marketing message or call to action -->
	<div class="wrap">

		<div class="white_block">
			<div class="nav">
				<ul class="item">
					<li><a href="#"><img src="/resources/imgs/exam.png">
							<p>거래입력</p> </a></li>
					<li><a href="/money/list"><img
							src="/resources/imgs/exam.png">
							<p>거래내역</p> </a></li>
					<li><a href="#"><img src="/resources/imgs/exam.png">
							<p>수익</p> </a></li>
					<li><a href="#"><img src="/resources/imgs/exam.png">
							<p>비용</p> </a></li>
					<li><a href="#"><img src="/resources/imgs/exam.png">
							<p>비용수익</p> </a></li>
					<li><a href="#"><img src="/resources/imgs/exam.png">
							<p>신용카드</p> </a></li>
				</ul>
			</div>
			<div class="header">
				<div class="btn-group" role="group" aria-label="...">
					<button type="button" id="yearBtn" class="btn btn-default">년도별</button>
					<button type="button" id="quarterBtn" class="btn btn-default">분기별</button>
					<button type="button" id="monthBtn" class="btn btn-default">월별</button>
				</div>
			</div>

			