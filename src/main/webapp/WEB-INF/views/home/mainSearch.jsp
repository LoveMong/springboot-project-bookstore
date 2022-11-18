<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="_csrf" content="${_csrf.token}">
	<meta name="_csrf_header" content="${_csrf.headerName}">
	<title>Welcome! SJBook Store!</title>
	<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="/css/main/search.css">
	<link rel="stylesheet" type="text/css" href="/css/main/slick.css"/>
	<link rel="stylesheet" type="text/css" href="/css/main/slick-theme.css"/>
</head>
<body>

<jsp:include page="../common/header.jsp"/>

<div id="main_contents">
	<div id="main_section" class="mt-3">
		<div id="main_container_">
			<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal" var="member"/>
			</sec:authorize>
			<section class="categories-section mt-5">
				<div id="main2_1" class="container">
					<c:choose>
						<c:when test="${pageHandler.totalCnt == 0}">
							<c:choose>
								<c:when test="${pageHandler.sc.selectOption == 'BEST'}">
									<span style="font-size: 15px; font-weight: bold; color: seagreen;">베스트셀러 > TOP 10</span>
								</c:when>
								<c:when test="${pageHandler.sc.selectOption == 'NEW'}">
									<span style="font-size: 15px; font-weight: bold; color: seagreen;">신간도서 > TOP 10</span>
								</c:when>
								<c:otherwise>
									<span style="font-size: 15px; font-weight: bold; color: seagreen;">인기도서 > TOP 10</span>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<div id="main2_1 header">
								<div>
									<span style="margin-left: 25px; font-size: 18px; font-weight: bold; margin-right: 10px;">전체</span>
									<span style="font-size: 18px; font-weight: bold; color: green;">
									<fmt:formatNumber value="${pageHandler.totalCnt}" pattern="#,###"/>
								</span>
									<span style="font-size: 18px; font-weight: bold">건</span>
								</div>
								<div style="border-top: 1px solid lightgray; border-bottom: 1px solid lightgray; margin-top: 15px; height: 55px; width: 94%; margin-left: 25px; margin-bottom: 30px; padding-top: 15px">
									<c:choose>
										<c:when test="${pageHandler.sc.option == 'A'}">
											<span style="font-size: 15px; font-weight: bold; color: seagreen;">통합검색 > 전체</span>
										</c:when>
										<c:when test="${pageHandler.sc.option == 'T'}">
											<span style="font-size: 15px; font-weight: bold; color: seagreen;">제목검색 > 전체</span>
										</c:when>
										<c:when test="${pageHandler.sc.option == 'R'}">
											<span style="font-size: 15px; font-weight: bold; color: seagreen;">작가검색 > 전체</span>
										</c:when>
										<c:when test="${pageHandler.sc.bookCategory != null}">
											<span id="category" style="font-size: 15px; font-weight: bold; color: seagreen;">${pageHandler.sc.bookCategory}</span>
											<span style="font-size: 15px; font-weight: bold; color: seagreen;"> > 전체</span>
										</c:when>
									</c:choose>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
					 <table>
							<c:forEach items="${bookList}" var="book" varStatus="i">
								<tr>
									<td class="table_image" >
										<img src="/image${book.bookPictureUrl}" style="width: 130px;height: 195px;">
									</td>
									<td id="table_info">
										<div class="title">
											<a href="/bookSearchDetail?num=${book.bookNum}">
												<strong class="mr-1">[<span class="main2_1_box_con_cate" id="cate${i.getIndex() }"></span>]</strong>
												<input type="hidden" id="catenum${i.getIndex() }" value="${book.bookCategory }">
												<strong> ${book.bookTitle} </strong>
											</a>
										</div>
										<script>
											<%--도서 카테고리 번호 한글 표시--%>
											$(document).ready(function(){
												let cateCodeNum = $('#catenum${i.getIndex() }').val();
												let cateNum = parseInt(cateCodeNum);
												let category = cateSwitch(cateNum);
												$('#cate${i.getIndex() }').text(category);
											});
										</script>
										<div class="author">
											<a>${book.bookAuthor}</a> 지음
											<span class="line">|</span>
											<a> ${book.bookPublisher}</a>
											<span class="line">|</span>
											${book.bookPublishingDate}
										</div>
										<div style="margin-top: 5px">
											<span style="font-size: 12px; font-weight: bold; color: gray;">판매지수</span>
											<span style="margin-left: 5px; font-size: 12px; font-weight: bold; color: gray;">
													<fmt:formatNumber value="${book.bookSellCount}" pattern="#,###"/>
											</span>
										</div>
									</td>
									<td id="table_price">
										<div class="org_price">
											<strong style="color:red; font-size:20px;">
											 	<fmt:formatNumber value="${book.bookPrice}" pattern="#,###"/> 원
											 </strong>
										</div>
									</td>
									<td id="table_info3">
										<form id="buy_form${i.getIndex()}" method="post" action="/order/payInfoDirect">
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											<div class="check">
												<span class="btn_count">
													<label><strong>수량</strong>  
														<input type="text" value="0" maxlength="3" id="cartStock${i.getIndex()}" class="input_style02" name="cartStock" readonly="readonly">
													</label>
													<a class="btn_plus" id="btn_plus${i.getIndex()}">수량 더하기</a>
													<a class="btn_minus" id="btn_minus${i.getIndex()}">수량 빼기</a>
												</span>
											</div>
											<div class="button">
												<input type = "hidden" name = "memberEmail" id = "memberEmail${i.getIndex()}" value = "${member.memberDto.memberEmail}">
												<input type = "hidden" name = "bookNum" id = "bookNum${i.getIndex()}" value = "${book.bookNum}">
												<input type = "hidden" name = "bookOrderCount" id="odcount${i.getIndex()}" value="0">
												<input type = "hidden" name = "bookTitle" id="bookTitle${i.getIndex()}" value="${book.bookTitle}">
												<input type = "hidden" name = "bookPrice" id="bookPrice${i.getIndex()}" value="${book.bookPrice}">
												<input type = "hidden" name = "bookThumbUrl" id="bookThumbUrl${i.getIndex()}" value="${book.bookThumbUrl}">
												<input type = "button" id = "cart_btn${i.getIndex()}" class="btn btn-block btn-info" value = "장바구니">
												<input type = "button" id = "pay_btn${i.getIndex()}" class="btn btn-block btn-primary" value = "바로결제">
											</div>
										</form>
									</td>
								</tr>
								<script>
									$(function(){
										$("#cart_btn${i.getIndex()}").click(function(e){

											let token = $("meta[name='_csrf']").attr("content");
											let header = $("meta[name='_csrf_header']").attr("content");

											const odcount = $('#odcount${i.getIndex()}').val();
											const bookNum = $('#bookNum${i.getIndex()}').val();
											const memberEmail = $('#memberEmail${i.getIndex()}').val();
											console.log("bookOrderCount : "+odcount);
											console.log("bookNum : "+bookNum);
											console.log("memberEmail : "+memberEmail);

											if(memberEmail!==null && memberEmail!==""){
												if(odcount > 0){
													console.log("carInfo");
													$.ajax({
														type:"POST",
														url:"/order/addCart",
														data: {
															bookOrderCount : odcount,
															bookNum : bookNum,
															memberEmail : memberEmail
														},
														beforeSend : function (xhr){
															xhr.setRequestHeader(header, token);
														},
														dataType:"text",
														success:function(result){
															const resultSet = $.trim(result);
															if(result==="등록 성공"){
																let msg='장바구니에 담겼습니다.'
																alert(msg);
																location.reload();
															}
															else if(result==="등록 실패"){
																let msg='실패했습니다.'
																	alert(msg);
															}
														}
													});
												} else {
													alert('수량을 선택해주세요');
												}
											}
											else{
												alert('로그인 해주세요')
											}
										});
									});
									</script>
									<script>
										$(document).ready(function(){
											//alert("연결");
											// 이미지 불러오기
												$("#btn_plus${i.getIndex()}").click(function(e){
													let value = parseInt($('#cartStock${i.getIndex()}').val());
													value = value + 1;
													$('#cartStock${i.getIndex()}').val(value);
													$('#odcount${i.getIndex()}').val(value);
												});
											//수량 감소
												$("#btn_minus${i.getIndex()}").click(function(e){
													let value = parseInt($('#cartStock${i.getIndex()}').val());
													if(value <= 0){
														return;
													}
													value = value - 1;
													$('#cartStock${i.getIndex()}').val(value);
													$('#odcount${i.getIndex()}').val(value);
												});
										});
										</script>
										<script>

											$("#pay_btn${i.getIndex()}").click(function(e) {

												const odcount = $('#odcount${i.getIndex()}').val();
												const memberEmail = $('#memberEmail${i.getIndex()}').val();

												if (memberEmail === "") {
													alert("로그인 해주세요.")
													return false;
												} else if (odcount === "0") {
													alert("수량을 선택해주세요.");
													return false;
												} else {
													$('#buy_form${i.getIndex()}').submit();
												}

											});

										</script>
							</c:forEach>
					</table>
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
			</section>
		</div>
	</div>

	<jsp:include page="../common/footer.jsp"/>
	
</div>

<script>
	$(document).ready(function() {

		let num = ${pageHandler.sc.bookCategory};
		console.log(num);
		let cateNum = cateSwitch(parseInt(num));
		console.log(cateNum);
		$('#category').text(cateNum);
	});
</script>
<script>
	function cateSwitch(val) {
		var result = "";
		switch(val){
			case 1:
				result = "소설";
				break;
			case 2:
				result = "시/에세이";
				break;
			case 3:
				result = "경제/경영";
				break;
			case 4: 
				result = "자기계발";
				break;
			case 5: 
				result = "인문";
				break;
			case 6: 
				result = "역사/문화";
				break;
			case 7: 
				result = "종교";
				break;
			case 8: 
				result = "정치/사회";
				break;
			case 9: 
				result = "예술/대중문화";
				break;
			case 10: 
				result = "과학";
				break;
			case 11: 
				result = "기술/공학";
				break;
			case 12: 
				result = "컴퓨터/IT";
				break;
		}
		return result;
	}
</script>



</body>
</html>