<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<link href="/resources/bootstrap-3.3.2-dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/bootstrap-3.3.2-dist/css/bootstrap-theme.min.css" rel="stylesheet">
<script type="text/javascript" src="/resources/bootstrap-3.3.2-dist/js/bootstrap.min.js"></script>
<style type="text/css">
table{
width : 
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table class="table table-bordered">
	<colgroup>
		<col width="3%">
		<col width="70%">
	</colgroup>	
	<tr class="success"><th>코드</th><th>카테고리명</th></tr>
	<c:forEach items="${list}" var="vo">
	<tr><td>${vo.cate_cd}</td><td> ${vo.cate_name}</td></tr>
	</c:forEach>
	</table>

</body>
</html>