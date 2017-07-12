<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="../include/header.jsp" />
<script src="/resources/jquery-number-master/jquery.number.js"></script>
<script src="/resources/js/page.js"></script>
<script type="text/javascript">
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
		$(".white_block").css("height", "456");
		// 콤마찍기
		$('#price').number(true);
		// 수익and지출 링크 동적으로 생성
		$("#incomeList").html(createCateLink(cateObj.inc_cateList));
		$("#outlayList").html(createCateLink(cateObj.out_cateList));
		// 최초 진입시에 getPage호출
		getPage("/ajax/moneybookList/1");
		
		// 버그 리스트 갱신 안됨
		$("#addBtn").click(function(){
			register();
			getPage("/ajax/moneybookList/1");
		});
		
		//getCateList();
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
		
		// 전송
		function register(pageInfo){
			var item = $("input[name=item]").val();
			var regdate = $("input[name=regdate]").val();
			var pay_code = $("select[name=pay_code]").val();
			var cate_cd = $("input[name=cate_cd]").val();
			var pageInfo = getPageInfo(cate_cd);
			var money = $("#price").val();
			console.log("카테고리값: "+ cate_cd);
			console.log("돈체크:"+money);
			// 수익OR비용 여부에따라 동적으로 name 변경 AND 컴마제거
			changeMoneyName($("#moneyInp"),	money, cate_cd);
			
			
			
			$.ajax({
				type : 'post',
				url : pageInfo,
				headers : {
					"Content-Type":"application/json",
					"X-HTTP-Method-Override":"POST"
				},
				dataType : 'text',
				data : JSON.stringify({
					item : item,
					regdate : regdate,
					pay_code : pay_code,
					cate_cd : cate_cd,
					money : money
				}),
				success : function(msg){
					//alert("글저장완료");
					console.log("작성후 페이지호출");
					//getPage("/ajax/moneybookList/1");					
				}
				
			});
			
		}

		$("#datePicker").datepicker(
				{
					dateFormat : "yy-mm-dd",
					dayNames : [ '월요일', '화요일', '수요일', '목요일', '금요일', '토요일',
							'일요일' ],
					dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
					monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8',
							'9', '10', '11', '12' ],
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
							'8월', '9월', '10월', '11월', '12월' ]
				});

		// 링크 클릭시 카테고리값 입력
		$("div.cateBox").on("click", "p a", function(event) {
			event.preventDefault();
			var linkValue = $(this).text();
			var cateName = $("#cateInp").val(linkValue);
			console.log(findCateName(linkValue));
			$("input[name=cate_cd]").val(findCateName(linkValue));

		});

		// 카테고리 값으로 해당 키를 리턴
		function findCateName(linkValue) {
			var result = "";
			$.each(category, function(key, value) {

				if (linkValue === value) {
					result = key;
				}
			});
			return result;
		}

		// 카테고리에 따라 url이 달라짐
		function getPageInfo(cate_cd){
			var url = "/money/register/outlay";
			if(isIncome(cate_cd))return url = "/money/register/income";
			return url;			
		}
		
		// 링크 + 카테고리를 동적으로생성
		function createCateLink(categoryList) {

			var str = "";
			$.each(categoryList, function(key, value) {

				str += "<a href='#'>" + value + "</a>";
			});

			return str;
		}

		function getCateList() {
			$.getJSON("/ajax/getCategoryList", function(data) {
				$.each(data, function(key, value) {
					if (isIncome(key)) {
						inc_cateList.push(value);
					} else {
						out_cateList.push(value);
					}

				});

			});
		}
		
		// 비용 OR 수익에따라 가격 param이름이 바뀜
		// 해당 value값에 컴마가 제거된 숫자가들어감
		function changeMoneyName($target, money, cate_cd) {
			var paramName = "cost";
			// 수익 카테고리를 클릭햇는지 검사 
			if(isIncome(cate_cd))paramName = "revenue";
			// 수익 = revenue, 비용 = cost
			$target.attr("name", paramName);
			$target.val(uncomma(money));
		}

		function isIncome(cate_cd){
			if (cate_cd < 20000)return true;
			
			return false;
		}
		
		function uncomma(price) {
			return price.replace(/\,/g, '');
		}

	});
</script>
<style media="screen">
div.cateBox a {
	margin-right: 10px;
}

div.listBox {
	margin-left: 100px;
	margin-top: 10px;
	padding: 10px;
	width: 1000px;
	height: 1000px;
	background-color: white;
}
</style>

<section>
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
				<input type="text" id="cateInp" name="" value="" readonly="readonly">
			</p>
			<p>수익</p>
			<p id="incomeList"></p>
			<p>비용</p>
			<p id="outlayList"></p>
		</div>
		<input type="button" id="addBtn" name="" value="전송">
	</form>

</section>

</div>
<div class="listBox">

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