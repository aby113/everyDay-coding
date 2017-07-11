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
		str += "<li " + strClass + "><a href='" + i + "' data-page-info='"
				+ pageInfo + "'>" + i + "</a></li>";
	}

	if (pageMaker.next) {
		str += "<li><a href='#' aria-label='Next'><span aria-hidden='true'>"
				+ "&raquo;</span></a></li>"
	}

	target.html(str);

}

// 페이지 링크 클릭시 함수
$(".pagination").on("click", "a", function(event) {

	event.preventDefault();
	var pageValue = $(this).text();
	var pageInfo = $(this).data("pageInfo");
	console.log("페이지정보 :" + pageInfo + pageValue);
	// ex)/ajax/yearTranHistory/2017/+pageValue
	getPage(pageInfo + pageValue);

});

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

