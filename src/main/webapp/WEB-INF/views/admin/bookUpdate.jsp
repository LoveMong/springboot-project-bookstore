<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome! Book Store!</title>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <link rel="stylesheet" href="/css/admin/bookList.css">
    <script integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
    <script src="/css/bootstraps/css/bootstrap.css"></script>
    <script type="text/javascript" src="/js/bookUpdate.js"></script>
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
                            <h4>도서 수정</h4>
                        </div>
                    <div id="main_content_1">
                        <form action="<c:url value='/admin/bookUpdate${searchCondition.queryString}'/>" enctype="multipart/form-data" method="post"  id="book_update">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <input type="hidden" name="bookNum" value="${bookDetail.bookNum}">
                            <input type="hidden" name="bookPictureUrl" value="${bookDetail.bookPictureUrl}">
                            <input type="hidden" name="bookThumbUrl" value="${bookDetail.bookThumbUrl}">
                            <div class="table-responsive">
                                <table class="table" id="book_detail">
                                    <tr>
                                        <th class="success" style="width: 130px; background-color: #f8f8ff">도서 분류</th>
                                        <td colspan="5">
                                            <select name="bookCategory" id="bookCategory" class="form-span6 m-wrap" style="border: none; background: transparent;">
                                                <option value="1" <c:if test="${bookDetail.bookCategory eq '1'}">selected</c:if>>소설</option>
                                                <option value="2" <c:if test="${bookDetail.bookCategory eq '2'}">selected</c:if>>시/에세이</option>
                                                <option value="3" <c:if test="${bookDetail.bookCategory eq '3'}">selected</c:if>>경제/경영</option>
                                                <option value="4" <c:if test="${bookDetail.bookCategory eq '4'}">selected</c:if>>자기계발</option>
                                                <option value="5" <c:if test="${bookDetail.bookCategory eq '5'}">selected</c:if>>인문</option>
                                                <option value="6" <c:if test="${bookDetail.bookCategory eq '6'}">selected</c:if>>역사/문화</option>
                                                <option value="7" <c:if test="${bookDetail.bookCategory eq '7'}">selected</c:if>>종교</option>
                                                <option value="8" <c:if test="${bookDetail.bookCategory eq '8'}">selected</c:if>>정치/사회</option>
                                                <option value="9" <c:if test="${bookDetail.bookCategory eq '9'}">selected</c:if>>예술/대중문화</option>
                                                <option value="10" <c:if test="${bookDetail.bookCategory eq '10'}">selected</c:if>>과학</option>
                                                <option value="11" <c:if test="${bookDetail.bookCategory eq '11'}">selected</c:if>>기술/공학</option>
                                                <option value="12" <c:if test="${bookDetail.bookCategory eq '12'}">selected</c:if>>컴퓨터/IT</option>
                                            </select>

                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="success" style="background-color: #f8f8ff">제목</th>
                                        <td colspan="5"><input type="text" name="bookTitle" id="bookTitle" value="${bookDetail.bookTitle}"></td>
                                    </tr>
                                    <tr>
                                        <th style="background-color: #f8f8ff">작가</th>
                                        <td><input type="text" name="bookAuthor" id="bookAuthor" value="${bookDetail.bookAuthor}">
                                        <div style="color: red; font-size: 12px; margin-top: 2px"><spring:hasBindErrors name="bookDto">
                                            <c:if test="${errors.hasFieldErrors('bookAuthor') }">
                                                [ ${errors.getFieldError('bookAuthor').defaultMessage } ]
                                            </c:if>
                                        </spring:hasBindErrors></div></td>
                                        <th style="background-color: #f8f8ff">출판사</th>
                                        <td><input type="text" name="bookPublisher" id="bookPublisher" value="${bookDetail.bookPublisher}">
                                        <div style="color: red; font-size: 12px; margin-top: 2px"><spring:hasBindErrors name="bookDto">
                                            <c:if test="${errors.hasFieldErrors('bookPublisher') }">
                                                [ ${errors.getFieldError('bookPublisher').defaultMessage } ]
                                            </c:if>
                                        </spring:hasBindErrors></div></td>
                                        <th style="background-color: #f8f8ff">출판일</th>
                                        <td><input type="text" name="bookPublishingDate" id="bookPublishingDate" value="${bookDetail.bookPublishingDate}" placeholder="yyyy-mm-dd">
                                        <div style="color: red; font-size: 12px; margin-top: 2px"><spring:hasBindErrors name="bookDto">
                                            <c:if test="${errors.hasFieldErrors('bookPublishingDate') }">
                                                [ ${errors.getFieldError('bookPublishingDate').defaultMessage } ]
                                            </c:if>
                                        </spring:hasBindErrors></div></td>
                                    </tr>
                                    <tr>
                                        <th style="background-color: #f8f8ff">가격<p style="display: inline">(원)</p></th><td>
                                        <input type="number" name="bookPrice" id="bookPrice" value="${bookDetail.bookPrice}">
                                        <div style="color: red; font-size: 12px; margin-top: 2px"><spring:hasBindErrors name="bookDto">
                                            <c:if test="${errors.hasFieldErrors('bookPrice') }">
                                                <spring:message code="${errors.getFieldError('bookPrice').codes[0] }"/>
                                            </c:if>
                                        </spring:hasBindErrors>
                                        </div>
                                        </td>
                                        <th style="background-color: #f8f8ff">재고<p style="display: inline">(개)</p></th><td colspan="3">
                                        <input type="number" name="bookStock" id="bookStock" value="${bookDetail.bookStock}">
                                        <div style="color: red; font-size: 12px; margin-top: 2px"><spring:hasBindErrors name="bookDto">
                                            <c:if test="${errors.hasFieldErrors('bookStock') }">
                                                <spring:message code="${errors.getFieldError('bookStock').codes[0] }"/>
                                            </c:if>
                                        </spring:hasBindErrors>
                                        </div>
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
                                            <input type="file" name="image" id="image" style="margin-bottom: 20px">
                                            <img id="delete" href="" src="/img/btn_delete.png" style="display: inline; margin-left: 200px; width: 20px"/>
                                            <div>
                                            <img src="/image${bookDetail.bookPictureUrl}" style="width: 200px" class="img-responsive" id="image_preview" alt=""/>
                                            </div>
                                        </td>
                                    </tr>

                                </table>
                            </div>
                            <div class="text-center">
                                <input type="button" value="수정하기"  class="btn btn-success" id="update">
                                <input type="button" value="취소하기"  class="btn btn-danger" onclick="history.back()">

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

        let idx = false;

        let imgFile = '<c:out value="${bookDetail.bookPictureUrl}"/>';
        let fileSize;
        let fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/;
        let maxSize = 5 * 1024 * 1024;

        $("#image").change(function(){
            fileSize = document.getElementById("image").files[0].size;
            imgFile = document.getElementById("image").files[0].name;
        });



        $('#update').click(function(){
            if($.trim($('#bookCategory').val()) === '') {
                alert("카테고리를 입력해주세요.");
                $('#bookCategory').focus();
                return false;
            } else if($.trim($('#bookTitle').val()) === ''){
                alert("제목을 입력해주세요.");
                $('#bookTitle').focus();
                return false;
            }else if($.trim($('#bookAuthor').val()) === ''){
                alert("작가를 입력해주세요.");
                $('#authorName').focus();
                return false;
            }else if($.trim($('#bookPublisher').val()) === ''){
                alert("출판사를 입력해주세요.");
                $('#publisher').focus();
                return false;
            }else if($.trim($('#bookPrice').val()) === ''){
                alert("도서가격을 입력해주세요.");
                $('#bookPrice').focus();
                return false;
            }else if($.trim($('#bookPublishingDate').val()) === '') {
                alert("출판일을 입력해주세요.");
                $('#publeYear').focus();
                return false;
            }else if($.trim($('#bookStock').val()) === ''){
                alert("재고를 입력해주세요.");
                $('#bookStock').focus();
                return false;
            }else if($.trim($('#bookContent').val()) === ''){
                alert("도서내용을 입력해주세요.");
                $('#contents').focus();
                return false;
            } else if (!imgFile.match(fileForm)) {
                alert("이미지 파일만 업로드 가능합니다.");
                return false;
            } else if (fileSize === maxSize) {
                alert("파일 사이즈는 5MB까지 가능합니다.")
                return false;
            } else {
                $('#book_update').submit();
            }
        });
    });

</script>

</body>

</html>