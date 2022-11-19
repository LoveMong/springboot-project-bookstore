<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="_csrf" content="${_csrf.token}">
    <meta name="_csrf_header" content="${_csrf.headerName}">
    <link rel="stylesheet" href="/css/mypage/payment.css">
    <title>Welcome! SJBook Store!</title>
    <script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
<!-- header -->
<jsp:include page="../common/header.jsp"/>

<div id="main_wrap">
    <form action="/order/payment" method="post" id="payment">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <sec:authentication property="principal" var="member"/>
        <div class="allWrap">
            <div id="main_buy_info">
                <div>
                    <strong style="font-size: 25px">구매자정보</strong>
                </div>
                <!-- 구매자 정보 출력(이름/이메일) -->
                <div class="order_cli">
                    <hr />
                    <h3>${memberInfo.memberName} [${memberInfo.memberEmail}]</h3>
                </div>
                <div>
                    <input type="hidden" name="memberEmail" id="memberEmail" value="${memberInfo.memberEmail}">
                    <input type="hidden" name="memberPoint" id="memberPoint" value="${memberInfo.memberPoint}">
                    <input type="hidden" name="memberRank" id="memberRank" value="${memberInfo.memberRank}">
                    <input type="hidden" name="orderNumber" id="orderNumber" value="">
                </div>
            </div>

            <!-- 배송지 선택 및 입력 -->
            <div id="main_buy_addr">
                <div style="margin-top: 40px">
                    <strong style="font-size: 25px">배송정보</strong>
                </div>
                <hr />
                <div class="tabBox">
                    <p class="tab-link current" data-tab="tab-1">저장 정보</p>
                    <p class="tab-link" data-tab="tab-2">배송지 추가</p>
                </div>
                <!-- 저장된 배송지 선택 TAP -->
                <div id="tab-1" class="tab-content current">
                    <c:choose>
                        <c:when test="${mainAddress == null}">
                            <p style="float: left">기본 배송지</p>
                            <br/>
                            <h4 style="text-align: center; margin-top: 65px"><strong>배송지를 등록해주세요.</strong></h4>
                            <button type="button" data-toggle="modal" data-target="#myModal" class="btn btn-default" style="font-weight: bold; color: darkgreen; padding: 3px; border: 2px outset; margin-left: 510px; margin-top: 20px">등록 하기</button>
