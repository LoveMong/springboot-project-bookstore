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
                            <h4>도서 수정</h4>
                        </div>
                    <div id="main_content_1">
                        <form action="<c:url value='/admin/bookUpdate'/>" enctype="multipart/form-data" method="post"  name="form1">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <input type="hidden" name="bookNum" value="${bookDetail.bookNum}">
                            <div class="table-responsive">
                                <table class="table" id="book_detail">
                                    <tr>
                                        <th class="success" style="width: 130px; background-color: #f8f8ff">도서 분류</th>
                                        <td colspan="5">
                                            <select name="bookCategory" id="bookCategory" class="form-span6 m-wrap" style="border: none; background: transparent;">
                                                <option value=${bookDetail.bookCategory} selected></option>
                                                <option value="1">소설</option>
                                                <option value="2">시/에세이</option>
                                                <option value="3">경제/경영</option>
                                                <option value="4">자기계발</option>
                                                <option value="5">인문</option>
                                                <option value="6">역사/문화</option>
                                                <option value="7">종교</option>
                                                <option value="8">정치/사회</option>
                                                <option value="9">예술/대중문화</option>
                                                <option value="10">과학</option>
                                                <option value="11">기술/공학</option>
                                                <option value="12">컴퓨터/IT</option>
                                            </select>

                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="success" style="background-color: #f8f8ff">제목</th>
                                        <td colspan="5"><input type="text" name="bookTitle" id="bookTitle" value="${bookDetail.bookTitle}"></td>
                                    </tr>
                                    <tr>
                                        <th style="background-color: #f8f8ff">작가</th><td><input type="text" name="bookAuthor" id="bookAuthor" value="${bookDetail.bookAuthor}"></td>
                                        <th style="background-color: #f8f8ff">출판사</th><td><input type="text" name="bookPublisher" id="bookPublisher" value="${bookDetail.bookPublisher}"></td>
                                        <th style="background-color: #f8f8ff">출판일</th><td><input type="text" name="bookPublishingDate" id="bookPublishingDate" value="${bookDetail.bookPublishingDate}" placeholder="0000-00-00"></td>
                                    </tr>
                                    <tr>
                                        <th style="background-color: #f8f8ff">가격<p style="display: inline">(원)</p></th><td><input type="text" name="bookPrice" id="bookPrice" value="${bookDetail.bookPrice}"></td>
                                        <th style="background-color: #f8f8ff">재고<p style="display: inline">(개)</p></th><td colspan="3">
                                        <input type="text" name="bookStock" id="bookStock" value="${bookDetail.bookStock}">
                                    </td>
                                    </tr>
                                    <tr>
                                        <th style="background-color: #f8f8ff">도서 소개</th>
                                        <td colspan="5" style="padding-bottom: 100px">
                                            <textarea id="bookContent" name="bookContent" class="box" style="width:98%;height:200px; border: none; background: transparent" name="bookContent" maxlength="1000">${bookDetail.bookContent}</textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th style="background-color: #f8f8ff">도서 표지</th>
                                        <td colspan="5">
                                            <input type="file" name="image" id="image">
                                            <img src="/image${bookDetail.bookPictureUrl}" width="200" height="300" class="img-responsive" alt=""/>
                                        </td>
                                    </tr>

                                </table>
                            </div>
                            <div class="text-center">
                                <input type="submit" value="수정하기"  class="btn btn-success">
                                <input type="button" value="목록보기"  class="btn btn-primary" onclick="location.href='<c:url value="/admin/bookList"/>' ">
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


<script>


    $(document).ready(function(){


        window.onload=function () {

            let book_category = '<c:out value="${bookDetail.bookCategory}"/>'


             let result = "";

            switch(book_category){
                case "1":
                    result = "소설";
                    break;
                case "2":
                    result = "시/에세이";
                    break;
                case "3":
                    result = "경제/경영";
                    break;
                case "4":
                    result = "자기계발";
                    break;
                case "5":
                    result = "인문";
                    break;
                case "6":
                    result = "역사/문화";
                    break;
                case "7":
                    result = "종교";
                    break;
                case "8":
                    result = "정치/사회";
                    break;
                case "9":
                    result = "예술/대중문화";
                    break;
                case "10":
                    result = "과학";
                    break;
                case "11":
                    result = "기술/공학";
                    break;
                case "12":
                    result = "컴퓨터/IT";
                    break;
            }
            $('#bookCategory option:checked').text(result);
        }


    });

</script>


</body>

</html>