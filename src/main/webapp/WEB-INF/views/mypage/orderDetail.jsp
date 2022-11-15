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
						<p>주문상품정보</p>
					</div>
					<br>
					<div id="main_content_1" style="margin-top: 20px">
						<table id="point_table">
							<span style="margin-right: 10px ">주문번호</span> <span style="font-weight: bold; color: #0d6efd">${orderDetail[0].orderNumber}</span>
							<thead>
								<tr style="background-color: #e9e9e9; font-size: 13px">
									<td style="width: 20%; border: 1px solid #d0d0d0">상품명</td>
									<td style="border: 1px solid #d0d0d0; width: 5%;">주문 수량</td>
									<td style="border: 1px solid #d0d0d0; width: 7%">가격</td>
									<td style="border: 1px solid #d0d0d0; width: 7%">총 주문 금액</td>
								</tr>
							</thead>
							<tbody style="font-size: 12px">
								<c:forEach items="${bookInfoList}" var="list" varStatus="i" >
								<tr>
									<td id="tb_td_number" class="tb_td_info">
										<span style="display: inline-block;">
											<img src="/image${list.bookPictureUrl}" style="width: 60px; margin: 10px" alt="">
										</span>
										<span style="font-size: 13px">${list.bookTitle}</span>
									</td>
									<td id="tb_td_year" class="tb_td_year">
											${list.bookOrderCount}
									</td>
									<td  class="tb_td_year">
										<fmt:formatNumber value="${list.bookPrice}" pattern="#,###"/> 원
									</td>
									<td class="tb_td_year">
										<span style="color: coral"><fmt:formatNumber value="${list.bookOrderCount * list.bookPrice}" pattern="#,###"/> </span> 원
										<c:set var="totalPrice" value="${totalPrice + (list.bookOrderCount * list.bookPrice)}"/>
									</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>

						<div style="margin-top: 45px; margin-bottom: 20px">결제 정보</div>
						<div class="table-responsive">
							<table class="table" id="book_detail">

								<tr>
									<th style="background-color: #f8f8ff; text-align: center; width: 180px">총 주문 금액</th><td><span><fmt:formatNumber value="${totalPrice}" pattern="#,###"/></span> 원</td>
									<th style="background-color: #f8f8ff; text-align: center; width: 180px">등급 할인 금액</th><td><span><fmt:formatNumber value="${totalPrice - orderDetail[0].orderTotalPrice}" pattern="#,###"/> <sapn> 원</sapn></td>
								</tr>
								<tr>
									<th style="background-color: #f8f8ff; text-align: center; width: 180px">실 결제 금액</th>
									<td><fmt:formatNumber value="${orderDetail[0].orderTotalPrice}" pattern="#,###"/></td>
								</tr>
								<tr>
									<th style="background-color: #f8f8ff; text-align: center; width: 180px">결제하신 금액</th>
									<td><fmt:formatNumber value="${orderDetail[0].orderTotalPrice}" pattern="#,###"/></td>
								</tr>
								<tr>
									<th style="background-color: #f8f8ff; text-align: center; width: 180px">결제 수단</th>
									<td>포인트 결제</td>
								</tr>
							</table>
						</div>
					</div>
				</div>		
			</div>
			<div class="clearfix">
			</div>
		</div>
	</div>
</div>



<jsp:include page="../common/footer.jsp"/>

</body>
</html>
