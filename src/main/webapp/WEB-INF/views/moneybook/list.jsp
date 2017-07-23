<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="../include/header.jsp" />
<script src="/resources/js/page.js"></script>
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
				<th>아이템</th>
				<th>결제수단</th>
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
					<td class="payment" data-pay-code="${tranHistoryVO.pay_code}">${tranHistoryVO.payment}</td>
					<td class="money" data-cate-cd="${tranHistoryVO.cate_cd}"><fmt:formatNumber
							value="${tranHistoryVO.money}" pattern="#,###" />
					<td>${tranHistoryVO.cate_name}</td>
					<td><a href="#" class="modLink">수정</a>&nbsp;<a href="#" class="rmLink">삭제</a></td>
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
		window.pageMaker = '${pageMaker}';
		window.pageMaker.pageInfo = window.location.pathname;
		window.pageMaker.cri.page = 1;
		console.log("현재페이지: " + currentPage);
		// 돈 색변경: 수익/ 비용
		changeMoneyColor($(".money"), "blue", "red");
		// 결제수단 색변경: 카드/ 현금
		changePaymentColor($(".payment"), "green", "blue");
		
		
		// 다중삭제 처리
		$("tbody").on("click", ".rmLink", function(event) {
			event.preventDefault();
			event.stopPropagation();
			var target = $(this).parent("tr");
			var pageInfo = window.pageMaker.pageInfo;
			var currPage = window.pageMaker.cri.page;
			console.log(target);
			console.log("다중삭제 클릭: "+pageInfo+currPage);
			/* var removeList = getRemoveList($("tbody tr[class='success']"));
			var rmMethod = function(msg) {
				alert("삭제완료");
				getPage(pageInfo+currPage);
			}
			var result = confirm("삭제 하시겟습니까?");
			if(!result)return;
			sendPostAjax("/ajax/moneybook/remove", removeList, rmMethod); */
		});
		
		
		
		
		
		
		
		// 전체선택란이 체크됫으면 전체체크 else 전체선택 해제
		$("#fullCheck").on("click", function() {

			var isCheck = $("#fullCheck").prop("checked");

			if (isCheck) {
				changeChecked(isCheck);

			} else {
				changeChecked(isCheck);
			}

		});

		

		// 행을 클릭하면 활성화:비활성화 분기
		$("tbody").on("click", "tr", function() {
			console.log("tr클릭");
			var trObj = $(this);
			var classValue = $(trObj).attr("class");
			// 비활성화 됫으면 활성화 - 활성화상태면 비활성화
			var result = classValue==null?"success":null;
			$(trObj).attr("class", result);
		});
		
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
<tr data-num='{{num}}' data-cate-name="{{cate_name}}" data-item="{{item}}" data-money='{{money}}'  data-regdate='{{regdate}}' data-cate-cd='{{cate_cd}}' data-pay-code='{{pay_code}}' >
	<td><input type="checkbox" data-num='{{num}}' name="" value=""></td>
	<td>{{prettifyDate regdate}}</td>
	<td>{{item}}</td>
	<td class="payment" data-pay-code="{{pay_code}}">{{payment}}</td>
	<td class="money" data-cate-cd="{{cate_cd}}">{{prettifyMoney money}}</td>
	<td>{{cate_name}}</td>
	<td><a class="modLink" data-num='{{num}}' data-cate-name="{{cate_name}}" data-item="{{item}}" data-money='{{money}}'  data-regdate='{{regdate}}' data-cate-cd='{{cate_cd}}' data-pay-code='{{pay_code}}' href="#">수정</a>&nbsp;
	<a class='rmLink' data-num='{{num}}' data-money='{{money}}' data-cate-cd='{{cate_cd}}' data-regdate='{{regdate}}' href="#">삭제</a></td>
</tr>
{{/each}}
</script>