<%--                            <button type="button" data-toggle="modal" data-target="#myModal" id="comment_update" value="" class="btn btn-danger">배송지 등록</button>--%>
                        </c:when>
                        <c:otherwise>
                            <p style="float: left">기본 배송지</p>
                            <div style="margin-left: 80px; margin-bottom: 10px">
                            <button type="button" id="mainAddressUpdateBtn" class="btn btn-default" style="font-weight: bold; color: darkgreen; padding: 3px; border: 2px outset" data-toggle="modal" data-target="#updateAddressModal">수정</button>
                            </div>
                            <div class="arrdGroup alert alert-dismissible alert-warning">
                                <div>
                                    <input type="hidden" name="receiverName" id="receiver_name" value="" >
                                    <input type="hidden" name="receiverAddress" id="receiver_address" value="" >
                                    <input type="hidden" name="receiverPhone" id="receiver_phone" value="" >
                                    <input type="radio" name="addrconfirm" id="liston" class="liston" value="click">
                                    <span>받는 사람 : ${mainAddress.receiverName }</span>
                                    <hr />
                                    <input type="hidden" value="${mainAddress.receiverName }" class="nameValue">
                                    <h4>주소 : ${mainAddress.receiverAddress }</h4>
                                    <input type="hidden" value="${mainAddress.receiverAddress }" class="addrValue">
                                    <hr />
                                    <h4>휴대전화 : ${mainAddress.receiverPhone }</h4>
                                    <input type="hidden" value="${mainAddress.receiverPhone }" class="phoneValue">
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <c:choose>
                        <c:when test="${empty addedAddress}">
                        </c:when>
                        <c:otherwise>
                            <br />
                            <br />
                            <p style="margin-top: 20px">최근 배송지(추가된 배송지)</p>
                            <c:forEach var="addressList" items="${addedAddress}" varStatus="vs">
                                <div class="arrdGroup alert alert-dismissible alert-warning">
                                    <div>
                                        <input type="radio" name="addrconfirm" id="liston${vs.getIndex()}" class="liston" value="click${vs.getIndex()}">
                                        <span>받는 사람 : ${addressList.receiverName }</span>
                                        <input type="hidden" value="${addressList.receiverName }" class="nameValue">
                                        <hr />
                                        <h4>주소 : ${addressList.receiverAddress }</h4>
                                        <input type="hidden" value="${addressList.receiverAddress }" class="addrValue">
                                        <hr />
                                        <h4>휴대전화 : ${addressList.receiverPhone }</h4>
                                        <input type="hidden" value="${addressList.receiverPhone }" class="phoneValue">
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- 배송지 추가 입력 TAP -->
            <div id="tab-2" class="tab-content">

                <div class="" style=" display: inline-table; margin-left: 224px;">
                    <div class="addAddress">

                        <table class="" style="margin-top: 25px; margin-bottom: 0px">
                            <tr style="border-top: 0.02em solid black; border-bottom: 0.01em solid darkgray">
                                <th class="success" style="font-weight: bold; background-color: lightgray; font-size: 20px; text-align: center; padding: 12px"> 우편 번호 </th>
                                <td>
                                    <input class="address_input_1" id="addedAddressCode" readonly="readonly" style="border: none; font-size: 20px; margin-left: 10px" size=20>
                                </td>
                            </tr>
                            <tr style="border-bottom: 0.01em solid darkgray">
                                <th style="font-weight: bold; background-color: lightgray; font-size: 20px; text-align: center; padding: 12px"> 기본 주소 </th>
                                <td>
                                    <input class="address_input_2" id="addedAddress" readonly="readonly" style="border: none; font-size: 20px; margin-left: 10px" maxlength=45 size=45>
                                </td>
                            </tr>
                            <tr style="border-bottom: 0.05em solid black">
                                <th style="font-weight: bold; background-color: lightgray; font-size: 20px; text-align: center; padding: 12px "> 상세 주소 </th>
                                <td>
                                    <input class="address_input_3" id="addedAddressDetail" readonly="readonly" style="border: none; margin-left: 10px; font-size: 20px" maxlength=45 size=45>
                                </td>
                            </tr>
                        </table>
                        <div style="margin-bottom: 50px; float: right" class="address_button" onclick="execution_daum_address()">
                            <br /> <span type="text" class="btn btn-outline-primary">주소 찾기</span>
                            <div class="clearfix"></div>
                        </div>
                        <div style="margin-top: 100px">
                            <table style="height: 100px" class="">
                                <tr style="border-top: 0.065em solid black; border-bottom: 0.01em solid darkgray">
                                    <th style="font-weight: bold; background-color: lightgray; font-size: 20px; text-align: center; padding: 12px; ">이름</th>
                                    <td><input type="text" id="addedAddressName" style="border: none; font-size: 20px; margin-left: 10px" maxlength=45 size=45>
                                    </td>
                                </tr>
                                <tr style="border-bottom: 0.05em solid black">
                                    <th style="font-weight: bold; background-color: lightgray; font-size: 20px; text-align: center; padding: 12px">휴대전화</th>
                                    <td><input type="text" id="addedAddressPhone" style="border: none; font-size: 20px; margin-left: 10px" maxlength=45 size=45>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <br/><br/>
                </div>
                <div class="modal-footer" style=" width: 53%; margin-left: 225px;">
                    <button type="button" class="btn btn-default" onclick="registerAddedAddress()">등록</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                </div>
            </div>

            <div id="main_list" style="margin-top: 200px; margin-bottom: 100px">
                <h2>주문상품</h2>
                <table>
                    <thead>
                    <tr id="firstrow">
                        <td class="main_list_head_col1" colspan="2">상품정보</td>
                        <td class="main_list_head_col2">판매가</td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="i" value="0" />
                    <!-- 가격 총합 -->
                    <c:set var="finalTotalPrice" value="0" />
                    <!-- 받을 예정인 포인트 총합 -->
                    <c:set var="finalTotalPoint" value="0" />

                    <c:forEach items="${list}" var="payInfo" varStatus="vs">
