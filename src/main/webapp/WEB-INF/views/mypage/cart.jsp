<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<title>Welcome! SJBook Store!</title>
<link rel="stylesheet" href="/css/mypage/cart.css">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<style>
	#content #main_contents {
		width: calc(100% - 235px);

		float: right;
	}
</style>
</head>


<body>

<jsp:include page="../common/header.jsp"/>

<div id="wrap">

	<div id="main" class="mt-3">
		<div id="main_wrap">
		<div id="main_subject">
			<p>마이페이지</p>
		</div>
	
	<div class="categories-section mt-3">
		<div id="content" class="container">
			<div id="side_menu">
				<jsp:include page="../common/mypage_menu.jsp"/>
			</div>

			<div id="main_contents">
			<div id="main_content_subject">
				<p>장바구니</p>
			</div>
				<div id="nav_main">
					<div id="nav_main_1">
						<form role="form" action="/pay/payment" method="post">
						
						<div id="nav_main_1_cart">
							<div id="nav_main_1_cart_check" class="allCheck">
								<input type="checkbox" id="allCheck" checked="checked"> 전체선택 </div>
								<div id="del_btn">
									<button type="button" class="btn btn-secondary">선택삭제</button></div>
								<div id="nav_main_1_cart_info" class="mt-3">
									<table>
										<thead>
											<tr id="firstrow">
												<td id="c_product_info"colspan="3">상품정보</td>
												<td id="c_price">판매가</td>
												<td id="c_amount">수량</td>
												<td id="c_sum">합계</td>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${cartList}" var="cartInfo" varStatus="i">
											<tr>
												<td id="r_cproduct_check">
													<input type="checkbox" id="chkBox${i.getIndex()}" name="Orderlist[${i.getIndex()}].chkBox" class="chkBox" data-cartId="${cartInfo.cartNum}" checked="checked">
													<input type="hidden" id="cartId${i.getIndex()}" value="${cartInfo.cartNum}" checked="checked">
													<input type="hidden" id="cart_num${i.getIndex()}" name="Orderlist[${i.getIndex()}].cart_num" value="${cartInfo.cartNum}">
													체크
												</td>
												<td id="r_cproduct_image${i.getIndex() }" class="r_cproduct_image">
													<input type="hidden" id="bookId${i.getIndex()}" value="${cartInfo.bookNum }" name="Orderlist[${i.getIndex()}].bk_num">
													<img src="/image${cartInfo.bookThumbUrl}">
												</td>
												<td id="r_cproduct_info">
													<div class="title">
														<a>
															<strong> ${cartInfo.bookTitle} </strong>
														</a>
													</div> 
												</td>
												<td id="r_cprice">
													판매가 :	<strong id="r_cprice${i.getIndex() }" class="bookPrice"><fmt:formatNumber value="${cartInfo.bookPrice}" pattern="#,###"/></strong> 원
													<input type="hidden" value="${cartInfo.bookPrice}" name="Orderlist[${i.getIndex()}].bookPrice">
												</td>
												<td id="r_camount">수량 : 
													<input type="hidden" value="${cartInfo.bookCount}" maxlength="3" id="origin_qty${i.getIndex()}" class="odNum_input" name="Orderlist[${i.getIndex()}].bk_ordercnt">
													<div class="qty_change">
														<input type="text" value="${cartInfo.bookCount}" maxlength="3" id="qty${i.getIndex()}" class="input_style02 od_input" name="Orderlist[${i.getIndex()}].cartStock" readonly="readonly">
														<a class="btn_plus" id="btn_plus${i.getIndex()}">수량 더하기</a>
														<a class="btn_minus" id="btn_minus${i.getIndex()}">수량 빼기</a>
													</div>
												</td>
												<c:set var="cartInfo_sum_price" value="${cartInfo.bookPrice * cartInfo.bookCount}" />
												<input type="hidden" value="${cartInfo.bookPrice * cartInfo.bookCount}" id="price_sum_input${i.getIndex()}" class="price_sum_input" name="Orderlist[${i.getIndex()}].bookPrice">
												<td id="r_csum" class="price_sum"><span class="price_sum${i.getIndex()}">
													<fmt:formatNumber value="${cartInfo_sum_price}" pattern="#,###"/></span>원
												</td>
											</tr>
												<script>
														let prSum = ${cartInfo.bookPrice};
															
														$("#btn_plus${i.getIndex()}").click(function(){
															
															let odNum = document.getElementById("origin_qty${i.getIndex()}").value;

															odNum = Number(odNum) + 1;
																
															document.getElementById('origin_qty${i.getIndex()}').value = odNum;
															document.getElementById('qty${i.getIndex()}').value = odNum;
															
															$('.price_sum${i.getIndex()}').text(comma(prSum * odNum));
															$('#price_sum_input${i.getIndex()}').val(prSum * odNum);
															
															callPriceSum();
				
														});
														
														$("#btn_minus${i.getIndex()}").click(function(){
															
															let odNum = document.getElementById("origin_qty${i.getIndex()}").value;
															if(odNum <= 1) {
																return;
															}
															odNum = Number(odNum) - 1;
																
															document.getElementById("origin_qty${i.getIndex()}").value = odNum;
															document.getElementById('qty${i.getIndex()}').value = odNum;
															
															$('.price_sum${i.getIndex()}').text(comma(prSum * odNum));
															$('#price_sum_input${i.getIndex()}').val(prSum * odNum);
															
															callPriceSum();
														});
												</script>

											</c:forEach>
										</tbody>
									</table>
								</div>
						</div>
						<div id="nav_main_1_result">
							<!-- <div id="nav_main_1_result_head">
								<input type="checkbox"><h1>전체선택</h1>
							</div> -->
			
							<form id="buy_form" method="post" action="pay/payment">
			
							<div id="nav_main_1_result_info">
								<div id="nav_main_1_result_info_hidden"></div>
								<table>
									<thead>
										<tr>	
											<td>상품금액/<span id="bookKinds"></span>종(<span id="bookAmount"></span>개)</td>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td id="result_info_price">
											<input type="hidden" id="priceTotal_input" name="Orderlist.od_totalprice">
												<h1><span id="priceTotal"> 0 </span></h1><h3>원</h3>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						
							<div id="nav_main_1_result_btn">
								<input type="submit" value="결제하기" id="pay_button" class="btn btn-secondary mt-3">
								
							</div>
						</div>


						
						
						
									
						
						</form>
					</div>
				</div>

				
				
				</div>

		
		</div>
	
		
	</div>
	</div>
	</div>

