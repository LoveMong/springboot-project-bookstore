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
    <link rel="stylesheet" href="/css/admin/bookList.css">
    <script integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
    <script src="/css/bootstraps/css/bootstrap.css"></script>

    <script>
        let msg = "${msg}";
        if(msg=="READ_ERR")  alert("삭제되었거나 없는 게시물입니다.");
        if(msg=="DEL_ERR")   alert("삭제되었거나 없는 게시물입니다.");
        if(msg=="DEL_OK")    alert("성공적으로 삭제되었습니다.");
        if(msg=="ENR_OK")    alert("성공적으로 등록되었습니다.");
        if(msg=="UPD_OK")    alert("성공적으로 수정되었습니다.");
    </script>
</head>

<body>

<jsp:include page="../common/admin_header.jsp"/>


<div id="wrap">
    <!-- 상단부(로고, 검색창, 로그인창) -->
    <div id="main" class="categories-section mt-3">
        <div id="main_wrap" class="container">
            <div class="book_logo mt-5 mb-2" style="    width: 280px;">
                <a href="/main" style="margin-left: -200px"> <img src="/img/bk_store2.png" alt=""></a>
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
                            <h4>도서 목록</h4>
                        </div>

                        <div style="margin-left: 430px; margin-top: 50px; margin-bottom: 100px">
                            <div class="w100 float_left" style="padding-right:10px; float:left;">
                                <div class="search-container" style="margin-left: 350px;">
                                    <form action="<c:url value="/admin/bookList"/>" class="search-form" method="get">
                                        <select class="form-control form-control-sm" name="option" id="searchType" style="width: 107px; float: left; margin-right: 7px; margin-left: -57px;">
                                            <option value="A" ${pageHandler.sc.option=='A' || pageHandler.sc.option=='' ? "selected" : ""}>제목+내용</option>
                                            <option value="T" ${pageHandler.sc.option=='T' ? "selected" : ""}>제목</option>
                                            <option value="W" ${pageHandler.sc.option=='W' ? "selected" : ""}>작가</option>
                                        </select>
                                        <div class="w300  float_left" style="padding-right:10px; float:left;">
                                            <input type="text" name="keyword" class="form-control form-control-sm-input" type="text" value="${pageHandler.sc.keyword}" placeholder="검색어를 입력해주세요" style="height: 32px">
                                        </div>
                                        <input type="submit" class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch" value="검색"/>
                                    </form>
                                </div>
                            </div>
                    </div>
                    <br>
                    <div id="main_content_1">
                        <table class="table table-hover">
                            <thead style="background-color: #e9e9e9; border: none; border-bottom: double">
                            <tr class="">
                                <th scope="col" style="padding-right: 70px">도서 제목</th>
                                <th scope="col">작가</th>
                                <th scope="col">출판사</th>
                                <th scope="col">출판년도</th>
                                <th scope="col">가격<p style="display: inline">(원)</p></th>
                                <th scope="col">재고<p style="display: inline">(개)</p></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${bookList}" var="list" varStatus="vs">
                                <tr id="">
                                    <th><a href="<c:url value="/admin/bookDetail${pageHandler.sc.queryString}&bookNum=${list.bookNum}"/>" style="color: #00a3d2">${list.bookTitle}</a></th>
                                    <th>${list.bookAuthor}</th>
                                    <th>${list.bookPublisher}</th>
                                    <th>${list.bookPublishingDate}</th>
                                    <th><fmt:formatNumber value="${list.bookPrice}" /></th>
                                    <th>${list.bookStock}</th>
                                </tr>
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

<jsp:include page="../common/footer.jsp"/>

</body>



</html>