<%--                    <input type="hidden" id="user_id" value="${login.user_id}" name = "PayInfopayInfo[${vs.getIndex()}].userId">--%>
                    <tr>
                        <td class="main_list_col1"><img src="/image${payInfo.bookThumbUrl }" style="width: 100px; height: 110px">
                        </td>
                        <td class="main_list_col2">${payInfo.bookTitle }
                            <input type="hidden" id="bkName${vs.getIndex()}" value="${payInfo.bookTitle }" name = "payInfoBook[${vs.getIndex()}].bookTitle">
                            <input type="hidden" id="bkNum${vs.getIndex()}" value="${payInfo.bookNum }" name = "payInfoBook[${vs.getIndex()}].bookNum">
                        </td>

                        <td class="main_list_col3">
                                <fmt:formatNumber value="${payInfo.bookPrice}" pattern="#,###" /> 원 | 수량 ${payInfo.bookOrderCount } 개
                            <input type="hidden" id="bkPrice${vs.getIndex()}" value="${payInfo.bookPrice}" name = "payInfoBook[${vs.getIndex()}].bookPrice" >
                            <input type="hidden" id="bkOdcnt${vs.getIndex()}" value="${payInfo.bookOrderCount }" name = "payInfoBook[${vs.getIndex()}].bookOrderCount">
                            <input type="hidden" id="cartNum${vs.getIndex()}" value="${payInfo.cartNum }" name = "payInfoBook[${vs.getIndex()}].cartNum">
                            <c:choose>
                            <c:when test="${member.memberDto.memberRank == '일반'}">
                            <input type="hidden" id="totalPrice${vs.getIndex()}"
                                   value="${payInfo.bookPrice * payInfo.bookOrderCount }">
                            </c:when>
                            <c:when test="${member.memberDto.memberRank == 'VIP'}">
                            <input type="hidden" id="totalPrice${vs.getIndex()}"
                                   value="${(payInfo.bookPrice * payInfo.bookOrderCount)*0.97 }">
                            </c:when>
                            <c:otherwise>
                            <input type="hidden" id="totalPrice${vs.getIndex()}"
                                   value="${(payInfo.bookPrice * payInfo.bookOrderCount)*0.95 }">
                            </c:otherwise>
                            </c:choose>
                                <c:set var="total" value="${total + (payInfo.bookPrice * payInfo.bookOrderCount)}" /> <!-- 도서 가격 총합 -->
                                <c:set var="count" value="${count + payInfo.bookOrderCount}" /> <!-- 도서 개수 총합 -->
                                <c:set var="discountPrice" value="0" /> <!-- 할인된가격 * 수량 -->
                                <c:set var="discountPriceStock" value="0" /> <!-- 받을 포인트 -->
                                <c:set var="point" value="0" />
                            </c:forEach>
                    </tbody>
                </table>
            </div>

            <div id="main_buy">
                <h2>결제정보</h2>
            </div>
            <br />
        </div>
        <div id="main_right" style="margin-bottom: 150px">
            <div id="final_buy_info">
                <ul>
                    <li class="totalPrice">
                        <!-- <span id="label">상품금액</span> -->
                        <span type="button" class="btn btn-light">상품금액</span> <span id="label_result"><fmt:formatNumber value="${total}" pattern="#,###" />원</span>
                        <div class="clearfix"></div>
                    </li>
                    <li class="shipPrice">
                        <c:if test="${total >= 30000}">
                            <c:set var="shipPrice" value="0" /></c:if>
                        <c:if test="${total < 30000}">
                            <c:set var="shipPrice" value="3500" /></c:if>
                        <span id="label" class="btn btn-light">배송비[주문 금액 30,000원 이상 무료]</span>
                        <span id="label_result">${shipPrice}원</span>
                        <input type="hidden" name="shipPrice" id="shipPrice" value="${shipPrice }">
                        <div class="clearfix"></div></li>
                    <li class="sale_price"><c:choose>
                        <c:when test="${member.memberDto.memberRank == '일반'}">
                            <c:set var="sale_price" value="0" />
                            <c:set var="customerInfo" value="일반고객  할인율 없음" />
                        </c:when>
                        <c:when test="${member.memberDto.memberRank == 'VIP'}">
                            <c:set var="sale_price" value="${total*0.03 }" />
                            <c:set var="customerInfo" value="VIP고객  상품 금액 할인율 3%" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="sale_price" value="${total*0.05 }" />
                            <c:set var="customerInfo" value="VVIP고객  상품 금액 할인율 5%" />
                        </c:otherwise>
                    </c:choose>
                        <span id="label" class="btn btn-light">할인금액 [${customerInfo}]</span>
                        <span id="label_result"><span id="number"> </span>
						    <fmt:formatNumber value="${sale_price}" pattern="#,###" />원</span> <input type="hidden" id="sale_priceInput" name="usePoint" value="0">
                        <div class="clearfix"></div></li>
                    <c:set var="finalTotalPrice" value="${(total+shipPrice)-sale_price }" />
                    <input type="hidden" name="orderTotalPrice" id="totalPrice" value="${finalTotalPrice}">
                    <input type="hidden" name="orderTotalBookCount" id="totalBookCount" value="${count}">
                    <span id="label" class="btn btn-light" style="margin-top: 10px">최종 결제금액</span>
                    <strong id="label_result" style="margin-top: 10px">
                        <span id="number"> <fmt:formatNumber value="${finalTotalPrice}" pattern="#,###" /></span>원
                    </strong>


                    <div class="clearfix"></div>
                </ul>
            </div>
            <div id="final_buy_check">
                <input type="checkbox" name="checkbox" class="btn btn-light" id="agree">주문내역 확인 동의<strong><필수></strong>
            </div>
            <div id="final_buy_button">
                <input type="button" id="paymentBtn" class="btn btn-outline-danger" value="결제하기" >
            </div>
        </div>
    </form>
    <br />
    <div class="clearfix"></div>
