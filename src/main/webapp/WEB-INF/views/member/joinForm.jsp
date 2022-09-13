<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- ajax 통신을 위한 meta tag -->
	<meta name="_csrf" content="${_csrf.token}">
	<meta name="_csrf_header" content="${_csrf.headerName}">
	<title>BookStore</title>
	<!--  CSS Link -->
	<link rel="stylesheet" href="/css/member/joinForm.css">
	<!-- Bootstrap CSS Link -->
	<link rel="stylesheet"  href="/css/bootstraps/css/bootstrap.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="/js/joinForm.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>

	<div class="main_title">
		<div class="container">
			<main class="loginMain">
				<!--회원가입섹션-->
				<section class="login">
					<article class="login__form__container">
						<!--회원가입 폼-->
						<div class="login__form">
							<!--로고-->
							<div class="book_logo mt-0 mb-2" style="    width: 280px;">
	               				<a href="/main"> <img src="/img/bk_store2.png" alt=""></a>
	            			</div>
							<!--로고end-->
							<!--회원가입 인풋-->
							<form class="login__input" action="" method="" id="signFrm" name="signFrm">
								<div id="main_name" class="form-floating mb-4" style="width: 330px">
									<input type="text" name="memberName" class="form-control" id="memberName" placeholder="Name" required="required">
									<label for="memberName">이름</label>
								</div>
								<div class="form-floating mb-4">
									<div id="mail_sign" class="form-floating mb-4" style="width: 330px">
										<input type="email" name="memberEmail" class="form-control" id="memberEmail" placeholder="E-mail" required="required">
										<label for="memberEmail">이메일 </label>
									</div>
									<div><button type="button" id="mail_check" value="이메일인증받기" class="btn btn-success">인증메일 발송</button></div>
								</div>
								<div id="mail_sign_ch" class="form-floating mb-4" style="display: none">
									<input type="text" class="form-control mb-3" id="user_mail_check" placeholder="Number" required="required">
									<label for="user_mail_check">인증번호 입력  </label>
									<button type="button" id="mail_num_sign" value="인증번호확인" class="btn btn-success">인증번호 확인</button>
								</div>
								<div id="main_pw" class="form-floating mb-4" style="width: 330px">
									<input type="password" name="memberPassword" class="form-control" id="memberPassword" placeholder="Password" required="required">
									<label for="memberPassword">비밀번호</label>
								</div>
								<div id="main_pw2" class="form-floating mb-4" style="width: 330px">
									<input type="password" name="memberPassword2" class="form-control" id="memberPassword2" placeholder="Check" required="required">
									<label for="memberPassword2">비밀번호 확인</label>
								</div>
								<div class="form-group text-center" id="message_join">
									<c:if test="${not empty param.joinMessage}">
										<i class="fa fa-exclamation-circle"> ${URLDecoder.decode(param.joinMessage, "utf-8")}</i>
									</c:if>
								</div>
								<button type="button" class="btn btn-primary" name="signUp" id="signUp" value="회원가입">회원가입</button>
							</form>
							<!--회원가입 인풋end-->
						</div>
						<!--회원가입 폼end-->
						<br/>
						<!--계정이 있으신가요?-->
						<div class="login__register">
							<span>계정이 있으신가요?</span>
							<a href="/login">
								<button type="button" id="loginBtn" class="btn btn-danger">로그인</button>
							</a>
						</div>
					</article>
				</section>
			</main>
		</div>
	</div>
	

</body>

