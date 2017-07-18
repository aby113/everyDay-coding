<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<style>
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	$(function() {

		var category = {
			10010 : '월급',
			10020 : '상여금',
			10030 : '펀드/주식',
			10040 : '기타수익',
			20010 : '식비',
			20020 : '교통비',
			20030 : '주거/통신',
			20040 : '생활용품',
			20050 : '경조사비',
			20060 : '지식/문화',
			20070 : '의복/미용',
			20080 : '의료/건강',
			20090 : '여가/유흥',
			20100 : '세금/이자',
			20110 : '기타비용'
		};

		var cateObj = {
			inc_cateList : new Array(),
			out_cateList : new Array()
		};
		// 카테고리 리스트(inc_cateList,out_cateList) 초기화
		cateListInit();
		// 수익and지출 링크 동적으로 생성
		$("#incomeList").html(createCateLink(cateObj.inc_cateList));
		$("#outlayList").html(createCateLink(cateObj.out_cateList));

		function cateListInit() {
			$.each(category, function(key, value) {
				// 수익일경우 true 리턴
				if (isIncome(key)) {
					cateObj.inc_cateList.push(value);
				} else {
					cateObj.out_cateList.push(value);
				}
			});
		}

		function isIncome(cate_cd) {
			if (cate_cd < 20000)
				return true;

			return false;
		}

		// 링크 + 카테고리를 동적으로생성
		function createCateLink(categoryList) {

			var str = "";
			$.each(categoryList, function(key, value) {

				str += "<a href='#'>" + value + "</a>";
			});

			return str;
		}
	});
</script>
</head>

<body>
	<!-- Large modal -->
	<button type="button" class="btn btn-primary" data-toggle="modal"
		data-target=".bs-example-modal-lg">Large modal</button>

	<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog"
		aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">Modal title</h4>
				</div>
				<form class="registerFrm" action="/money/register" method="post">
					<input type="hidden" name="cate_cd" value=""> <input
						type="hidden" id="moneyInp" name="money" value="">
					<div class="">
						<p>날짜</p>
						<p>
							<input type="text" id="datePicker" name="regdate" value="">
						</p>
					</div>
					<div class="">
						<p>아이템</p>
						<p>
							<input type="text" name="item" value="">
						</p>
					</div>
					<div class="">
						<p>금액</p>
						<p>
							<input type="text" id="price" name="" value="">
						</p>
					</div>
					<div class="">
						<p>결제 수단</p>
						<p>
							<select name="pay_code">
								<option value="0">현금</option>
								<option value="1">카드</option>
							</select>
						</p>
					</div>
					<div class="cateBox">
						<p>카테고리</p>
						<p>
							<input type="text" id="cateInp" name="" value=""
								readonly="readonly">
						</p>
						<p>수익</p>
						<p id="incomeList"></p>
						<p>비용</p>
						<p id="outlayList"></p>
					</div>
				</form>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary">수정하기</button>
				</div>


			</div>
		</div>
	</div>

</body>
</html>