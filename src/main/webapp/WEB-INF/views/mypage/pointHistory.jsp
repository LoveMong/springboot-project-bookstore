<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Welcome! SJBook Store!</title>
	<link rel="stylesheet" href="/css/mypage/pointHistory.css">
	<script
	  src="https://code.jquery.com/jquery-3.4.1.js"
	  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	  crossorigin="anonymous"></script>
	<link rel="stylesheet" href="/css/bootstraps/css/bootstrap.css">
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script>
		let msg = '${msg}';
		if (msg !== '') {
			alert(msg);
		}
	</script>

</head>
<body>

<jsp:include page="../common/header.jsp"/>

<div id="wrap">
	
	
	
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
					<form action="/point/history" method="get">
					<div id="main_content_subject">
						<p>포인트 사용내역 / 조회</p>
					</div>
					<div id="main_content_1" style="margin-top: 35px">
						<div class="" style="margin: 10px">
							<p style="margin-right: 10px; float: left; margin-bottom: 30px"> 조회기간 :
							<div class="" style="padding-right:10px; float:left;">
								<input type="text" id="datepickerStart" name="startDate" class="form-control form-control-sm">
							</div>
							<div style="float: left; margin-right: 10px"> ~ </div>
							<div class="" style="padding-right:10px; float:left;">
								<input type="text" id="datepickerEnd" name="endDate" class="form-control form-control-sm">
							</div>
						</div>
						<input type="submit" class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch" value="검색"/>
					</div>
					</form>
						<table id="point_table">
							<thead>
							
								<tr style="background-color: #e9e9e9;">
									<td style="border: 1px solid #d0d0d0">일자</td>
									<td style="width: 22%; border: 1px solid #d0d0d0">내용</td>
									<td style=" width: 22%; border: 1px solid #d0d0d0">충전포인트</td>
									<td style=" width: 22%; border: 1px solid #d0d0d0">사용포인트</td>
									<td style=" width: 22%; border: 1px solid #d0d0d0">남은포인트</td>
								</tr>
							
							</thead>
							
							<tbody>
								
								<c:forEach items="${pointList}" var="list" varStatus="i" >
								<tr>
									<td id="tb_td_year" class="tb_td_year">${list.pointChangeDate }</td>
									<td  class="tb_td_info">
										<c:if test="${list.pointCharge != '0'}">
											충전
										</c:if>
										<c:if test="${list.pointUse != '0'}">
											포인트사용
										</c:if>
									</td>
									<td class="tb_td_state"><fmt:formatNumber value="${list.pointCharge}" pattern="#,###"/></td>
									<td class="tb_td_state"><fmt:formatNumber value="${list.pointUse}" pattern="#,###"/></td>
									<td class="tb_td_btn"><fmt:formatNumber value="${list.pointCurrent}" pattern="#,###"/></td>
								</tr>
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
													<li class="page-item"><a class="page-link" href="<c:url value="/point/history${pageHandler.sc.getQueryString(i)}"/>">${i}</a></li>
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