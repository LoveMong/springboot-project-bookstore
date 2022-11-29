<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome! Book Store!</title>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <link rel="stylesheet" href="/css/mypage/order.css">
    <link rel="stylesheet" href="/css/admin/bookList.css">
    <script integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
    <script src="/css/bootstraps/css/bootstrap.css"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>

<body>

<jsp:include page="../common/admin_header.jsp"/>


<div id="wrap">
    <!-- 상단부(로고, 검색창, 로그인창) -->
    <div id="main" class="categories-section mt-3">
        <div id="main_wrap" class="container">
            <div class="book_logo mt-5 mb-2" style="    width: 280px;">
                <a href="/" style="margin-left: -200px"> <img src="/img/bk_store2.png" alt=""></a>
            </div>
            <div id="main_subject">
                <p>관리자페이지</p>
            </div>
            <!-- 사이드 네비게이션 -->
            <div id="side_menu">
                <jsp:include page="../common/admin_menu.jsp"/>
            </div>
            <!-- 메인  컨텐츠-->
            <div id="main_content_wrap">
                <div id="main_content" style="margin-left: 50px; margin-top: 30px; ">
                    <div class="row-fluid">
                        <div class="alert alert-success">
                            <h4>주문 목록</h4>
                        </div>
                        <form action="" method="get">
                            <%--						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />--%>
                            <div class="" style="margin: 10px">
                                <p style="margin-right: 10px; float: left"> 조회기간 :
                                <div class="" style="padding-right:10px; float:left;">
                                    <input type="text" id="datepickerStart" name="startDate" class="form-control form-control-sm">
                                </div>
                                <div style="float: left; margin-right: 10px"> ~ </div>
                                <div class="" style="padding-right:10px; float:left;">
                                    <input type="text" id="datepickerEnd" name="endDate" class="form-control form-control-sm">
                                </div>
                            </div>
                            <br>
                            <div class="" style="float: right; margin-top: 40px; margin-bottom: 40px">
                                <div class="w100 float_left" style="padding-right:10px; float:left;">
                                    <select class="form-control form-control-sm" name="option" id="searchType" style="width: 107px; float: left; margin-right: 7px; margin-left: -57px;">
                                        <option value="T" ${pageHandler.sc.option=='T' ? "selected" : ""}>구매자</option>
                                        <option value="R" ${pageHandler.sc.option=='R' ? "selected" : ""}>수령인</option>
                                    </select>
                                </div>
                                <div class="w300  float_left" style="padding-right:10px; float:left;">
                                    <input type="text" name="keyword" class="form-control form-control-sm-input" type="text" value="${pageHandler.sc.keyword}" placeholder="검색어를 입력해주세요" style="height: 32px">
                                </div>
                                <input type="submit" class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch" value="검색"/>
                            </div>
                        </form>
                    <br>
                        <div id="main_content_1">
                            <table id="point_table">
                                <thead>
                                <tr style="background-color: #e9e9e9; font-size: 13px">
                                    <td style="width: 10%; border: 1px solid #d0d0d0">주문번호</td>
                                    <td style="width: 9%; border: 1px solid #d0d0d0">주문일자</td>
                                    <td style="border: 1px solid #d0d0d0; width: 32%;">주문내역</td>
                                    <td style="border: 1px solid #d0d0d0; width: 30%">배송지/수령인</td>
                                    <td style="border: 1px solid #d0d0d0; width: 8%">구매자</td>
                                    <td style="border: 1px solid #d0d0d0; width: 8%">배송상태</td>
                                </tr>
                                </thead>
                                <tbody style="font-size: 12px">
                                <c:forEach items="${orderList}" var="list" varStatus="i" >
                                    <tr>
                                        <td id="tb_td_number" class="tb_td_year">
                                            ${list.orderNumber }
                                        </td>
                                        <td id="tb_td_year" class="tb_td_year">
                                            <fmt:parseDate value="${list.orderDate }" var="parseDateValue" pattern="yyyy-MM-dd HH:mm:ss"/>
                                            <fmt:formatDate value="${parseDateValue}" pattern="yyyy-MM-dd"/>
                                        </td>
                                        <td  class="tb_td_info">
                                            <c:choose>
                                                <c:when test="${list.bookTypeCount == 1}">
                                                    ${list.cartInfoList[0].bookTitle }
                                                </c:when>
                                                <c:otherwise>
                                                    ${list.cartInfoList[0].bookTitle } 외 ${list.bookTypeCount - 1} 종
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="tb_td_state">${list.memberAddress} / ${list.memberName}</td>
                                        <td class="tb_td_state">${list.memberEmail}</td>
                                        <td class="tb_td_btn">
                                            <form id="" method="get">
                                                <input type="hidden" id="cNum${i.getIndex()}" value="${list.orderState}">
                                                <input type="hidden" id="oNum${i.getIndex()}" value="${list.orderNumber}">
                                                <c:choose>
                                                    <c:when test="${list.orderState == 0}">
                                                        <input style="padding: revert; font-size: 12px;" type="button" id="confirm${i.getIndex()}" class="btn btn-outline-secondary" value="배송준비중">
                                                    </c:when>
                                                    <c:when test="${list.orderState == 1}">
                                                        <input style="padding: revert; font-size: 12px;" type="button" id="confirm${i.getIndex()}" class="btn btn-outline-secondary" value="배송중">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input  style="padding: revert; font-size: 12px;" type="button" id="confirm${i.getIndex()}" class="btn btn-outline-secondary" value="배송완료">
                                                    </c:otherwise>
                                                </c:choose>
                                            </form>
                                        </td>
                                    </tr>
                                    <script>

                                        $(document).ready(function(e){

                                            $("#confirm${i.getIndex()}").click(function(){
                                                const cNum = $('#cNum${i.getIndex()}').val();
                                                const oNum = $('#oNum${i.getIndex()}').val();


                                                console.log("cNum : "+cNum);
                                                console.log("oNum : "+oNum);

                                                if(cNum == 2) {
                                                    alert('이미 배송완료 되었습니다.')
                                                }else {
                                                    $.ajax({
                                                        url: "/admin/delivery",
                                                        type: "GET",
                                                        data:{
                                                            "cNum" : cNum,
                                                            "oNum" : oNum
                                                        },
                                                        success: function(data) {
                                                            alert(data);
                                                            location.reload();
                                                        }
                                                    });
                                                }
                                            });

                                        });
                                    </script>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>

                    <div>
                    <nav aria-label="Page navigation example" style="margin-top: 100px">
                        <ul class="pagination justify-content-center">
                            <c:if test="${totalCnt !=null || totalCnt==0}">
                                <div>
                                    <div><img src="/img/경고.png" alt=""></div>
                                    <div style="margin-top: 30px; margin-left: -43px; font-size: 20px; font-weight: bold;">검색 결과가 없습니다.</div>
                                </div>
                            </c:if>
                            <c:if test="${totalCnt==null && totalCnt!=0}">
                                <li class="page-item">
                                    <c:if test="${pageHandler.showPrev}">
                                        <a class="page-link" href="<c:url value="/admin/bookList${pageHandler.sc.getQueryString(pageHandler.beginPage-1)}"/>"  tabindex="-1">Previous</a>
                                    </c:if>
                                </li>
                                <c:forEach begin="${pageHandler.beginPage}" end="${pageHandler.endPage}" step="1" var="i">
                                    <c:choose>
                                        <c:when test="${pageHandler.sc.page == i}">
                                            <li class="page-item"><a class="page-link" style="background-color: #cce5ff" href="#">${i}</a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item"><a class="page-link" href="<c:url value="/admin/bookList${pageHandler.sc.getQueryString(i)}"/>">${i}</a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <li class="page-item">
                                    <c:if test="${pageHandler.showNext}">
                                        <a class="page-link" href="<c:url value="/admin/bookList${pageHandler.sc.getQueryString(pageHandler.endPage+1)}"/>">Next</a>
                                    </c:if>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                    </div>
                </div>
                </div>
                </div>
            </div>
        </div>
        <div class="clear_fix" style="clear:both;"></div>
    </div>

<script>

    let today = new Date().toLocaleDateString();

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
        yearSuffix: '년',
        maxDate: new Date(),
        onClose : function( selectedDate ) {
            if( selectedDate != "" ) {

                $("#datepickerStart").datepicker("option", "maxDate", $("#datepickerEnd").val());
                $("#datepickerEnd").datepicker("option", "minDate", $("#datepickerStart").val());
            }
        }


    });


    $(function() {
        $("#datepickerStart,#datepickerEnd").datepicker({
            //옵션들 생략//
            //옵션들 생략//
        });
    });

</script>

<jsp:include page="../common/footer.jsp"/>

</body>



</html>