</div>


<%-- 배송지 등록 Form Modal --%>
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 108%">
            <div class="modal-header">
                <h4 class="modal-title" id="modalName">배송지 등록</h4>
                <button type="button" class="close" data-dismiss="modal">×</button>
            </div>
            <div class="modal-body">
                <div class="addAddress">

                    <table class="table" style="margin-top: 25px; margin-bottom: 0px">
                    <tr style="border-top: 0.09em solid black">
                        <th class="success" style="font-weight: bold; background-color: lightgray;"> 우편 번호 </th>
                            <td>
                                <input class="address_input_1" id="addAddressModal1" readonly="readonly" style="border: none" size=20>
                            </td>
                    </tr>
                    <tr>
                        <th style="font-weight: bold; background-color: lightgray"> 기본 주소 </th>
                            <td>
                                <input class="address_input_2" id="addAddressModal2" readonly="readonly" style="border: none" maxlength=45 size=45>
                            </td>
                    </tr>
                    <tr style="border-bottom: 0.05em solid black">
                        <th style="font-weight: bold; background-color: lightgray; "> 상세 주소 </th>
                            <td>
                                <input class="address_input_3" id="addAddressModal3" readonly="readonly" style="border: none" maxlength=45 size=45>
                            </td>
                    </tr>
                    </table>
                        <div style="margin-bottom: 50px; float: right" class="address_button" onclick="execution_daum_address()">
                            <br /> <span type="text" class="btn btn-outline-primary">주소 찾기</span>
                            <div class="clearfix"></div>
                        </div>
                    <div style="margin-top: 100px">
                          <table style="height: 100px" class="table">
                            <tr style="border-top: 0.065em solid black">
                                <th style="font-weight: bold; background-color: lightgray">이름</th>
                                <td><input type="text" id="addAddressModal_name" style="border: none" maxlength=45 size=45>
                                </td>
                            </tr>
                            <tr style="border-bottom: 0.05em solid black">
                                <th style="font-weight: bold; background-color: lightgray; ">휴대전화</th>
                                <td><input type="text" id="addAddressModal_phone" style="border: none" maxlength=45 size=45>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <br/><br/>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" onclick="registerAddress()">등록</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>


