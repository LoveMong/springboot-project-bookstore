<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bs_Store</title>
<link rel="stylesheet" href="/css/admin/bookSearchDetail.css">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script type="text/javascript" src="/js/bookSearchDetail.js"></script>

</head>

<body>
	<div id="wrap">

		<jsp:include page="../common/header.jsp"/>


		<div id="detail_middle" class="categories-section mt-3">
			<div class="container">
				<div id="detail_middle_container" class="clearfix">

					<div id="cover">
						<div id="image">
							<img class="img_size" src="/image${bookDetail.bookPictureUrl}">
						</div>
					</div>
					<div id="title">

						<strong><input type="hidden" id="catenum" value="${bookDetail.bookCategory }"></strong>
						<table>
							<tbody class="detail_intro2">
								<tr>
									<th scope="row">카테고리</th>
									<td id="cate"></td>
								</tr>
								<tr>
									<th scope="row">도서 제목</th>
									<td>${bookDetail.bookTitle}</td>
								</tr>
								<tr>
									<th scope="row">작가</th>
									<td>${bookDetail.bookAuthor}</td>
								</tr>
								<tr>
									<th scope="row">출판사</th>
									<td>${bookDetail.bookPublisher}</td>
								</tr>
								<tr>
									<th scope="row">출간일</th>
									<td>${bookDetail.bookPublishingDate}</td>
								</tr>
								<tr>
									<th scope="row">판매가</th>
									<td style="color: red; font-size: 20px;"><fmt:formatNumber
											value="${bookDetail.bookPrice}" pattern="#,###" /> 원</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div id="purchase">
						<br><span style="font-size: 25px; margin-left: 29px;">
						<c:choose>
							<c:when test="${bookDetail.bookStock != 0}"><span style="color: green "> 구매 가능 </span></c:when>
							<c:otherwise><span style="color: red"> 재고 없음 </span></c:otherwise>
						</c:choose></span>
						<span id="purchase_money1" style="margin-right: 45px">
							<fmt:formatNumber value="${bookDetail.bookPrice}" pattern="#,###" /> 원
						</span>
						<div class="btn_count">
							<label><strong>수량</strong>
								<input type="text" value="0" maxlength="3" id="cartStock" class="input_style02" name="cartStock" readonly="readonly"></label>
								<a class="btn_plus" id="btn_plus">수량 더하기</a> <a class="btn_minus" id="btn_minus">수량 빼기</a>
						</div><br>
						<div id="purchase_btn">
							<br /> <br /> <br />
							<form method="post" action="/pay/payment" id="payfrm">
								<input type="hidden" name="Orderlist[0].chkBox" value="on">
								<input type="hidden" name="Orderlist[0].bk_price" id="bk_price"
									value="${bookDetail.bookPrice }"> <input type="hidden"
									name="Orderlist[0].bk_num" id="bnum" value="${bookDetail.bookNum}">
								<input type="hidden" name="Orderlist[0].bk_ordercnt"
									id="odcount" value="cartStock"> <input type="hidden"
									name="Orderlist[0].bk_totalprice" id="bk_totalprice" value="">
								<span id="purchase_money3">합계금액&nbsp; <span
									style="color: red;" id="allprice"> 0</span>원 <%-- <fmt:formatNumber var="allprice2" value="0" pattern="#,###"/> --%>
								</span>
								<div style="float: right;" class="detail_btn">
									<input class="btn btn-success" type="button" id="cart_btn"
										value="장바구니"> <input class="btn btn-success"
										type="button" id="buy_btn" value="바로구매">
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="tabs mt-3 mb-5" id="tab-area">
						<div id="tab01" class="tab-pane active">
							<div id="detail_main">
								<div id="detail_main_container">
									<div id="book_intro_wrapper">
										<div id="book_intro_subject" style="margin-top: 80px">
											<span>도서 소개</span>
										</div>
										<table class="type02">
											<tbody class="detail_intro">
												<tr>
													<th scope="row">카테고리</th>
													<td id="cate2"></td>
												</tr>
												<tr>
													<th scope="row">도서 제목</th>
													<td>${bookDetail.bookTitle}</td>
												</tr>
												<tr>
													<th scope="row">작가</th>
													<td>${bookDetail.bookAuthor}</td>
												</tr>
												<tr>
													<th scope="row">출판사</th>
													<td>${bookDetail.bookPublisher}</td>
												</tr>
												<tr>
													<th scope="row">출간일</th>
													<td>${bookDetail.bookPublishingDate}</td>
												</tr>
											</tbody>
										</table>
										<div id="book_intro_con">
											<h2><strong>INTRO</strong></h2>
										</div>
										<div id="book_intro_con2">${bookDetail.bookContent}</div>
									</div>
								</div>
							</div>
						</div>


						<div id="tab02" class="tab-pane">
							<div id="detail_reply">
								<div id="detail_reply_container">
									<div id="detail_reply_container_subject">
										<span>평점/리뷰</span>
									</div>
									<br />
									<c:if test="${bookDetail.bookGrade==0 }">
										<div style="text-align: center;">
											<h2><strong style="font-size: 25px">등록된 평점이 없습니다.</strong></h2>
										</div>
									</c:if>
									<c:if test="${bookDetail.bookGrade !=0 }">
										<div style="text-align: center;">
											<h2 style="display: inline-block; margin: 20px;">
												<strong>도서 평점</strong>
											</h2>
											<div class="starRev" id="revStar" style="display: inline-block;">
												<span class="starR1" id="star0" value="0.5">별1_왼쪽</span>
												<span class="starR2" id="star1" value="1">별1_오른쪽</span>
												<span class="starR1" id="star2" value="1.5">별2_왼쪽</span>
												<span class="starR2" id="star3" value="2">별2_오른쪽</span>
												<span class="starR1" id="star4" value="2.5">별3_왼쪽</span>
												<span class="starR2" id="star5" value="3">별3_오른쪽</span>
												<span class="starR1" id="star6" value="3.5">별4_왼쪽</span>
												<span class="starR2" id="star7" value="4">별4_오른쪽</span>
												<span class="starR1" id="star8" value="4.5">별5_왼쪽</span>
												<span class="starR2" id="star9" value="5">별5_오른쪽</span>
												<input type="hidden" id="star_rank" value="${bookDetail.bookGrade }">
											</div>
											<h2 style="display: inline-block; margin: 20px;">(${bookDetail.bookGrade })</h2>
										</div>
									</c:if>
									<br />
									<hr>
									<br />
									<c:forEach items="${bookReview }" var="review" varStatus="i">
										<c:if test="${review.reviewGrade == 0.0}">
											<p>등록된 리뷰가 없습니다.</p>
										</c:if>
										<c:if test="${review.reviewGrade!=null }">
											<s_rp_container>
											<ul class="reply-list">
												<s_rp_rep>
												<div id="book_reply" class="comment_reply">
													<li id="[##_rp_rep_id_##]" class="[##_rp_rep_class_##]">
														<div class="reply-content" style="font-size: 20px;">
															<ul class="info">
																<li>
																	<div class="starRev" id="starRev${i.getIndex() }">
																		<span class="starR1" id="star0" value="0.5">별1_왼쪽</span>
																		<span class="starR2" id="star1" value="1">별1_오른쪽</span>
																		<span class="starR1" id="star2" value="1.5">별2_왼쪽</span>
																		<span class="starR2" id="star3" value="2">별2_오른쪽</span>
																		<span class="starR1" id="star4" value="2.5">별3_왼쪽</span>
																		<span class="starR2" id="star5" value="3">별3_오른쪽</span>
																		<span class="starR1" id="star6" value="3.5">별4_왼쪽</span>
																		<span class="starR2" id="star7" value="4">별4_오른쪽</span>
																		<span class="starR1" id="star8" value="4.5">별5_왼쪽</span>
																		<span class="starR2" id="star9" value="5">별5_오른쪽</span>
																		<span>(${review.reviewGrade})</span> <input type="hidden"
																			id="star_rank" value="${review.reviewGrade}">
																	</div>
																</li>
																<c:set var="name" value="${review.memberEmail}" />
																<c:set var="first" value="${fn:substring(name, 0, 3) }" />
																<li class="nickname">${first}***</li>
																<li class="date">[${review.reviewDate}]</li>
															</ul>
															<p class="text">${review.reviewComment}</p>
															<input type="hidden" id="comment${i.getIndex()}"
																value="${review.reviewComment }"> <input
																type="hidden" id="comrank${i.getIndex() }"
																value="${review.reviewGrade }"> <input type="hidden"
																id="commentnum${i.getIndex()}" value="${review.reviewNum }">
															<ul class="control">
																<c:set var="louserid" value="${login.user_id}" />
																<c:set var="couserid" value="${com.user_id}" />
																<c:if test="${louserid==couserid }">
																	<button type="button"
																		id="comment_delete${i.getIndex()}"
																		value="${com.rev_num}" class="btn btn-success">삭제</button>
																	<button type="button" data-toggle="modal" data-target="#myModal" id="comment_update${i.getIndex()}"
																		value="${com.rev_num}" class="btn btn-danger">수정</button>
																</c:if>
															</ul>
														</div>
													</li>
												</div>
												</s_rp_rep>
											</ul>
											</s_rp_container>
										</c:if>
										<%--  <c:forEach items="${comment }" var="com" varStatus="i"> --%>
										<script>
               $("#comment_delete${i.getIndex()}").click(function(){
                  const revnum=$('#comment_delete${i.getIndex()}').val();
                  const userid="${login.user_id}";
                  console.log("comment_revnum${i.getIndex()} : "+revnum);
                  if(userid!=null&&userid!=""&&userid!=0){
                     $.ajax({
                        type:"GET",
                        url:"/commentDelete",
                        data: {
                           rev_num : revnum
                        },
                        success:function(result){
                           console.log("result")
                           alert('댓글이 삭제되었습니다.');
                           location.reload();
                        }
                     })
                  }
                  else{
                     alert('로그인을 해주세요')
                  }
               });
               $(document).ready(function() {
                  $('#myModal').on('show.bs.modal', function(event) {
                     var idx = $("#rankStar").find("input").val() ; 
                     idx = ( idx - 0.5 )*2
                     idx = Math.floor(idx);
                     $('#rankStar').find('#star'+idx).addClass(' on').prevAll('a').addClass(' on');
                        $('#commentUpdate').click(function(e){
                           const revRank=$('#revRank').val();
                           const revnum=$('#comnum').val();
                           const revcomment=$('#revcom').val();
                           console.log("revnum : "+revnum);
                           console.log("revRank : "+revRank);
                           console.log("revcomment : "+revcomment);
                              $.ajax({
                                 type:"POST",
                                 url:"/commentUpdate",
                                 data: {
                                    rev_rank : revRank,
                                    rev_num : revnum,
                                    rev_comment : revcomment
                                 },
                                 dataType: "text",
                                 success:function(result){
                                    location.reload();
                                 }
                              });
                        });
                     
                  });
               });
            </script>
			<script>
               $('#comment_update${i.getIndex()}').click(function(e){
                  const valuenum = $('#comment_update${i.getIndex()}').val();
                  const valuecom = $('#comment${i.getIndex()}').val();
                  const valuerank = $('#comrank${i.getIndex() }').val();
         
					$('#comnum').val(valuenum);
					$('#revcom').text(valuecom);
					$('#revRank').val(valuerank);
				});
				</script>

									</c:forEach>
									<div id="paginationBox">
										<ul class="pagination justify-content-center">
											<c:if test="${pagination.prev}">
												<li class="page-item"><a class="page-link" href="#"
													onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}')">Previous</a>
												</li>
											</c:if>
											<c:forEach begin="${pagination.startPage}"
												end="${pagination.endPage}" var="idx">
												<li
													class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> ">
													<a class="page-link" href="#"
													onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}')">
														${idx} </a>
												</li>
											</c:forEach>
											<c:if test="${pagination.next}">
												<li class="page-item"><a class="page-link" href="#"
													onClick="fn_next('${pagination.range}', '${pagination.range}', '${pagination.rangeSize}')">Next</a>
												</li>
											</c:if>
										</ul>
									</div>

									<c:if test="${login== null}">
										<div id="replyWarning">
											<div id="replyWarning_subject">평점/리뷰 등록</div>
											<div id="replyWarning_content">로그인후 리뷰 등록 가능합니다.</div>
										</div>

									</c:if>

									<c:if test="${login != null}">
										<div id="replyRegist">
											<div id="replyRegist_content">
												<div id="replyRegist_content_likeStar">
													평점 :
													<div class="starRev">
														<a class="starR1 on" value="0.5">별1_왼쪽</a> <a
															class="starR2" value="1">별1_오른쪽</a> <a class="starR1"
															value="1.5">별2_왼쪽</a> <a class="starR2" value="2">별2_오른쪽</a>
														<a class="starR1" value="2.5">별3_왼쪽</a> <a class="starR2"
															value="3">별3_오른쪽</a> <a class="starR1" value="3.5">별4_왼쪽</a>
														<a class="starR2" value="4">별4_오른쪽</a> <a class="starR1"
															value="4.5">별5_왼쪽</a> <a class="starR2" value="5">별5_오른쪽</a>
													</div>
													<br /> <span>리뷰 : </span> <br> <span
														style="float: left; width: 660px;"> <textarea
															rows="3px" cols="140px" name="repCon" id="revdate"></textarea>
														<input type="hidden" name="user_id" id="userid"
														value="${login.user_id }"> <input type="hidden"
														name="bknum" id="bknum" value="${book.bk_num }"> <input
														type="button" id="reply_btn" value="등록"
														class="btn btn-success">
													</span>
												</div>
											</div>
										</div>
									</c:if>
								</div>
							</div>
						</div>
					
				</div>
			</div>
		</div>
	</div>


