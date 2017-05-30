<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="jquery-ui-1.12.1.custom/jquery-ui.css">
    <script type="text/javascript" src="jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
    <script src="jquery-number-master/jquery.number.min.js"></script>
    <script>
        $(function() {
            $.datepicker.setDefaults({
                dateFormat: 'yy-mm-dd',
                prevText: '이전 달',
                nextText: '다음 달',
                monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                dayNames: ['일', '월', '화', '수', '목', '금', '토'],
                dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
                dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
                showMonthAfterYear: true,
                yearSuffix: '년'
            });


            $("#datepicker1").datepicker({
                changeYear: true,
                dateFormat: "yy/mm/dd(DD)"
            });

            $("#price").number(true, 0);

        });
    </script>
    <meta charset="utf-8">
    <title></title>
</head>

<body>
    <h1>가계부 쓰기</h1>
    <nav>
        <a href="#">수입</a>
        <a href="#">지출</a>
    </nav>
    <section>
        <form action="#" method="get">
            <div class="">
                <img src="img/calendar-blue.png" alt="">
                <input type="text" name="" id="datepicker1" value="2017/05/30(화)">
            </div>
            <div class="category">
                <img src="img/icon-blue.png" alt="">
                <a href="#" data-toggle="modal" data-target="#cate-modal"><img src="img/10200.png" alt="">용돈</a>
            </div>
            <div class="memo">
                <img src="img/memo-blue.png" alt=""><input type="text" name="" placeholder="메모">
            </div>
            <div class="money">
                <img src="img/coin.png" alt=""><input type="text" id="price" name="" placeholder="0">
            </div>
            <button type="button" name="button">저장</button>
            <button type="button" name="button">취소</button>
        </form>
    </section>

    <div class="modal fade" id="cate-modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <p><img src="img/10400.png" alt=""><input type="text" name="" value="" placeholder="월급" autofocus>
                        <a href="#"><img src="img/select.png" alt=""></a>
                    </p>
                </div>
                <div class="modal-body">
                    <p>
                        <a href="#"><img src="img/heal.png" alt=""><span>의료/건강</span></a>
                    </p>
                    <p>
                        <a href="#"><img src="img/heal.png" alt=""><span>의료/건강</span></a>
                    </p>
                    <p>
                        <a href="#"><img src="img/heal.png" alt=""><span>의료/건강</span></a>
                    </p>
                    <p>
                        <a href="#"><img src="img/heal.png" alt=""><span>의료/건강</span></a>
                    </p>
                    <p>
                        <a href="#"><img src="img/heal.png" alt=""><span>의료/건강</span></a>
                    </p>
                </div>

            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
</body>

</html>
