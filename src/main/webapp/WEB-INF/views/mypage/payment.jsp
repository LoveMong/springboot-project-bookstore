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
    <form action="/pay/LastPayment" method="post" onsubmit="return submitCheck();">
        <sec:authentication property="principal" var="member"/>
        <div class="allWrap">
            <div id="main_buy_info">
                <div>
                    <strong style="font-size: 25px">구매자정보</strong>
                </div>
                <!-- 구매자 정보 출력(이름/이메일) -->
                <div class="order_cli">
                    <hr />
                    <h3>${member.memberDto.memberName} [${member.memberDto.memberEmail}]</h3>
                </div>
                <div>
                    <input type="hidden" id="memberEmail" value="${member.memberDto.memberEmail}">
                    <input type="hidden" id="memberPoint" value="${member.memberDto.memberPoint}">
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
                    <p class="tab-link" data-tab="tab-2">직접 입력</p>
                </div>
                <!-- 저장된 배송지 선택 TAP -->
                <div id="tab-1" class="tab-content current">

                    <div style="border: 1px solid black">
                        <c:choose>
                            <c:when test="${member.memberDto.memberAddress == null}">
                                <p>기본 배송지가 등록되어있지않습니다.</p>
                                <button type="button" data-toggle="modal" data-target="#myModal" id="comment_update" value="" class="btn btn-danger">배송지 등록</button>
                            </c:when>
                            <c:otherwise>

                            </c:otherwise>
                        </c:choose>
                    </div>

                    <c:choose>
                        <c:when test="empty addrList">
                            <p>배송지를 등록해주세요.</p>
                        </c:when>
                        <c:otherwise>
                            <p>배송지 선택(최근 배송지)</p>
                            <c:forEach var="addressList" items="${addList}" varStatus="vs">
                                <br />
                                <div class="arrdGroup alert alert-dismissible alert-warning">
                                    <div>
                                        <input type="radio" name="addrconfirm" id="liston${vs.getIndex()}" class="liston" value="click${vs.getIndex()}">
                                        <span>받는 사람 : ${addressList.receiverName }</span>
                                        <hr />
                                        <input type="hidden" name="receiver_name" id="receiver_name${vs.getIndex()}" value="${addressList.receiverName }" class="nameValue">
                                        <h4>주소 : ${addressList.receiverAddress }</h4>
                                        <input type="hidden" name="rec_addr" id="rec_addr${vs.getIndex()}" value="${addressList.receiverAddress }" class="addrValue">
                                        <hr />
                                        <h4>휴대전화 : ${addressList.receiverPhone }</h4>
                                        <input type="hidden" name="user_phone" id="user_phone${vs.getIndex()}" value="${addressList.receiverPhone }" class="phoneValue">
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <!-- 배송지 직접 입력 TAP -->
            <div id="tab-2" class="tab-content">

                <div style="margin-top: 50px" class="address_imput_1_wrap">
                    <div class="address_input_1_box">
                        <input class="address_input_1" name="memberAddr1"
                               id="memberAddr1" readonly="readonly">
                    </div>
                </div>

                <div style="margin-top: 5px" class="address_imput_2_wrap">
                    <div class="address_input_2_box">
                        <input class="address_input_2" name="memberAddr2"
                               id="memberAddr2" readonly="readonly">
                    </div>
                </div>

                <div style="margin-top: 5px" class="address_imput_3_wrap">
                    <div class="address_input_3_box">
                        <input class="address_input_3" name="memberAddr3"
                               id="memberAddr3" readonly="readonly">
                    </div>
                </div>

                <div style="margin-bottom: 50px" class="address_button" onclick="execution_daum_address()">
                    <br /> <span type="text" class="btn btn-outline-primary">주소 찾기</span>
                    <div class="clearfix"></div>
                </div>

                <table style="height: 100px">
                    <colgroup>
                        <col width="30%">
                        <col width="*">
                    </colgroup>
                    <tr class="">
                        <td>받는이</td>
                        <td><input type="text" name="orderRec" id="orderRec">
                        </td>
                    </tr>
                    <tr class="">
                        <td>휴대전화</td>
                        <td><input type="text" name="orderPhone" id="orderPhone">
                        </td>
                    </tr>
                </table>
                <div style="margin-top: 30px"><input type="button" class="btn btn-outline-primary" id="addAddr" value="등록"></div>
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
                    <input type="hidden" id="user_id" value="${login.user_id}" name = "PayInfopayInfo[${vs.getIndex()}].userId">
                    <tr>
                        <td class="main_list_col1"><img src="/image${payInfo.bookThumbUrl }" style="width: 100px; height: 110px">
                        </td>
                        <td class="main_list_col2">${payInfo.bookTitle }
                            <input type="hidden" id="bkName${vs.getIndex()}" value="${payInfo.bookTitle }" name = "PayInfolist[${vs.getIndex()}].bkName">
                            <input type="hidden" id="bkNum${vs.getIndex()}" value="${payInfo.bookNum }" name = "PayInfolist[${vs.getIndex()}].bkNum">
                        </td>

                        <td class="main_list_col3">
                                <fmt:formatNumber value="${payInfo.bookPrice}" pattern="#,###" /> 원 | 수량 ${payInfo.bookOrderCount } 개
                            <input type="hidden" id="bkPrice${vs.getIndex()}" value="${payInfo.bookPrice}" name = "PayInfolist[${vs.getIndex()}].bkPrice" >
                            <input type="hidden" id="bkOdcnt${vs.getIndex()}" value="${payInfo.bookOrderCount }" name = "PayInfolist[${vs.getIndex()}].bkOdcnt">
                            <input type="hidden" id="cartNum${vs.getIndex()}" value="${payInfo.cartNum }" name = "PayInfolist[${vs.getIndex()}].cartNum">
                            <c:choose>
                            <c:when test="${login.user_rank == '0'}">
                            <input type="hidden" id="totalPrice${vs.getIndex()}"
                                   value="${payInfo.bookPrice * payInfo.bookOrderCount }">
                            </c:when>
                            <c:when test="${login.user_rank == '1'}">
                            <input type="hidden" id="totalPrice${vs.getIndex()}"
                                   value="${(payInfo.bookPrice * payInfo.bookOrderCount)*0.97 }">
                            </c:when>
                            <c:otherwise>
                            <input type="hidden" id="totalPrice${vs.getIndex()}"
                                   value="${(payInfo.bookPrice * payInfo.bookOrderCount)*0.95 }">
                            </c:otherwise>
                            </c:choose>
                                <c:set var="total" value="${total + (payInfo.bookPrice * payInfo.bookOrderCount)}" /> <!-- 각 제품의 할인된가격 총합 -->
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
                        <c:when test="${login.user_rank == '0'}">
                            <c:set var="sale_price" value="0" />
                            <c:set var="customerInfo" value="일반고객  할인율 없음" />
                        </c:when>
                        <c:when test="${login.user_rank == '1'}">
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
                    <span id="label" class="btn btn-light" style="margin-top: 10px">최종 결제금액</span>
                    <strong id="label_result" style="margin-top: 10px">
                        <span id="number"> <fmt:formatNumber value="${finalTotalPrice}" pattern="#,###" /></span>원
                    </strong>


                    <div class="clearfix"></div>
                    </li>
                </ul>
            </div>
            <div id="final_buy_check">
                <input type="checkbox" name="checkbox" class="btn btn-light" id="agree">
                주문내역 확인 동의<strong><필수></strong>
            </div>
            <div id="final_buy_button">
                <input type="submit" id="lastPayment"
                       class="btn btn-outline-danger" value="결제하기" >
            </div>
        </div>
    </form>
    <br />
    <div class="clearfix"></div>
