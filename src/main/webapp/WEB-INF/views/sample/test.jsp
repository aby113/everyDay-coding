<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	$(function() {
		var incObj = new Array();
		var outObj = new Array();

		$("button").click(function() {

			for (var i = 0; i <= 10; i++) {
				incObj.push(Math.floor(Math.random() * 100));
				outObj.push(Math.floor(Math.random() * 100));
			}

			$.ajax({
				type : "post",
				url : "/ajax/moneybook/remove",
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				data : JSON.stringify({
					inc_numbers : incObj,
					out_numbers : outObj
				}),
				success : function(msg) {
					alert(msg);
				}
			});
		});
	});
</script>
<title>Insert title here</title>
</head>
<body>
<button>버튼</button>
</body>
</html>