<%-- 기본 배송주소 변경 Form Modal --%>
<div class="modal fade" id="updateAddressModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 108%">
            <div class="modal-header">
                <h4 class="modal-title" id="">배송지 수정</h4>
                <button type="button" class="close" data-dismiss="modal">×</button>
            </div>
            <div class="modal-body">
                <div class="addAddress">


                    <table >
                        <tr style="border-top: 0.09em solid black;">
                            <th class="success" style="font-weight: bold; background-color: lightgray;  padding: 8px; border-bottom: 0.01em solid black;"> 이전 주소 </th>
                            <td style="border: none; width: 426px; border-bottom: 0.01em solid; height: 40px; padding: 5px;">
                                <input class="address_input_1" id="beforeAddress" readonly="readonly" style="border: none; width: 410px" size=20 value="">
                            </td>
                        </tr>
                    </table>
                    <br/>
                    <p style="margin-bottom: 5px">새로운 주소 입력</p>
                    <table class="table" style="margin-bottom: 0px">
                        <tr style="border-top: 0.09em solid black">
                            <th class="success" style="font-weight: bold; background-color: lightgray;"> 우편 번호 </th>
                            <td>
                                <input class="address_input_1" id="updateAddressModal1" readonly="readonly" style="border: none" size=20>
                            </td>
                        </tr>
                        <tr>
                            <th style="font-weight: bold; background-color: lightgray"> 기본 주소 </th>
                            <td>
                                <input class="address_input_2" id="updateAddressModal2" readonly="readonly" style="border: none" maxlength=45 size=45>
                            </td>
                        </tr>
                        <tr style="border-bottom: 0.05em solid black">
                            <th style="font-weight: bold; background-color: lightgray; "> 상세 주소 </th>
                            <td>
                                <input class="address_input_3" id="updateAddressModal3" readonly="readonly" style="border: none" maxlength=45 size=45>
                            </td>
                        </tr>
                    </table>
                    <div style="margin-bottom: 50px; float: right" class="address_button" onclick="execution_daum_address()">
                        <br /> <span type="text" class="btn btn-outline-primary">주소 찾기</span>
                        <div class="clearfix"></div>
                    </div>
                    <div style="margin-top: 100px">
                        <table style="height: 100px" class="table">
                            <tr style="border-top: 0.065em solid black">
                                <th style="font-weight: bold; background-color: lightgray">이름</th>
                                <td><input type="text" id="updateAddressModal_name" style="border: none" maxlength=45 size=45>
                                </td>
                            </tr>
                            <tr style="border-bottom: 0.05em solid black">
                                <th style="font-weight: bold; background-color: lightgray; ">휴대전화</th>
                                <td><input type="text" id="updateAddressModal_phone" style="border: none" maxlength=45 size=45>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <br/><br/>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="updateMainAddressBtn">수정</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>


<jsp:include page="../common/footer.jsp"/>




<script>
    <%-- 배송정보 선택 tab[저장정보/배송지 추가] srcript--%>

    $('.tab-link').click(function () {
        var tab_id = $(this).attr('data-tab');

        $('.tab-link').removeClass('current');
        $('.tab-content').removeClass('current');

        $(this).addClass('current');
        $("#" + tab_id).addClass('current');

    });
</script>

<script>
    <%-- daum_주소 검색 api script --%>

    function execution_daum_address(){

        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수
                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 주소변수 문자열과 참고항목 문자열 합치기
                    addr += extraAddr;

                } else {
                    addr += ' ';
                }
                $(".address_input_1").val(data.zonecode);
                //$("[name=memberAddr1]").val(data.zonecode);    // 대체가능
                $(".address_input_2").val(addr);
                //$("[name=memberAddr2]").val(addr);            // 대체가능
                // 상세주소 입력란 disabled 속성 변경 및 커서를 상세주소 필드로 이동한다.
                $(".address_input_3").attr("readonly",false);
                $(".address_input_3").focus();

            }
        }).open();

    }
