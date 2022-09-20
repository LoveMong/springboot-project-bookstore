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
	<link rel="stylesheet" href="/css/member/searchPasswordForm.css">
	<!-- Bootstrap CSS Link -->
	<link rel="stylesheet"  href="/css/bootstraps/css/bootstrap.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="/js/searchPasswordForm.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>

	<div class="main_title">
		<div class="container">
			<main class="searchPasswordMain">
				<!--회원가입섹션-->
				<section class="searchPassword">
					<article class="searchPassword__form__container">
						<!--회원가입 폼-->
						<div class="login__form">
							<!--로고-->
							<div class="book_logo mt-0 mb-2" style="    width: 280px;">
	               				<a href="/main"> <img src="/img/bk_store2.png" alt=""></a>
	            			</div>
							<div>
								<h1 id="guide_message"> 비밀번호 찾기 </h1>
								<h3 id="guide_message2"> 가입하신 이메일로 인증번호를 보내드립니다. <br> 인증 확인 후 비밀번호를 재설정 할 수 있습니다.</h3>
							</div>
							<!--로고end-->
							<!--회원가입 인풋-->
							<form class="login__input" action="" method="" id="signFrm" name="signFrm">
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
								<div class="form-group text-center" id="message_join">
									<c:choose>
										<c:when test="${not empty param.joinMessage}">
											${URLDecoder.decode(param.joinMessage, "utf-8")}
										</c:when>
										<c:otherwise>
											<br>
										</c:otherwise>
									</c:choose>
								</div>
								<button type="button" class="btn btn-primary" name="signUp" id="signUp" value="회원가입">다음단계</button>
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
