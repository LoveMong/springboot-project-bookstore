<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome! SJBook Store!</title>
<link rel="stylesheet" href="/css/main/search.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="/css/main/slick.css"/>
<link rel="stylesheet" type="text/css" href="/css/main/slick-theme.css"/>
<style>
	.starR1{
    background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat -52px 0;
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float:left;
    text-indent: -9999px;
    cursor: pointer;
}
.starR2{
    background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float:left;
    text-indent: -9999px;
    cursor: pointer;
}
.starR1.on{background-position:0 0;}
.starR2.on{background-position:-15px 0;}

.starR1 {
   
    margin-top: -6px;
}

.starR2 {
	 margin-top: -6px;

}


</style>
</head>
<body>


<jsp:include page="../common/header.jsp"/>
<div id="main_contents">
	
	<div id="main_section" class="mt-3">
		<div id="main_container_">
			<section class="categories-section mt-5">
				<div id="main2_1" class="container">
					<div>
						<span>상품</span><span>${pageHandler.totalCnt}</span>
					</div>
					 <table>
							<c:forEach items="${bookList}" var="book" varStatus="i">
								<tr>
									<td class="table_image" >
										<img src="/image${book.bookPictureUrl}" style="width: 130px;height: 195px;">
									</td>
									<td id="table_info">
										<div class="title">
											<a href="detail?num=${book.bookNum}">
												<%-- <span class="category">[${book.bk_category}]</span> --%>
												<strong class="mr-1">[<span class="main2_1_box_con_cate" id="cate${i.getIndex() }"></span>]</strong>
												<input type="hidden" id="catenum${i.getIndex() }" value="${book.bookCategory }">
												<strong> ${book.bookTitle} </strong>
											</a>
										</div>
										<script>
											$(document).ready(function(){ 
												var cateCodeNum = $('#catenum${i.getIndex() }').val();
												var cateNum = parseInt(cateCodeNum);
												var category = cateSwitch(cateNum);
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
										<form id="buy_form${i}" method="post">
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
												<input type = "hidden" name = "user_id" id = "user_id${i.getIndex()}" value = "${login.user_id }">
												<input type = "hidden" name = "bnum" id = "bnum${i.getIndex()}" value = "${book.bookNum}">
												<input type = "hidden" name = "cartStock" id="odcount${i.getIndex()}"value="cartStock${i.getIndex()}">
												<input type = "button" id = "cart_btn${i.getIndex()}" class="btn btn-block btn-info" value = "장바구니">
												<input type = "button" id = "pay_btn${i.getIndex()}" class="btn btn-block btn-primary" value = "바로결제">
												
											</div>
										</form>
									</td>
								</tr>
								<script>
									$(function(){
										$("#cart_btn${i.getIndex()}").click(function(e){
										const odcount=$('#odcount${i.getIndex()}').val();
										const bknum=$('#bnum${i.getIndex()}').val();
										const userid=$('#user_id${i.getIndex()}').val();
										console.log("odcount : "+odcount);
										console.log("bknum : "+bknum);
										console.log("userid : "+userid);
											if(userid!=null&&userid!=""&&userid!=0){
											if(odcount > 0){
												console.log("carInfo");
												$.ajax({
													type:"POST",
													url:"/addcart",
													data: {
														od_num : odcount,
														bk_num : bknum,
														user_id : userid
													},
													dataType:"text",
													success:function(result){
														const resultSet = $.trim(result);
														if(result==="success"){
															var msg='장바구니에 담겼습니다.'
															alert(msg);
															location.reload();
														}
														else if(result==="fail"){
															var msg='실패했습니다.'
																alert(msg);
														}
														
													}
												});
											}
											else{
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
													var value = parseInt($('#cartStock${i.getIndex()}').val());
													value = value + 1;
													$('#cartStock${i.getIndex()}').val(value);
													$('#odcount${i.getIndex()}').val(value);
												});
											//수량 감소
												$("#btn_minus${i.getIndex()}").click(function(e){
													var value = parseInt($('#cartStock${i.getIndex()}').val());
													if(value <= 0){
														return;
													}
													value = value - 1;
													$('#cartStock${i.getIndex()}').val(value);
													$('#odcount${i.getIndex()}').val(value);
												});
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