</div>

<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 108%">
            <div class="modal-header">
                <h4 class="modal-title">배송지 등록</h4>
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


<jsp:include page="../common/footer.jsp"/>




<script>
    // 배송 정보 [기본/입력] 설정
    $('.tab-link').click(function () {
        var tab_id = $(this).attr('data-tab');

        $('.tab-link').removeClass('current');
        $('.tab-content').removeClass('current');

        $(this).addClass('current');
        $("#" + tab_id).addClass('current');

    });
</script>

<script>
    // daum_주소 검색 api
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

    let phone;
    let addr;
    let name;

    // 배송지 등록
    $("#addAddr").click(function(){

        const userID = $('#user_id').val();
        const name = $('#orderRec').val();
        const phone = $('#orderPhone').val();
        const addr = $('#memberAddr1').val() + $('#memberAddr2').val()


        console.log("userID : "+userID);
        console.log("name : "+name);
        console.log("phone : "+phone);
        console.log("addr : "+addr);

        $.ajax({
            url: "regiaddr",
            type: "POST",
            data:{
                "userID" : userID,
                "name" : name,
                "phone" : phone,
                "addr" : addr

            },
            success: function(data) {
                alert("배송지가 등록되었습니다.");
                location.reload();

            }
        });
    });

    // 배송지 선택
    $('.liston').click(function(){

        phone = $(this).parent().find('.phoneValue').val();
        name = $(this).parent().find('.nameValue').val();
        addr = $(this).parent().find('.addrValue').val();

        console.log("name : "+name);
        console.log("phone : "+phone);

    });

</script>



<script>

    $(document).ready(function(){

        let userPoint;
        let totalPrice;

        totalPrice = "<c:out value='${finalTotalPrice}'/>";
        userPoint = "<c:out value='${login.user_point - finalTotalPrice }'/>";

        console.log("totalPrice : " + Math.floor(totalPrice));
        console.log("userPoint : " + Math.floor(userPoint));

        $("#lastPayment").click(function(){

            $.ajax({
                url: "infoPayment",
                type: "POST",
                data:{
                    "addr" : addr,
                    "tPrice" : Math.floor(totalPrice),
                    "uPoint" : Math.floor(userPoint),

                },
                success: function(data) {

                    /* location.href="../mypage/order"; */

                }
            });
        });
    });

</script>

<script>
    function submitCheck(){

        var userPoint = ${login.user_point };
        var finalTotalPrice = Math.floor($('#finalTotalPrice').val());
        var total = ${total};

        if(!$("input:radio[name='addrconfirm']").is(":checked")){

            alert("배송지를 선택해주세요.");

            return false;


        } else if(!$("input:checkbox[name='checkbox']").is(":checked")) {

            alert("결제 동의가 필요합니다.");

            return false;


        } else if(userPoint < finalTotalPrice ) {

            alert("Point 잔액이 부족합니다.");

            return false;

        } else {

            return true;


        }
    }
</script>

<script>
    <%-- 주소 등록 script--%>

    function registerAddress() {

        let token = $("meta[name='_csrf']").attr("content");
        let header = $("meta[name='_csrf_header']").attr("content");

        let address = $('#addAddressModal2').val();
        let addressDetail = $('#addAddressModal3').val();
        let name = $('#addAddressModal_name').val();
        let phone = $('#addAddressModal_phone').val();
        let receiverAddress = address + addressDetail;
        let memberEmail = "${member.memberDto.memberEmail }";


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
                    receiverPhone : phone
                },
                dataType:"text",
                success:function(result){
                    if(result==="등록 성공"){
                        alert("주소 등록 완료");
                        $('#myModal').modal('hide');
                        // location.href = '/order/cart';
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


</html>
