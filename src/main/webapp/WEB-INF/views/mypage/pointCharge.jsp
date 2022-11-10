<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="_csrf" content="${_csrf.token}">
    <meta name="_csrf_header" content="${_csrf.headerName}">
    <title>Welcome! SJBook Store!</title>
    <link rel="stylesheet" href="/css/mypage/pointCharge.css">
    <script src="https://code.jquery.com/jquery-3.4.1.js"
       integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
       crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="../common/header.jsp"/>

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
					<p>포인트 충전</p>
				</div>
               <div id="main_content_1">

                  <div id="main_content_1_1">
                     <form class="login__input" action="/point/charge" method="post" id="pointfrm">
                     <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                     <sec:authentication property="principal" var="member"/>
                        <input type="hidden" name="memberEmail" id="memberEmail" value="${memberInfo.memberEmail}" readonly="readonly">
                        <input type="hidden" name="pointCharge" id="pointCharge" value="0">
                        <input type="hidden" name="pointCurrent" id="pointCurrent" value="${memberInfo.memberPoint}"> <br>
                        현재 포인트 : <strong id="defaultPoint" class="text-primary"><fmt:formatNumber value="${memberInfo.memberPoint}" pattern="#,###"/></strong>
                        <br/>
                        
                          <label class="form-label mt-4" for="inputValid">충전하실 금액 </label>
                          <input type="text" value="" class="form-control is-valid"  id="charge"  name="point_charge_sum" maxlength= "10" onkeyup="inputNumberFormat(this);">
                          
                          
                          <label class="form-label mt-4" for="inputValid">충전 된 금액 </label>
                          <input type="text" value="" class="form-control is-valid"  readonly="readonly" id="pointSum" name="point_charge_sum" onkeyup="inputNumberFormat(this);">
                          
                          <br/>
                          <input type="submit" class="btn btn-primary" value="충전하기">
                     </form>
                     <br/>
                        <input type="button"  id="addpoint" class="btn btn-warning" value="카카오페이 충전">
                  </div>
                  
                  
                  
               </div>
               
               	<script type="text/javascript"> // input type 금액 콤마 사용
				    function comma(str) {  // 콤마 붙이는 함수
				        str = String(str);
				        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
				    }
				
				    function uncomma(str) { // 콤마 때는 함수
				        str = String(str);
				        return str.replace(/[^\d]+/g, '');
				    } 
				    
				    function inputNumberFormat(obj) { // 숫자만 사용할 수 있는 함수(+콤마)
				        obj.value = comma(uncomma(obj.value));
				    }
				    
				    function inputOnlyNumberFormat(obj) { // 숫자만 사용할 수 있는 함수(콤마x)
				        obj.value = onlynumber(uncomma(obj.value));
				    }
				    
				    function onlynumber(str) {
					    str = String(str);
					    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g,'$1');
					}		
			   </script>
               
               <script>

                  $("#charge").change(function() {
                     var charge = $(this).val();
                     charge = charge.replace(/,/gi, "");
                     if (isNaN(charge)) {
                        alert("충전하실 금액은 숫자로만 입력 부탁드립니다.");
                        return false;
                     }
                     charge = charge.replace(/,/gi, ""); // 정규표현식 변환 str_text.replace(/찾을 문자열/gi, "변경할 문자열") g :전체 문자열 변경 / i :영문 대소문자를 무시, 모두 일치하는 패턴 검색
                     $('#pointCharge').val(charge); // 컨트롤로 넘기기 위한 point_charge 초기화
                     pointSum();
                  });

                  function pointSum() {
                     var defaultPoint = $('#defaultPoint').text();
                     defaultPoint = defaultPoint.replace(/,/gi, "");
                     defaultPoint = Number(defaultPoint);
                     var chargePoint = Number($('#pointCharge').val());
                     

                     console.log("defaultPoint : "+defaultPoint);	
                     console.log("chargePoint : "+chargePoint);	

                     $('#pointCurrent').val(defaultPoint + chargePoint);
                     $('#pointSum').val(defaultPoint + chargePoint);
                  };
               </script>
               <script>
                  $(function() {
                     $('#addpoint')
                           .click(
                                 function() {
                                    var userid = "${login.user_id}";
                                    var pointCharge = $(
                                          '#point_charge').val();
                                    var point = $('#point').val();
                                    if (userid != "") {
                                       if (point != 0) {
                                          $
                                                .ajax({
                                                   type : "POST",
                                                   url : '/kakaopay',
                                                   data : {
                                                      userid : userid,
                                                      pointCharge : pointCharge,
                                                      point : point,
                                                   },
                                                   dataType : 'json',
                                                   success : function(
                                                         data) {
                                                      var box = data.next_redirect_pc_url;
                                                      window
                                                            .open(box);
                                                   },
                                                   error : function(
                                                         error) {
                                                      alert('error : '
                                                            + error);
                                                   }
                                                });
                                       } else {
                                          alert('충전할 포인트를 입력해주세요.');
                                       }
                                    } else {
                                       alert('로그인을 해주세요.')
                                    }
                                 });
                  });
               </script>
            </div>
         </div>
         <div class="clearfix"></div>
      </div>
   </div>
   </div>

   <!-- footer -->
<jsp:include page="../common/footer.jsp"/>

</body>
</html>