</script>



<script>
    <%-- 배송지 선택 script --%>

    $('.liston').click(function(){

        phone = $(this).parent().find('.phoneValue').val();
        name = $(this).parent().find('.nameValue').val();
        addr = $(this).parent().find('.addrValue').val();

        $('#receiver_address').val(addr);
        $('#receiver_name').val(name);
        $('#receiver_phone').val(phone);

        console.log("name : "+name);
        console.log("phone : "+phone);

    });
</script>

<script>
    <%-- 주소 등록 script--%>

    function registerAddress() {

        let token = $("meta[name='_csrf']").attr("content");
        let header = $("meta[name='_csrf_header']").attr("content");

        let postCode = $('#addAddressModal1').val(); // 우편 번호
        let address = $('#addAddressModal2').val(); // 기본 주소
        let addressDetail = $('#addAddressModal3').val(); // 상세 주소
        let name = $('#addAddressModal_name').val();
        let phone = $('#addAddressModal_phone').val();
        let receiverAddress = address + " " + addressDetail;
        let memberEmail = '<c:out value="${member.memberDto.memberEmail }"/>';
        let addressCheckMain = 'MAIN';
        <%--"${member.memberDto.memberEmail }";--%>


        if (address === null) {
            alert("주소를 입력해주세요.");
            return false;
        } else if (addressDetail === null || addressDetail === "") {
            alert("상세주소를 입력해주세요.");
            return false;
        } else if (name === null || name === "") {
            alert("이름을 입력해주세요.");
            return false;
        } else if (phone === null) {
            alert("핸드폰 번호를 입력해주세요.");
            return false;
        } else {
            $.ajax({
                type:"POST",
                url:"/order/registerAddress",
                beforeSend : function (xhr){
                    xhr.setRequestHeader(header, token);
                },
                data: {
                    memberEmail : memberEmail,
                    receiverAddress : receiverAddress,
                    receiverName : name,
                    receiverPhone : phone,
                    addressCheckMain : addressCheckMain
                },
                dataType:"text",
                success:function(result){
                    if(result==="등록 성공"){
                        alert("주소 등록 완료");
                        $('#myModal').modal('hide');
                        location.reload();
                    }
                    else if(result==="등록 실패"){
                        let msg='실패했습니다.'
                        alert(msg);
                    }
                }
            });

        }


    }

</script>

<script>
    <%-- 주소 추가 등록 script--%>

    function registerAddedAddress() {

        let token = $("meta[name='_csrf']").attr("content");
        let header = $("meta[name='_csrf_header']").attr("content");

        let postCode = $('#addedAddressCode').val(); // 우편 번호
        let address = $('#addedAddress').val(); // 기본 주소
        let addressDetail = $('#addedAddressDetail').val(); // 상세 주소
        let name = $('#addedAddressName').val();
        let phone = $('#addedAddressPhone').val();
        let receiverAddress = address + " " + addressDetail;
        let memberEmail = '<c:out value="${member.memberDto.memberEmail }"/>';
        let addressCheckMain = 'ADDITION';
        <%--"${member.memberDto.memberEmail }";--%>


        if (address === null) {
            alert("주소를 입력해주세요.");
            return false;
        } else if (addressDetail === null || addressDetail === "") {
            alert("상세주소를 입력해주세요.");
            return false;
        } else if (name === null || name === "") {
            alert("이름을 입력해주세요.");
            return false;
        } else if (phone === null) {
            alert("핸드폰 번호를 입력해주세요.");
            return false;
        } else {
            $.ajax({
                type:"POST",
                url:"/order/registerAddress",
                beforeSend : function (xhr){
                    xhr.setRequestHeader(header, token);
                },
                data: {
                    memberEmail : memberEmail,
                    receiverAddress : receiverAddress,
                    receiverName : name,
                    receiverPhone : phone,
                    addressCheckMain : addressCheckMain
                },
                dataType:"text",
                success:function(result){
                    if(result==="등록 성공"){
                        alert("주소 등록 완료");
                        $('#myModal').modal('hide');
                        location.reload();
                    }
                    else if(result==="등록 실패"){
                        let msg='실패했습니다.'
                        alert(msg);
                    }
                }
            });

        }


    }

