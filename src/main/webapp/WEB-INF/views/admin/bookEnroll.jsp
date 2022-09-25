
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="_csrf" content="${_csrf.token}">
	<meta name="_csrf_header" content="${_csrf.headerName}">
	<title>Welcome! Book Store!</title>
	<link rel="stylesheet" href="/css/admin/bookEnroll.css">
	<link rel="stylesheet" href="/css/bootstraps/css/bootstrap.css">
	<script src="https://code.jquery.com/jquery-3.4.1.js"
			integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="/js/bookEnroll.js"></script>
</head>
<body>
<div id="wrap_">
	<!-- 상단부(로고, 검색창, 로그인창) -->
	<div id="main" class="categories-section mt-3">
		<div id="main_wrap" class="container">
			<div class="book_logo mt-5 mb-2" style="width: 280px;">
				<a href="/main"> <img src="/img/bk_store2.png" alt=""></a>
			</div>
			<div id="main_subject">
				<p>관리자페이지</p>
			</div>
			<!-- 사이드 메뉴바 -->
			<div id="side_menu">
				<jsp:include page="../common/admin_menu.jsp"/>
			</div>
			<!-- 메인 컨텐츠-->
			<div id="main_content_wrap">
				<div id="main_content">
					<div class="span9" id="content">
						<div class="row-fluid">
							<div class="alert alert-success">
								<button type="button" class="close" data-dismiss="alert">&times;</button>
								<h4>도서 등록</h4>
							</div>
						</div>
						<div id="searchBookLabel">도서 검색 <p style="display: inline">(검색하여 도서 정보 가져오기)</p></div>
						<div id="searchBook">
							<input id="bookName" type="text" placeholder="도서 제목">
							<button id="search">검색</button>
						</div>
						<div>
							<form action="<c:url value='/admin/enrollBook'/>" method="post" enctype="multipart/form-data" id="book_reg" name="">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<div class="table-responsive">
									<table class="table">
										<tr>
											<th class="success"  style="background: #f8f8ff; padding-left: 20px">분류</th>
											<td colspan="5">
												<select name="bookCategory" id="bookCategory" class="form-span6 m-wrap" style="border: none; background: transparent;">
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
											<th class="success" style="background: #f8f8ff; padding-left: 20px">제목</th>
											<td colspan="5"><input type="text" class="box" name="bookTitle" id="bookTitle"></td>
										</tr>

										<tr>
											<th style="background: #f8f8ff; padding-left: 20px">작가</th>
											<td><input type="text" class="box" name="bookAuthor" id="bookAuthor"></td>
										</tr>

										<tr>
											<th style="background: #f8f8ff; padding-left: 20px">출판사</th>
											<td><input type="text" class="box" name="bookPublisher" id="bookPublisher"></td>
										</tr>

										<tr>
											<th style="background: #f8f8ff; padding-left: 20px">가격<p style="display: inline">(원)</p></th>
											<td><input type="text" class="box" name="bookPrice" id="bookPrice"></td>
										</tr>

										<tr>
											<th style="background: #f8f8ff; padding-left: 20px">출판일</th>
											<td><input type="text" class="box" name="bookPublishingDate" id="bookPublishingDate"></td>
										</tr>

										<tr>
											<th style="background: #f8f8ff; padding-left: 20px">재고 수량<p style="display: inline">(개)</p></th>
											<td><input type="text" class="box" name="bookStock" id="bookStock"></td>
										</tr>


										<tr>
											<th style="background: #f8f8ff; padding-left: 20px">도서 소개</th>
											<td colspan="5">
												<textarea id="bookContent" class="box" style="width:98%;height:200px;" name="bookContent" maxlength="1000"></textarea>
											</td>
										</tr>

										<tr>
											<th style="background: #f8f8ff; padding-left: 20px">도서 표지<p style="display: inline">(미리보기 URL)</p></th>
											<td colspan="5">
												<img id="imageUrl" src="" alt=""></img>
												<input type="hidden" name="bookSearchPictureUrl">
											</td>
										</tr>

										<tr>
											<th style="background: #f8f8ff; padding-left: 20px">도서 표지<p style="display: inline">(첨부하기)</p></th>
											<td colspan="5">
												<input type="file" name="image" id="image">
												<img id="delete" href="" src="/img/btn_delete.png" style="display: inline; margin-left: 200px; width: 20px"/>
												<div class='uploadResult'>
													<div class="upload-img" style="display: flex; width: 130px;">
														<img src="" alt="" id="img-preview" >
													</div>
												</div>
											</td>
										</tr>
									</table>
								</div>
								<div class="text-center">
									<input type="button" value="등록"  class="btn btn-success" id="signUp">
									<input type="reset" value="취소"  class="btn btn-warning">
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="clearfix"></div>
	</div>
</div>


<jsp:include page="../common/footer.jsp"/>

</body>
</html>
