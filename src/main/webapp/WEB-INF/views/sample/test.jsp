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
		var dataObj = null;
		var incList = new Array();
		var outList = new Array();
		$("button").click(function(){
			
			$.getJSON("/ajax/getCategoryList/",function(data){
			//	console.dir(data);
				$.each(data, function(){
					//console.log(this);
					if(isIncome(this)){
						incList.push(this);
					}else{
						outList.push(this);
					}
				});			
			});g
			
			$.each(incList, function(){
				console.log(this);
			});
		});
		
		function isIncome(paramObj){
			if(paramObj.cate_cd >= 20000){
				return true;
			}
			
			return false;
		}
		
	});
</script>
<title>Insert title here</title>
</head>
<body>
<button>버튼</button>
</body>
</html>