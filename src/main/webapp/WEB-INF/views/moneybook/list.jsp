<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="../include/header.jsp" />

<section>
	<table class="table table-hover">
		<colgroup>
			<col />
			<col />
			<col />
			<col />
			<col />
			<col width="100px;" />
		</colgroup>
		<thead>
			<tr>
				<th><input type="checkbox" id="fullCheck" name="" value=""></th>
				<th>날짜</th>
				<th>적요</th>
				<th>금액</th>
				<th>카테고리</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${tranHistory}" var="tranHistoryVO">
				<fmt:parseDate var="regdate" pattern="yyyyMMdd"
					value="${tranHistoryVO.regdate}" />
				<tr>
					<td><input type="checkbox" name="" value=""></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd(E)" value="${regdate}" /></td>
					<td>${tranHistoryVO.item}</td>
					<td class="money" data-cate-cd="${tranHistoryVO.cate_cd}"><fmt:formatNumber
							value="${tranHistoryVO.money}" pattern="#,###" />
					<td>${tranHistoryVO.cate_name}</td>
					<td><a href="#">수정</a>&nbsp;<a href="#">삭제</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</section>
<nav>
	<ul class="pagination">
		<c:if test="${pageMaker.prev}">
			<li><a href="/" aria-label="Previous"> <span
					aria-hidden="true">&laquo;</span>
			</a></li>
		</c:if>

		<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
			varStatus="i">

			<c:if test="${cri.page == i.current}">
				<li>${i.current}</li>
			</c:if>
			<c:if test="${cri.page != i.current}">
				<li><a href="#"></a>${i.current}</li>
			</c:if>

		</c:forEach>

		<c:if test="${pageMaker.next}">
			<li><a href="#" aria-label="Next"> <span aria-hidden="true">&raquo;</span>
			</a></li>
		</c:if>

	</ul>
</nav>
</div>
</div>

<c:import url="../include/footer.jsp" />
<script>
	$(function() {

		var currentPage = '${pageMaker.cri.page}';
		console.log("현재페이지: " + currentPage);
		changeMoneyColor();
		
		// 전체선택란이 체크됫으면 전체체크 else 전체선택 해제
		$("#fullCheck").on("click", function() {

			var isCheck = $("#fullCheck").prop("checked");

			if (isCheck) {
				changeChecked(isCheck);

			} else {
				changeChecked(isCheck);
			}

		});

		// 금액 색 적용하기
		function changeMoneyColor() {
			$(".money").each(function() {

				// 카테고리가 수익이면 파랑, 비용이면 빨강
				if ($(this).data("cateCd") < 20000) {
					$(this).css("color", "blue");
				} else {
					$(this).css("color", "red");
				}

			});
		}

		// 페이지 링크 클릭시 함수
		$(".pagination").on("click", "a", function(event) {

			event.preventDefault();
			var pageValue = $(this).text();
			var pageInfo=$(this).data("pageInfo");
			console.log("페이지정보 :" +pageInfo+pageValue);
			//ex)/ajax/yearTranHistory/2017/+pageValue
			getPage(pageInfo+pageValue);
			
		});

		// 연도별, 월별, 분기별 마우스 오버 이벤트

		// 특정 년도 요청
		$("")

		// 모든 체크박스 클릭 / 해제 함수
		function changeChecked(isCheck) {

			$("input[type=checkbox]").each(function() {

				$(this).prop("checked", isCheck);
			});
		}

		// 년도 버튼클릭
		$("#yearBtn").click(function() {
			console.log("년별 클릭");
			var date = prompt();
			console.log(date);
			var pageInfo = "/ajax/yearTranHistory/" + date + "/" + 1;

			getPage(pageInfo);
		});

		// 분기 버튼 클릭
		$("#quarterBtn").click(function() {
			console.log("분기 클릭");
			// ex)2017-1
			var date = prompt();

			getPage(getPageInfo("/ajax/quarterTranHistory/", date));

		});
		// 월별 버튼 클릭
		$("#monthBtn").click(function() {
			console.log("월별 클릭");
			var date = prompt();

			getPage(getPageInfo("/ajax/monthTranHistory/", date));
		});

		function getPage(pageInfo) {

			$.getJSON(pageInfo, function(data) {
				// 페이지네이션 링크 ajax처리할때 어떤요청에대한 페이지요청인지
				// 알아야되서 저장
				data.pageMaker.pageInfo = pageInfo.slice(0, -1);
				console.log(data.pageMaker);
				printData($("#list-template"), $("tbody"), data.list);
				printPaging(data.pageMaker, $(".pagination"));
			});

		}

		function printData(templateObj, target, dataArr) {

			var template = Handlebars.compile(templateObj.html());
			var html = template(dataArr);
			target.html(html);
			// 돈 색변경
			changeMoneyColor();
		}

		function printPaging(pageMaker, target) {
			var str = "";

			if (pageMaker.prev) {
				str += "<li><a href='#' aria-label='Previous'>"
						+ "<span aria-hidden='true'>&laquo;</span></a></li>"
			}

			for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
				var pageInfo = pageMaker.pageInfo;
				var strClass = pageMaker.cri.page == i ? 'class=active' : '';
				str += "<li "+strClass+"><a href='"+i+"' data-page-info='"+pageInfo+"'>" + i + "</a></li>";
			}

			if (pageMaker.next) {
				str += "<li><a href='#' aria-label='Next'><span aria-hidden='true'>"
						+ "&raquo;</span></a></li>"
			}

			target.html(str);

		}

		// month, quarter값구할때 pageInfo값 파싱
		function getPageInfo(searchItem, date) {
			var dateArr = date.split("-");
			var year = dateArr[0];
			var secondKeyword = dateArr[1];
			var pageInfo = searchItem + year + "/" + secondKeyword + "/1";
			console.log("pageInfo : " + pageInfo);
			return pageInfo;
		}

		Handlebars.registerHelper("prettifyDate", function(timeValue) {
			console.log("시간: " + timeValue);
			var week = [ "(일)", "(월)", "(화)", "(수)", "(목)", "(금)", "(토)" ];
			var year = timeValue.substring(0, 4);
			var month = timeValue.substring(4, 6);
			var date = timeValue.substring(6, 8);
			var dateValue = year + "-" + month + "-" + date;
			var day = week[new Date(dateValue).getDay()];
			return dateValue + day;
		});

		// 돈 콤마찍기
		Handlebars.registerHelper("prettifyMoney", function(moneyValue) {

			return moneyValue.toLocaleString();
		});

	});
</script>

<script id="list-template" type="text/x-handlebars-template">
{{#each .}}
	
<tr>
	<td><input type="checkbox" name="" value=""></td>
	<td>{{prettifyDate regdate}}</td>
	<td>{{item}}</td>
	<td class="money" data-cate-cd="{{cate_cd}}">{{prettifyMoney money}}</td>
	<td>{{cate_name}}</td>
	<td><a href="#">수정</a>&nbsp;<a href="#">삭제</a></td>
</tr>
{{/each}}
</script>


