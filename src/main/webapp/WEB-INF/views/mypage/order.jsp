<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome! SJBook Store!</title>
<link rel="stylesheet" href="/css/mypage/order.css">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/css/bootstraps/css/bootstrap.css">

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
			<div id="main_content_wrap">
				<div id="main_content">
					<div id="main_content_subject">
						<p>주문/배송조회</p>
					</div>
					<br>
					<div id="main_content_1">
						
						<div class="form-group row justify-content-left" style="margin: 10px">
						<p style="margin-right: 10px"> 조회기간 :
							<div class="w100 float_left" style="padding-right:10px; float:left;">
						    <input type="text" id="datepicker1" class="form-control form-control-sm">
						    </div>
						     ~ 
						    <div class="w100 float_left" style="padding-right:10px; float:left;">
						    <input type="text" id="datepicker2" class="form-control form-control-sm">
						    </div>
					
						</div>
						<br>
						   <div class="form-group row justify-content-left" style="margin: 10px">
							   <div class="w100 float_left" style="padding-right:10px; float:left;">
									<select name="ordersearchType" id="ordersearchType" class="form-control form-control-sm">
										<option value="title">제목 검색</option>
										<option value="content">작가 검색</option>
									</select>
								</div>
									<div class="w300  float_left" style="padding-right:10px; float:left;">	
									<input type="text" name="keyword" class="form-control form-control-sm" id="order_keyword">
									</div>
									<div class="float_left" style=" float:left;">
									<input type="submit" value="검색" class="btn btn-sm btn-primary" id="orderbtnSearch">
									</div>
									<div class="clear_fix" style="clear:both;"></div>
							</div>
						
						<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
						<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
						<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
						<script>
							
							var today = new Date().toLocaleDateString();
						
							
						
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
			                        
			                          $("#datepicker1").datepicker("option", "maxDate", $("#datepicker2").val());
			                          $("#datepicker2").datepicker("option", "minDate", $("#datepicker1").val());
			                      }
			                  }

						    
						  });
						
						  $(function() {	  
							$("#datepicker1").datepicker();
						 	$("#datepicker2").datepicker();
						  });
						
						</script>
					
						<table id="point_table">
							<thead>
							
								<tr style="background-color: #e9e9e9;">
									<td id="th_td_year">일자</td>
									<td id="th_td_info">상품정보</td>
									<td id="th_td_stae">배송지</td>
									<td id="th_td_btn">배송상태</td>
								</tr>
							
							</thead>
							
							<tbody>
							<sec:authentication property="principal" var="member"/>
								<c:forEach items="${myOrderList}" var="list" varStatus="i" >
								<tr>
									<td id="tb_td_year" class="tb_td_year">${list.orderDate }</td>
									<td  class="tb_td_info">
										<a href="/detail?num=${list.cartInfoList[0].bookNum}">
										<span style="display: inline-block;">
											<img src="/image${list.cartInfoList[0].bookPictureUrl}" style="width: 150px;">
										</span>
										<span style="display: inline-block;">
										
										상품명 :<span id="productName${i.index }">${list.cartInfoList[0].bookTitle }</span>
										(<span id="amount${i.index}">${list.bookOrderCount } </span>개)
										<br>
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
						
						<div id="paginationBox" style="text-align: center; margin-top: 20px">
								<ul class="pagination" >
								<c:if test="${pagination.prev}">
									<li class="page-item"><a class="page-link" href="#"
										onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.searchType }','${pagination.keyword }', '${pagination.startDate}', '${pagination.endDate}')">Previous</a></li>
								</c:if>
								
								
								<c:forEach begin="${pagination.startPage}" end="${pagination.endPage }" var="idx">
									<li
										class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> "><a
										class="page-link" href="#"
										onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.searchType }','${pagination.keyword }', '${pagination.startDate}', '${pagination.endDate}')">
											${idx} </a></li>
								</c:forEach>
								<c:if test="${pagination.next}">
									<li class="page-item"><a class="page-link" href="#"
										onClick="fn_next('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.searchType }','${pagination.keyword }', '${pagination.startDate}', '${pagination.endDate}')">Next</a></li>
								</c:if>
								</ul>
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
	//이전 버튼 이벤트
	function fn_prev(page, range, rangeSize, searchType, keyword, startDate, endDate) {
		var page = ((range - 2) * rangeSize) + 1;
		var range = range - 1;
		var url = "${pageContext.request.contextPath}/mypage/order";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&keyword=" + $('#order_keyword').val();
		url = url + "&startDate=" + startDate;
		url = url + "&endDate=" + endDate;
		location.href = url;
	}
	//페이지 번호 클릭
	function fn_pagination(page, range, rangeSize, searchType, keyword, startDate, endDate) {
		var url = "${pageContext.request.contextPath}/mypage/order";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&searchType=" + searchType;
		url = url + "&keyword=" + keyword;
		url = url + "&startDate=" + startDate;
		url = url + "&endDate=" + endDate;
		location.href = url;
	}
	//다음 버튼 이벤트
	function fn_next(page, range, rangeSize, searchType, keyword, startDate, endDate) {
		var page = parseInt((range * rangeSize)) + 1;
		var range = parseInt(range) + 1;
		var url = "${pageContext.request.contextPath}/mypage/order";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&keyword=" + $('#order_keyword').val();
		url = url + "&startDate=" + startDate;
		url = url + "&endDate=" + endDate;
		location.href = url;
	}

	$(document).on('click', '#orderbtnSearch', function(e){
		e.preventDefault();
		var url = "${pageContext.request.contextPath}/mypage/order";

		url = url + "?searchType=" + $('#ordersearchType').val();
		url = url + "&keyword=" + $('#order_keyword').val();

		if($(datepicker1).val() != null && $(datepicker1).val() != '') {
			url = url + "&startDate=" + $('#datepicker1').val();
			url = url + "&endDate=" + $('#datepicker2').val();
		}


		location.href = url;
		console.log(url);
	});


</script>

<jsp:include page="../common/footer.jsp"/>

</body>
</html>
