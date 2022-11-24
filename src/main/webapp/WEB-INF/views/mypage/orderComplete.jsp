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
<style>
	.title {
		color: red;
		font-size: 40px;
		margin-bottom: 10px;
	}
	.content1 {
		font-size: 25px;
		margin-bottom: 40px;
	}
	.content2 {
		font-size: 20px;
	}
	.aStyle {
		color: #007bff;
		font-weight: bold;
	}
</style>
<body>

<jsp:include page="../common/header.jsp"/>

<div id="wrap">
	
	<!-- 상단부(로고, 검색창, 로그인창) -->
	
	<div id="main" class="mt-3">
		<div id="main_wrap" style="margin-top: 100px">
			<div id="main_content_wrap" style="margin-top: 25px">
				<img src="/img/complete2.png" alt="" style="width: 20%; float: left; margin-right: 30px">
				<div>
					<h1 class="title">고객님의 주문이 완료 되었습니다.</h1>
					<div class="content1">
						<span>주문내역 및 배송에 관한 안내는 </span><span><a style="color: #007bff; font-weight: bold;" href="/order/myOrders">주문조회</a></span><span>를 통하여 확인 가능합니다.</span>
					</div>

					<div class="content2">
						<fmt:parseDate value="${payInfo.orderDate}" var="orderDate" pattern="yyyy-MM-dd HH:mm:SS"/>
						<span>주문번호 : </span><span>${payInfo.orderNumber}</span><br/>
					</div>

					<div class="content2">
						<span>주문일자 : </span><span><fmt:formatDate value="${orderDate}" pattern="yyyy-MM-dd HH:mm:SS"/></span>
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
