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
		var checkboxArr = new Array();
		$(".white_block").css("height", "456");
		// 콤마찍기
		$('#price').number(true);
		// 수익and지출 링크 동적으로 생성
		$(".incomeList").html(createCateLink(cateObj.inc_cateList));
		$(".outlayList").html(createCateLink(cateObj.out_cateList));
		// 최초 진입시에 getPage호출
		getPage("/ajax/moneybookList/1");

		$("#addBtn").click(function() {
			register();
		});

		$("tbody tr td").on("click", ".modLink", function(event) {
			event.preventDefault();
			console.log("modLink 실행");
			$("#mymodal").modal('toggle');
		});

		// test
		$("tbody").on("click", ".rmLink", function(event) {
			event.preventDefault();
			console.log("삭제 링크 클릭");
			var incList = new Array();
			var outList = new Array();

			$("tbody tr[class='success']").each(function() {
				// 수익이면 true 리턴
				console.log("반복문 체크");
				if (isIncome($(this).data("cate_cd"))) {
					var incomeDTO = new IncomeDTO();
					incomeDTO.init($(this).data());
					incList.push(incomeDTO);
				} else {
					var outlayDTO = new OutlayDTO();
					outlayDTO.init($(this).data());
					outList.push(outlayDTO);
				}

			});

			console.log("dto객체 확인");
			console.log(incList);
			console.log(outList);
			$.ajax({
				type : "post",
				url : "/ajax/moneybook/remove",
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				data : JSON.stringify({
					incList : incList,
					outList : outList
				}),
				success : function(msg) {
					alert("삭제완료");
					console.log("currentPage :" + currentPage);
					getPage("/ajax/moneybookList/"+currentPage);
				}

			});

		});

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

		function sendAjax(url, dataObj, method) {

			$.ajax({
				type : "post",
				url : url,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				data : JSON.stringify(dataObj),
				success : method

			});

		}

		// 전송
		function register(pageInfo) {
			var item = $("input[name=item]").val();
			var regdate = $("input[name=regdate]").val();
			var pay_code = $("select[name=pay_code]").val();
			var cate_cd = $("input[name=cate_cd]").val();
			var pageInfo = getPageInfo(cate_cd);
			var money = $("#price").val();
			console.log("카테고리값: " + cate_cd);
			console.log("돈체크:" + money);
			// 수익OR비용 여부에따라 동적으로 name 변경 AND 컴마제거
			//changeMoneyName($("#moneyInp"), money, cate_cd);

			$.ajax({
				type : 'post',
				url : pageInfo,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				data : JSON.stringify({
					item : item,
					regdate : regdate,
					pay_code : pay_code,
					cate_cd : cate_cd,
					money : money
				}),
				success : function(msg) {
					alert("글저장완료");
					console.log("작성후 페이지호출");
					getPage("/ajax/moneybookList/1");
					$(".registerFrm")[0].reset();

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
		function getPageInfo(cate_cd) {
			var url = "/money/register/outlay";
			if (isIncome(cate_cd))
				return url = "/money/register/income";
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
			if (isIncome(cate_cd))
				paramName = "revenue";
			// 수익 = revenue, 비용 = cost
			$target.attr("name", paramName);
			$target.val(uncomma(money));
		}
		// 수익항목인지 검사
		function isIncome(cate_cd) {
			if (cate_cd < 20000)
				return true;

			return false;
		}
		// 컴마 제거메서드
		function uncomma(price) {
			return price.replace(/\,/g, '');
		}

		// 페이지 링크 클릭시 함수
		$(".pagination").on("click", "li a", function(event) {
			event.preventDefault();
			var pageValue = $(this).text();
			var pageInfo = $(this).data("pageInfo");
			console.log("페이지정보 :" + pageInfo + pageValue);
			// ex)/ajax/yearTranHistory/2017/+pageValue
			getPage(pageInfo + pageValue);
		});

		// 전체체크란이 클릭되면 모두 체크상태로 변환
		$("thead").on("click", ".fullCheck", function() {
			console.log("전체클릭");
			if ($(".fullCheck").is(":checked")) {
				$("input:checkbox").prop('checked', true);
				return;
			}
			$("input:checkbox").prop('checked', false);
		});

		// 행을 클릭하면 행 color 변환
		$("tbody").on("click", "tr", function() {

			console.log("tr클릭");
			var trObj = $(this);
			var classValue = $(trObj).attr("class");
			console.log("classValue : " + classValue);
			if (classValue == undefined || classValue == "") {
				result = "success";
			} else {
				result = "";
			}
			$(trObj).attr("class", result);
		});

		function IncomeDTO() {
			this.number = 0, this.mno = 1, this.regdate = "", this.money = 0,
					this.init = function(dataObj) {
						this.number = dataObj.num
						this.regdate = dataObj.regdate;
						this.money = dataObj.money;
					}
		}
		;
		function OutlayDTO() {
			this.number = 1, this.mno = 1, this.regdate = "",
					this.pay_code = '0', this.money = 0, this.init = function(
							dataObj) {
						this.number = dataObj.num;
						this.regdate = dataObj.regdate;
						this.money = dataObj.money;
						this.pay_code = dataObj.pay_code;
					}
		}
		;

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
	height: 1261px;
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
			<p class="incomeList"></p>
			<p>비용</p>
			<p class="outlayList"></p>
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
				<th><input type="checkbox" class="fullCheck" name="" value=""></th>
				<th>날짜</th>
				<th>아이템</th>
				<th>금액</th>
				<th>카테고리</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
<nav>
	<ul class="pagination"></ul>
</nav>
</div>



<c:import url="../include/footer.jsp" />

<!-- Large modal -->


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
					<p class="incomeList"></p>
					<p>비용</p>
					<p class="outlayList"></p>
				</div>
			</form>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary">수정하기</button>
			</div>


		</div>
	</div>
</div>











<script id="list-template" type="text/x-handlebars-template">
{{#each .}}
<tr data-num='{{num}}' data-money='{{money}}'  data-regdate='{{regdate}}' data-cate_cd='{{cate_cd}}' data-pay_code='{{pay_code}}' >
	<td><input type="checkbox" data-num='{{num}}' name="" value=""></td>
	<td>{{prettifyDate regdate}}</td>
	<td>{{item}}</td>
	<td class="money" data-cate-cd="{{cate_cd}}">{{prettifyMoney money}}</td>
	<td>{{cate_name}}</td>
	<td><a class="modLink" data-num='{{num}}' data-cate-cd='{{cate_cd}}' data-pay-code='{{pay_code}}' data-toggle='modal' data-target='.bs-example-modal-lg' href="#">수정</a>&nbsp;
	<a class='rmLink' data-num='{{num}}' data-money='{{money}}' data-cate_cd='{{cate_cd}}' data-regdate='{{regdate}}' href="#">삭제</a></td>
</tr>
{{/each}}
</script>