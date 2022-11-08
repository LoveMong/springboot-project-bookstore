<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="_csrf" content="${_csrf.token}">
	<meta name="_csrf_header" content="${_csrf.headerName}">
	<title>Welcome! SJBook Store!</title>
	<link rel="stylesheet" href="/css/mypage/order.css">
	<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="/css/bootstraps/css/bootstrap.css">
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>

<jsp:include page="../common/header.jsp"/>

<div id="wrap">
	
	<!-- 상단부(로고, 검색창, 로그인창) -->
	
	<div id="main" class="mt-3">
		<div id="main_wrap">
		<div id="main_subject">
			<p>마이페이지</p>
		</div>

			<div id="side_menu">
				<jsp:include page="../common/mypage_menu.jsp"/>
			</div>
			<!-- 메인  컨텐츠-->
			<div id="main_content_wrap" style="margin-top: 25px">
				<div id="main_content">
					<div id="main_content_subject">
						<p>주문/배송조회</p>
					</div>
					<br>
					<div id="main_content_1">
						<form action="/order/myOrders" method="get">
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
									   <option value="T" ${pageHandler.sc.option=='T' ? "selected" : ""}>제목</option>
									   <option value="W" ${pageHandler.sc.option=='R' ? "selected" : ""}>수령인</option>
								   </select>
								</div>
							   <div class="w300  float_left" style="padding-right:10px; float:left;">
								   <input type="text" name="keyword" class="form-control form-control-sm-input" type="text" value="${pageHandler.sc.keyword}" placeholder="검색어를 입력해주세요" style="height: 32px">
							   </div>
							   <input type="submit" class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch" value="검색"/>
							</div>
						</form>

						<table id="point_table">
							<thead>
								<tr style="background-color: #e9e9e9;">
									<td style="width: 14%; border: 1px solid grey">주문일자</td>
									<td style="border: 1px solid grey; width: 40%;">주문내역</td>
									<td style="border: 1px solid grey; width: 30%">배송지</td>
									<td style="border: 1px solid grey">배송상태</td>
								</tr>
							</thead>
							<tbody>
							<sec:authentication property="principal" var="member"/>
								<c:forEach items="${myOrderList}" var="list" varStatus="i" >
								<tr>
									<td id="tb_td_year" class="tb_td_year">${list.orderDate }</td>
									<td  class="tb_td_info">
										<a href="/bookSearchDetail?num=${list.cartInfoList[0].bookNum}">
										<span style="display: inline-block;">
											<img src="/image${list.cartInfoList[0].bookPictureUrl}" style="width: 60px;">
										</span>
										<span style="display: inline-block;">
										<span id="productName${i.index }">${list.cartInfoList[0].bookTitle }</span>
										[<span id="amount${i.index}">${list.bookOrderCount } </span>개]
											<br/>
										금액 :
										<c:choose>
												<c:when test="${member.memberDto.memberName == 'GENERAL'}">
													<fmt:formatNumber value="${list.cartInfoList[0].bookPrice*list.bookOrderCount}" pattern="#,###"/>원
												</c:when>
												<c:when test="${member.memberDto.memberName == 'VIP'}">
													<fmt:formatNumber value="${(list.cartInfoList[0].bookPrice*list.bookOrderCount)*0.97}" pattern="#,###"/>원
												</c:when>
												<c:otherwise>
													<fmt:formatNumber value="${(list.cartInfoList[0].bookPrice*list.bookOrderCount)*0.95}" pattern="#,###"/>원
												</c:otherwise>
										</c:choose>											
									</span>
										 </a>
									</td>
									<td class="tb_td_state">${list.memberAddress}</td>
									<td class="tb_td_btn">
										<c:if test="${list.orderState == '0'}">
											배송 준비중
										</c:if>
										<c:if test="${list.orderState == '1'}">
											배송중
										</c:if>
										<c:if test="${list.orderState == '2'}">
											배송완료
										</c:if>
										<input type="hidden" id="orderId${i.index }" value="${list.memberEmail }">
									</td>
								</tr>
									<input type="hidden" id="orderId${i.index}" value="${list.memberEmail}">
								</c:forEach>
							</tbody>
						</table>

						<div>
							<nav aria-label="Page navigation" style="margin-top: 100px">
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
													<li class="page-item"><a class="page-link" href="<c:url value="/order/myOrders${pageHandler.sc.getQueryString(i)}"/>">${i}</a></li>
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
			<div class="clearfix">
			</div>
		</div>
	</div>


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
