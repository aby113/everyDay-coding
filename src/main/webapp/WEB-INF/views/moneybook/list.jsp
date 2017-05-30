<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
    <style media="screen">
        h1 {
            display: inline;
        }

        a {
            text-decoration: none;
        }

        .content>div {
            border: solid 1px;
        }

        .content>div>div {
            border: solid 1px;
        }
        .calculate{
          border: solid 1px;
        }
    </style>
    <meta charset="utf-8">
    <title></title>
</head>

<body>
    <div class="calendar">
        <a href="#">
             </a>
                <h1>2017/05</h1>
                <a href="#"> > </a>
    </div>
    <button type="button" name="button">추가</button>
    <div class="content">
        <div class="date">
            2017/05/29 월요일
            <div class="">
                <a href="#">
                    <img src="/resources/imgs/10100.png" alt="">월급 1000
                </a>
                <button type="button" name="button">삭제</button>
            </div>
            <div class="">
                <a href="#">
                    <img src="/resources/imgs/10100.png" width="25px" height="25px" alt="">월급 1000
                </a>
                  <button type="button" name="button">삭제</button>
            </div>

        </div>
        <div class="date">
            2017/05/28 일요일

            <div class="">
                <a href="#">
                    <img src="/resources/imgs/10100.png" alt="">월급 1000
                </a>
                  <button type="button" name="button">삭제</button>
            </div>
            <div class="">
                <a href="#">
                    <img src="/resources/imgs/10100.png" width="25px" height="25px" alt="">월급 1000
                </a>
                  <button type="button" name="button">삭제</button>
            </div>
        </div>
    </div>

    <div class="calculate">
        <p><span>수입 11,500&nbsp;&nbsp;&nbsp;&nbsp;지출 10,000</span></p>
        <p><span>총잔액 2500</span>
    </div>


</body>

</html>