<script>

	$(function(){

		$("#cart_btn").click(function(e){
			const odcount=$('#odcount').val();
			const bknum=$('#bnum').val();
			const userid="${login.user_id}";
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
								location.reload();
								alert(msg);
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

	function fn_prev(page, range, rangeSize) {
	   var page = ((range - 2) * rangeSize) + 1;
	   var range = range - 1;
	   var url = "/detail";
	   url = url + "?num=" + ${bk_num};
	   url = url + "&page=" + page;
	   url = url + "&range=" + range;
	   location.href = url;
	}


	function fn_pagination(page, range, rangeSize) {
	   var url = "/detail";
	   url = url + "?num=" + ${bk_num};
	   url = url + "&page=" + page;
	   url = url + "&range=" + range;

	   location.href = url;
	}

	function fn_next(page, range, rangeSize) {
	   var page = parseInt((range * rangeSize)) + 1;
	   var range = parseInt(range) + 1;
	   var url = "/detail";
	   url = url + "?num=" + ${bk_num};
	   url = url + "&page=" + page;
	   url = url + "&range=" + range;
	   location.href = url;
	}

	$("#btn_plus").click(function(e){
		var value = parseInt($('#cartStock').val());
		var bkprice=${book.bk_price };
		value = value + 1;
		$('#cartStock').val(value);
		$('#odcount').val(value);
		var allprice = value*bkprice;
		$('#allprice').text(comma(allprice));
	});

	$("#btn_minus").click(function(e){
		var value = parseInt($('#cartStock').val());
		var bkprice=${book.bk_price };
		if(value <= 0){
			return;
		}
		value = value - 1;
		$('#cartStock').val(value);
		$('#odcount').val(value);
		var allprice = value*bkprice;
		$('#allprice').text(comma(allprice));
	});

	$('#buy_btn').click(function(){
		var user = "${login.user_id}"
		console.log(user);
		if(user===null){
			alert('로그인해주세요');
		}
		else{
			var bkprice = parseInt($('#bk_price').val());
			var odcount = parseInt($('#odcount').val());
			var bk_totalprice = (bkprice*odcount);
			$('bk_totalprice').val(bk_totalprice);
			if(odcount>0){
				$('#payfrm').submit();
			}
			else{
				alert('수량을 입력하세요')
			}

		}
	});

</script>

	<jsp:include page="../common/footer.jsp"/>

<script>


</script>

<div class="modal fade" id="myModal" role="dialog">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <h4 class="modal-title">리뷰 수정</h4>
            <button type="button" class="close" data-dismiss="modal">×</button>
         </div>
            <div class="modal-body">
               <div class="starRev" id="rankStar">
                  <a class="starR1" id="star0" value="0.5">별1_왼쪽</a>
                  <a class="starR2" id="star1" value="1">별1_오른쪽</a>
                  <a class="starR1" id="star2" value="1.5">별2_왼쪽</a>
                  <a class="starR2" id="star3" value="2">별2_오른쪽</a>
                  <a class="starR1" id="star4" value="2.5">별3_왼쪽</a>
                  <a class="starR2" id="star5" value="3">별3_오른쪽</a>
                  <a class="starR1" id="star6" value="3.5">별4_왼쪽</a>
                  <a class="starR2" id="star7" value="4">별4_오른쪽</a>
                  <a class="starR1" id="star8" value="4.5">별5_왼쪽</a>
                  <a class="starR2" id="star9" value="5">별5_오른쪽</a>
                  
                  <input type="hidden" id="revRank" value="">
               </div>
               <br/><br/>
            <textarea rows="4px" cols="55px" id="revcom"></textarea>
            
            <input type="hidden" id="comnum" value="">
         </div>
            <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal" id="commentUpdate">수정</button>
            <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
         </div>
      </div>
   </div>
</div>

<script>

	$(document).ready(function(){

		let book_category = '<c:out value="${bookDetail.bookCategory}"/>';
		console.log("카테고리 : "+ book_category);
		let result = "";

		switch(book_category){
			case "1":
				result = "소설";
				break;
			case "2":
				result = "시/에세이";
				break;
			case "3":
				result = "경제/경영";
				break;
			case "4":
				result = "자기계발";
				break;
			case "5":
				result = "인문";
				break;
			case "6":
				result = "역사/문화";
				break;
			case "7":
				result = "종교";
				break;
			case "8":
				result = "정치/사회";
				break;
			case "9":
				result = "예술/대중문화";
				break;
			case "10":
				result = "과학";
				break;
			case "11":
				result = "기술/공학";
				break;
			case "12":
				result = "컴퓨터/IT";
				break;
		}
		$('#cate').html(result);
		$('#cate2').html(result);


	});

</script>

</body>
</html>