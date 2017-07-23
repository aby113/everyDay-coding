function getPage(pageInfo) {

	$.getJSON(pageInfo, function(data) {
		// 페이지네이션 링크 ajax처리할때 어떤요청에대한 페이지요청인지
		// 알아야되서 저장
		console.log("ajax 페이지갱신");
		console.log(data);
		pageMaker = data.pageMaker;
		currentPage = data.pageMaker.cri.page;
		data.pageMaker.pageInfo = pageInfo.slice(0, -1);
		console.log(data.pageMaker);
		printData($("#list-template"), $("tbody"), data.list);
		printPaging(data.pageMaker, $(".pagination"));
		// 돈 색변경: 수익/ 비용
		changeMoneyColor($(".money"), "blue", "red");
		// 결제수단 색변경: 카드/ 현금
		changePaymentColor($(".payment"), "green", "blue");
	});
	

}

function printCateLink($template, cateList){
	printData($template, $(".incomeList"), cateList.incList);
	printData($template, $(".outlayList"), cateList.outList);
}

function printData(templateObj, target, dataArr) {

	var template = Handlebars.compile(templateObj.html());
	var html = template(dataArr);
	target.html(html);
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
		str += "<li " + strClass + "><a href='#' data-page-info='" + pageInfo
				+ "'>" + i + "</a></li>";
	}

	if (pageMaker.next) {
		str += "<li><a href='#' aria-label='Next'><span aria-hidden='true'>"
				+ "&raquo;</span></a></li>"
	}

	target.html(str);

}

// post방식 ajax메서드
function sendPostAjax(url, dataObj, method) {

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

// 페이지 링크 클릭시 함수
$(".pagination").on("click", "li a", function(event) {
	event.preventDefault();
	var pageValue = $(this).text();
	var pageInfo = $(this).data("pageInfo");
	console.log("페이지정보 :" + pageInfo + pageValue);
	// ex)/ajax/yearTranHistory/2017/+pageValue
	// getPage(pageInfo + pageValue);

});

// 20170719
Handlebars.registerHelper("prettifyDate", function(timeValue) {
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

// 금액 색 적용하기
function changeMoneyColor($target, incColor, outColor) {

	$target.each(function() {
		// 카테고리가 수익이면 파랑, 비용이면 빨강
		if ($(this).data("cateCd") < 20000) {
			$(this).css("color", incColor);
		} else {
			$(this).css("color", outColor);
		}

	});
}

function changePaymentColor($target, cardColor, cashColor) {
	$target.each(function() {
		// 카테고리가 수익이면 파랑, 비용이면 빨강
		if (isCard($(this).data("payCode"))) {
			$(this).css("color", cardColor);
		} else {
			$(this).css("color", cashColor);
		}

	});
}
// 결제수단이 카드면 true리턴
function isCard(pay_code) {
	if (pay_code == 1) {
		return true;
	}

	return false;
}

// 모달 데이터 셋팅
function setModalData(dataObj) {
	// 번호,날짜,아이템,가격,카테고리이름,결제수단
	$("input.modal-num").val(dataObj.num);
	$(".modal-datePicker").val(dataObj.regdate);
	$(".modal-item").val(dataObj.item);
	$(".modal-price").val(dataObj.money);
	$(".modal-cate_gory").val(dataObj.cateName);
	setSelectBox(dataObj.payCode);
}

// 모달폼 데이터 꺼내옴
function getModalData() {
	var dataObj = {};
	dataObj.num = $("input.modal-num").val();
	dataObj.regdate = $(".modal-datePicker").val();
	dataObj.item = $(".modal-item").val();
	dataObj.money = $(".modal-price").val();
	dataObj.cateCd = findCateCode($(".modal-cate_gory").val());
	dataObj.payCode = $(".modal-selectBox option:selected").val();
	return dataObj;
}

// 결제수단에 따라 option 선택
function setSelectBox(payCode) {

	if (isCard(payCode)) {
		$(".modal-selectBox option:contains(카드)").attr("selected", "selected");
	} else {
		$(".modal-selectBox option:contains(현금)").attr("selected", "selected");
	}

}

function getVoInstance(cate_cd) {

	if (isIncome(cate_cd)) {
		return new IncomeVO();
	} else {
		return new OutlayVO();
	}

}

function IncomeVO() {

	this.inc_no = 0;
	this.mno = 1;
	this.cate_cd = 0;
	this.pay_code = "0";
	this.revenue = 0;
	this.item = "";
	this.regdate = "";
	this.copyData = function(dataObj) {
		this.inc_no = dataObj.num;
		this.cate_cd = dataObj.cateCd;
		this.revenue = dataObj.money;
		this.item = dataObj.item;
		this.regdate = dataObj.regdate;
	}
}

function OutlayVO() {

	this.out_no = 0;
	this.mno = 1;
	this.cate_cd = 0;
	this.pay_code = "0";
	this.cost = 0;
	this.item = "";
	this.regdate = "";
	this.copyData = function(dataObj) {
		this.out_no = dataObj.num;
		this.cate_cd = dataObj.cateCd;
		this.cost = dataObj.money;
		this.pay_code = dataObj.payCode;
		this.item = dataObj.item;
		this.regdate = dataObj.regdate;
	}
}

// 수익항목인지 검사
function isIncome(cate_cd) {
	if (cate_cd < 20000)
		return true;

	return false;
}

// 카테고리 값으로 해당 키를 리턴
function findCateCode(cateName) {
	var result = "";
	$.each(category, function(key, value) {

		if (cateName === value) {
			result = key;
		}
	});
	return result;
}
// 서버에서 카테고리 목록을 가져와 list페이지에 link생성
function getCateList(url) {
	var incList = new Array();
	var outList = new Array();
	$.getJSON(url, function(data) {
		$.each(data, function() {
				if (isIncome(this.cate_cd)) {
					incList.push(this);
				} else {
					outList.push(this);
				}

			});
		printCateLink($("#cateLink-template"), {incList:incList, outList:outList});
	});
}