</html>
<%--<script type="text/javascript">--%>
<%--	$(document).ready(function(e) {--%>

<%--		var idx = false;--%>
<%--		var check_main_num ;--%>
<%--		var check_main_num_ck;--%>
<%--		var check_same_mail;--%>


<%--		$('#signUp').click(function() {--%>
<%--			if ($.trim($('#user_id').val()) == "") {--%>
<%--				alert("아이디를 입력해주세.");--%>
<%--				$('#user_id').focus();--%>
<%--				return;--%>
<%--			} else if ($.trim($('#user_pw').val()) == '') {--%>
<%--				alert("패스워드를 입력해주세.");--%>
<%--				$('#user_pw').focus();--%>
<%--				return;--%>
<%--			} else if ($.trim($('#user_phone').val()) == '') {--%>
<%--				alert("핸드폰 번호를 입력해주세요.");--%>
<%--				$('#user_phone').focus();--%>
<%--				return;--%>
<%--			} else if (check_main_num_ck == '' || check_main_num_ck == null) {--%>
<%--				alert("이메일 인증을해주세요.");--%>
<%--				$('#user_mail').focus();--%>
<%--				return;--%>
<%--			} else if ($.trim($('#user_name').val()) == '') {--%>
<%--				alert("이름을 입력해주세요.");--%>
<%--				$('#user_name').focus();--%>
<%--				return;--%>
<%--			} else if ($.trim($('#user_pw2').val()) == '') {--%>
<%--				alert("비밀번호를 확인해주세요.");--%>
<%--				$('#user_pw2').focus();--%>
<%--				return;--%>
<%--			} else if ($.trim($('#user_pw').val()) != $.trim($('#user_pw2').val())) {--%>
<%--				alert("비밀번호를 확인해주세요.");--%>
<%--				$('#user_pw2').focus();--%>
<%--				return;--%>
<%--			} else if ($("#user_email").val() != check_same_mail ) {--%>
<%--				alert("인증한 메일과 현재 이메일이 같지 않습니다 확인 부탁드립니다.");--%>
<%--				$('#user_mail').focus();--%>
<%--				return;--%>
<%--			}--%>

<%--			if (idx == false) {--%>
<%--				alert("아이디 중복체크를 해주세요.");--%>
<%--				return;--%>
<%--			} else {--%>
<%--				$('#signFrm').submit();--%>
<%--			}--%>
<%--		});--%>

<%--		$('#check').click(function() {--%>
<%--			$.ajax({--%>
<%--				url : "${pageContext.request.contextPath}/idCheck",--%>
<%--				type : "GET",--%>
<%--				data : {--%>
<%--					"user_id" : $('#user_id').val()--%>
<%--				},--%>
<%--				success : function(data) {--%>
<%--					if (data == 0 && $.trim($('#user_id').val()) != '') {--%>
<%--						idx = true;--%>
<%--						alert("사용 가능한 아이디 입니다.")--%>
<%--					} else {--%>
<%--						alert("사용 불가능한 아이디 입니다.")--%>
<%--					}--%>
<%--				},--%>
<%--				error : function() {--%>
<%--					alert("서버에러");--%>
<%--				}--%>
<%--			});--%>
<%--		});--%>




<%--		/* 인증번호 이메일 전송 */--%>
<%--		$("#mail_check").click(function(){--%>
<%--			var email = $("#user_email").val();--%>
<%--			var cehckBox = $("#mail_sign");        // 인증번호 입력란--%>
<%--			var boxWrap = $(".mail_check_input_box");   // 인증번호 입력란 박스--%>
<%--			check_same_mail = $("#user_email").val();--%>
<%--			// $("#mail_check").slideUp();--%>
<%--			$("#mail_sign_ch").slideDown("slow");--%>

<%--			$.ajax({--%>

<%--				type : "GET",--%>
<%--				url : "${pageContext.request.contextPath}/emailCheck?email=" + email ,--%>
<%--				success:function(data){--%>
<%--					//console.log("data : " + data);--%>

<%--					check_main_num = data;--%>
<%--				}--%>

<%--			});--%>


<%--		});--%>

<%--		/* 인증번호 이메일 전송 */--%>
<%--		$("#mail_num_sign").click(function(){--%>

<%--			if(check_main_num == $("#user_mail_check").val()) {--%>
<%--				alert("인증완료");--%>
<%--				check_main_num_ck = "mail_check";--%>
<%--			} else {--%>
<%--				alert("인증번호를 확인하세요.");--%>
<%--				$('#user_mail_check').focus();--%>

<%--			}--%>

<%--		});--%>


<%--	});--%>

<%--</script>--%>