</div>


<script>
	<%-- 가격 콤마 적용 script --%>

	function comma(num){
		let len, point, str;

		num = num + "";
		point = num.length % 3 ;
		len = num.length;

		str = num.substring(0, point);
		while (point < len) {
			if (str !== "") str += ",";
			str += num.substring(point, point + 3);
			point += 3;
		}
		return str;
	}
</script>
<script>
	<%-- 선택된 항목(구매 예정 도서) 삭제 --%>
	$(".btn-secondary").click(function(){

		let token = $("meta[name='_csrf']").attr("content");
		let header = $("meta[name='_csrf_header']").attr("content");

		let selectCheck = $("input[class='chkBox']:checked").length; // 선택 checkbox -> check 적용된 항목 수

		if (selectCheck === 0) {
			alert("삭제할 품목을 선택해주세요.");
			return false;
		}

		let confirm_val = confirm("선택한 상품을 삭제하시겠습니까?");

		if(confirm_val){
			let checkArr = [];
			$("input[class='chkBox']:checked").each(function(){ // 선택된 품목 모두 포함
				checkArr.push($(this).attr("data-cartId")); // 선택된 각 품목의 고유 번호(.attr -> 해당 요소의 속성의 값)을 배열에 저장(.push -> 배열에 저장)
			});

			$.ajax({
				url : "/order/deleteCart",
				type : "post",
				traditional : true,
				data : {"selectNum" : checkArr},
				beforeSend : function (xhr){
					xhr.setRequestHeader(header, token);
				},
				success : function(result){
					if(result === "삭제 성공"){
						location.href = 'cart';
					} else{
						alert(result);
					}
				},error:function(result){
					alert("error");
				}
			});

		}
	});
</script>

<script>
	<%-- 전체 선택 여부 checkbox script --%>
	$("#allCheck").click(function(){
		let check = $('#allCheck').prop("checked");
		if(check){
			//alert($('.chkBox').length);
			$(".chkBox").prop("checked", true);
		} else{
			//alert($('.chkBox').length);
			$(".chkBox").prop("checked", false);
		}
		callPriceSum();
	});
</script>
<script>

	function callPriceSum() {

		let bookCount = 0;
		let number = $("input[class='chkBox']:checked").length; // 선택 checkbox -> check 적용된 항목 수

		if(number <= 0) { // 체크된 항목이 없을 경우
			$('#priceTotal').text("0");
			return;
		}

		$("input[class='chkBox']:checked").each(function(){ // ().each -> 선택된 도서 모두 포함

			let bookPrice = $(this).closest("tr").find(".bookPrice").text(); // 도서 가격
			bookPrice = bookPrice.replace(/,/g, ""); // 도서 가격 콤마 제거
			let odNum = $(this).closest("tr").find(".odNum_input").val(); // 도서 수량

			bookCount = bookCount + ( bookPrice * odNum );

		});

		$('#priceTotal').text(comma(bookCount));
		$('#priceTotal_input').val(bookCount);

	}

	window.onload = function(){
		callPriceSum();
	}

	$(".chkBox").click(function(){
		callPriceSum();
	});

</script>



<jsp:include page="../common/footer.jsp"/>

</body>
</html>