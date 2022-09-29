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
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                            <h4>도서 상세보기</h4>
                        </div>
                    <div id="main_content_1">
                        <form action="MacaronicsServlet" method="post"  name="form1">
                            <div class="table-responsive">
                                <table class="table">
                                    <tr>
                                        <th class="success" style="width: 130px">도서 분류</th>
                                        <td colspan="5">
                                            ${bookDetail.bookCategory}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="success">도서 제목</th>
                                        <td colspan="5">${bookDetail.bookTitle}</td>
                                    </tr>
                                    <tr>
                                        <th>작가</th><td>${bookDetail.bookAuthor}</td>
                                        <th>출판사</th><td>${bookDetail.bookPublisher}</td>
                                        <th>출판일</th><td>${bookDetail.bookPublishingDate}</td>
                                    </tr>
                                    <tr>
                                        <th>가격</th><td><fmt:formatNumber  type="currency" value="${bookDetail.bookPrice}" /></td>
                                        <th>재고</th><td colspan="3">
                                        <c:choose>
                                            <c:when test="${bookDetail.bookStock==0 }">
                                                없음
                                            </c:when>
                                            <c:otherwise>
                                                ${bookDetail.bookStock}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    </tr>
                                    <tr>
                                        <th>도서 설명</th>
                                        <td colspan="5" style="padding-bottom: 100px">
                                            ${bookDetail.bookContent}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>도서 표지</th>
                                        <td colspan="5">
                                            <img src="/image${bookDetail.bookPictureUrl}" width="200" height="300" class="img-responsive" alt=""/>
                                        </td>
                                    </tr>

                                </table>

                                <input  type="hidden" name="command" id="command" >
                                <input  type="hidden" name="pageNum" value="${pageN}">
                                <input  type="hidden" name="pseq" value="${productVO.pseq}">

                            </div>
                            <div class="text-center">
                                <input type="button" value="수정하기"  class="btn btn-success" onclick="go_update();">
                                <input type="button" value="목록보기"  class="btn btn-primary" onclick="go_list();">
                                <input type="button" value="삭제하기"  class="btn btn-danger" onclick="go_delete();">

                            </div>
                        </form>
                        </div>
                    </div>
                    <div>
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