</script>


<script>
    <%-- 기본 배송주소 변경 script --%>

    $(document).ready(function(){

        let beforeAddress = '<c:out value="${mainAddress.receiverAddress}"/>';
        let name = '<c:out value="${mainAddress.receiverName}"/>';
        let phone = '<c:out value="${mainAddress.receiverPhone}"/>';

        $('#updateAddressModal').on('shown.bs.modal', function (e) {

            $('#beforeAddress').val(beforeAddress);
            $('#updateAddressModal_name').val(name);
            $('#updateAddressModal_phone').val(phone);

            $('#updateMainAddressBtn').click(function(){

                let token = $("meta[name='_csrf']").attr("content");
                let header = $("meta[name='_csrf_header']").attr("content");

                let address = $('#updateAddressModal2').val(); // 기본 주소
                let addressDetail = $('#updateAddressModal3').val(); // 상세 주소
                let name = $('#updateAddressModal_name').val();
                let phone = $('#updateAddressModal_phone').val();
                let receiverAddress = address + " " + addressDetail;
                let memberEmail = '<c:out value="${member.memberDto.memberEmail }"/>';

                if (address === null || address === "") {
                    alert("주소를 입력해주세요.");
                    return false;
                } else if (addressDetail === null || addressDetail === "") {
                    alert("상세주소를 입력해주세요.");
                    return false;
                } else if (name === null || name === "") {
                    alert("이름을 입력해주세요.");
                    return false;
                } else if (phone === null) {
                    alert("핸드폰 번호를 입력해주세요.");
                    return false;
                } else {
                    $.ajax({
                        type:"POST",
                        url:"/order/updateAddress",
                        beforeSend : function (xhr){
                            xhr.setRequestHeader(header, token);
                        },
                        data: {
                            memberEmail : memberEmail,
                            receiverAddress : receiverAddress,
                            receiverName : name,
                            receiverPhone : phone
                        },
                        dataType:"text",
                        success:function(result){
                            if(result==="수정 성공"){
                                alert("주소 수정 완료");
                                location.reload();
                            }
                            else if(result==="수정 실패"){
                                alert("주소 수정 실패");
                            }
                        }
                    });

                }

            });

        });
    });

</script>

<script>

    $("#paymentBtn").click(function(){

        let memberPoint = ${memberInfo.memberPoint};
        let finalTotalPrice = Math.floor(${finalTotalPrice});
        let currentPoint = memberPoint - finalTotalPrice;

        createOrderNumber();

        $('#totalPrice').val(finalTotalPrice);

        if(!$("input:radio[name='addrconfirm']").is(":checked")){

            alert("배송지를 선택해주세요.");

            return false;

        } else if(!$("input:checkbox[name='checkbox']").is(":checked")) {

            alert("결제 동의가 필요합니다.");

            return false;

        } else if(memberPoint < finalTotalPrice ) {

            alert("Point 잔액이 부족합니다.");

            return false;

        } else {

            $('#memberPoint').val(currentPoint);

            $('#payment').submit();

        }


    });



</script>


<script>
    <%-- 주문번호 생성 script --%>
    function createOrderNumber() {

        let orderDate = getCurrentDate(); // 주문일
        let random = Math.floor(1000 + Math.random() * 9000); // 4자리 난수

        let orderNumber = orderDate + random; // 주문번호 생성

        $('#orderNumber').val(parseInt(orderNumber));

    }
</script>

<script>
    <%-- yyyyMMdd 형식의  string 데이터 반환 ( EX : 20210324 ) script --%>
    function getCurrentDate() {
        let date = new Date();
        let year = date.getFullYear().toString();

        let month = date.getMonth() + 1;
        month = month < 10 ? '0' + month.toString() : month.toString();

        let day = date.getDate();
        day = day < 10 ? '0' + day.toString() : day.toString();

        return year + month + day ;
    }
</script>

</html>
