<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="../include/header.jsp" />
<script src="/resources/jquery-number-master/jquery.number.js"></script>
<script src="/resources/js/page.js"></script>
<script type="text/javascript">
	$(function() {
		// 최초 진입시에 getPage호출
		getPage("/ajax/moneybookList/1");
		getCateList("/ajax/getCategoryList");
		var modalData = null;
		var pageMaker = null;
		
		var checkboxArr = new Array();
		$(".white_block").css("height", "456");
		// 콤마찍기
		$('#price').number(true);
		// 수익and지출 링크 동적으로 생성
		

		// 작성버튼
		$("#addBtn").click(function() {
			// 카테고리값에 따라 url변경됨 ex)income,outlay
			var pageInfo = getPageInfo(cate_cd);
			var getPageURL = window.pageMaker.pageInfo;
			var item = $("input[name=item]").val();
			var regdate = $("input[name=regdate]").val();
			var pay_code = $("select[name=pay_code]").val();
			var cate_cd = $("input[name=cate_cd]").val();
			var money = $("#price").val();
			var paramObj = {item : item,	regdate : regdate, pay_code : pay_code
				,cate_cd : cate_cd,	money : money};
			register(pageInfo, paramObj, getPageURL);
		});
		
		// 수정 링크 클릭
		// 클릭된 행의 값을 모달에 셋팅하고 창을 띄움
		 $("tbody").on("click", ".modLink", function(event) {
			event.preventDefault();
			event.stopPropagation();
			console.log("modLink 실행");
			console.log(modalData);
			modalData = $(this).data();
			setModalData(modalData);
			$('.modal-price').number(true);
			$(".bs-example-modal-lg").modal('toggle');
		}); 

		// 다중삭제 처리
		$("tbody").on("click", ".rmLink", function(event) {
			event.preventDefault();
			event.stopPropagation();
			var pageInfo = window.pageMaker.pageInfo;
			var currPage = window.pageMaker.cri.page;
			console.log("다중삭제 클릭: "+pageInfo+currPage);
			var removeList = getRemoveList($("tbody tr[class='success']"));
			var rmMethod = function(msg) {
				alert("삭제완료");
				getPage(pageInfo+currPage);
			}
			var result = confirm("삭제 하시겟습니까?");
			if(!result)return;
			sendPostAjax("/ajax/moneybook/remove", removeList, rmMethod);
		});

		

		
		// 전송 = 아이템,날짜,결제수단,카테고리,돈
		function register(pageInfo, paramObj, getPageURL) {
			// 성공시 실행될 메서드
			var registerMethod = function(msg) {
				alert("글저장완료");
				console.log("작성후 페이지호출");
				getPage(getPageURL+"1");
				$(".registerFrm")[0].reset();
			}	
			// URL, 전송데이터, 성공시 실행될 메서드
			sendPostAjax(pageInfo, paramObj, registerMethod);
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
			$("#cateInp").val(linkValue);
			console.log(findCateCode(linkValue));
			$("input[name=cate_cd]").val(findCateCode(linkValue));
			
		});
		
		// 모달박스 카테고리 링크 클릭
		$(".modal-content div.cateBox p[class$=List] a").click(function(event){
			event.preventDefault();
			event.stopImmediatePropagation();
			
			var linkValue = $(this).text();
			$(".modal-cate_gory").val(linkValue);
			
		});
		
		// 모달 수정버튼 : 모달폼에잇는 데이터를 가져와서 VO객체에 셋팅해준다음 전송
		$("div.modal-footer > button").click(function(event){
			console.log("모달 수정버튼 클릭");
			var pageInfo = window.pageMaker.pageInfo;
			var currPage = window.pageMaker.cri.page;
			var modMethod = function(data){
				alert(data);
			}
			modalData = getModalData();
			// 카테고리에 따라 VO가 달라진다 = IncomeVO, OutlayVO
			var moneybookVO = getVoInstance(modalData.cateCd);
			moneybookVO.copyData(modalData);
			console.log(moneybookVO);
			sendPostAjax("/ajax/modify", moneybookVO, modMethod);		
			$(".bs-example-modal-lg").modal('hide');
			getPage(pageInfo+currPage);
		});
		
		
		 

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
			console.log(categoryList);
			$.each(categoryList, function() {
				console.log("hi");
				console.log(this);
				str += "<a href='#'>" + this.cate_name + "</a>";
			});
			return str;
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

		// 행을 클릭하면 활성화:비활성화 분기
		$("tbody").on("click", "tr", function() {
			console.log("tr클릭");
			var trObj = $(this);
			var classValue = $(trObj).attr("class");
			// 비활성화 됫으면 활성화 - 활성화상태면 비활성화
			var result = classValue==null?"success":null;
			$(trObj).attr("class", result);
		});

	
		
		// 삭제버튼을 클릭하면 선택된 행들을 가져와서
		// list에 저장함 그후 list가담긴 removeList반환 ex)incList,outList 
		function getRemoveList($target){
			var incList = new Array();
			var outList = new Array();
			var removeList = {incList:incList, outList:outList};
			$target.each(function() {
				// 수익이면 true 리턴
				console.log("반복문 체크");
				if (isIncome($(this).data("cateCd"))) {
					var incomeDTO = new IncomeDTO();
					incomeDTO.init($(this).data());
					incList.push(incomeDTO);
				} else {
					var outlayDTO = new OutlayDTO();
					outlayDTO.init($(this).data());
					outList.push(outlayDTO);
				}

			});
			return	removeList;
		}
		
		
		
		function IncomeDTO() {
			this.number = 0, this.mno = 1, this.regdate = "", this.money = 0,
					this.init = function(dataObj) {
						this.number = dataObj.num
						this.regdate = dataObj.regdate;
						this.money = dataObj.money;
					}
		};
		
		function OutlayDTO() {
			this.number = 1, this.mno = 1, this.regdate = "",
					this.pay_code = '0', this.money = 0, this.init = function(
							dataObj) {
						this.number = dataObj.num;
						this.regdate = dataObj.regdate;
						this.money = dataObj.money;
						this.pay_code = dataObj.pay_code;
					}
		};
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
				<th>결제수단</th>
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
				<h4 class="modal-title">Modal 수정</h4>
			</div>
			<form class="registerFrm" action="/money/register" method="post">
				<input type="hidden" class="modal-num" name="num"/>
				<input type="hidden" class="modal-cate_cd" name="cate_cd" value=""> <input
					type="hidden" class="modal-money" name="money" value="">
				<div class="">
					<p>날짜</p>
					<p>
						<input type="text" class="modal-datePicker" id="datePicker" name="regdate" value="">
					</p>
				</div>
				<div class="">
					<p>아이템</p>
					<p>
						<input type="text" class="modal-item" name="item" value="">
					</p>
				</div>
				<div class="">
					<p>금액</p>
					<p>
						<input type="text" class="modal-price" id="price" name="" value="">
					</p>
				</div>
				<div class="">
					<p>결제 수단</p>
					<p>
						<select class="modal-selectBox" name="pay_code">
							<option value="0">현금</option>
							<option value="1">카드</option>
						</select>
					</p>
				</div>
				<div class="cateBox">
					<p>카테고리</p>
					<p>
						<input type="text" class="modal-cate_gory" id="cateInp" name="" value=""
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


<!-- data-toggle='modal' data-target='.bs-example-modal-lg'  -->







<script id="cateLink-template" type="text/x-handlebars-template">
{{#each .}}
<a href='#' data-cate-cd='{{cate_cd}}'>{{cate_name}}</a>
{{/each}}
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