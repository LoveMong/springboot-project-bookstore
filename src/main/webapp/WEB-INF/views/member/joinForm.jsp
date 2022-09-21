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
			<main class="joinMain">
				<!--회원가입섹션-->
				<section class="join">
					<article class="join__form__container">
						<!--회원가입 폼-->
						<div class="join__form">
							<!--로고-->
							<div class="book_logo mt-0 mb-2" style="    width: 280px;">
	               				<a href="/"> <img src="/img/bk_store2.png" alt=""></a>
	            			</div>
							<!--로고end-->
							<!--회원가입 인풋-->
							<form class="join__input" action="" method="" id="signFrm" name="signFrm">
								<%--@declare id="agree"--%><div id="main_name" class="form-floating mb-4" style="width: 330px">
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
									<c:choose>
										<c:when test="${not empty param.joinMessage}">
											${URLDecoder.decode(param.joinMessage, "utf-8")}
										</c:when>
										<c:otherwise>
											<br>
										</c:otherwise>
									</c:choose>
								</div>
								<div id="agreeAll">
								<label for="agree_all">
									<input type="checkbox" name="agree_all" id="agree_all" style="zoom: 1.3; margin-right: 5px">
									<span style="color: black">전체 동의</span>
								</label><br>
								</div>
								<div id="agree">
									<label for="agree">
										<input type="checkbox" id="check1" name="agree" value="1" style="margin-right: 5px">
										<span>이용약관 동의<strong>(필수)</strong></span>
									</label><br>
									<label for="agree">
										<input type="checkbox" id="check2" name="agree" value="2" style="margin-right: 5px">
										<span>개인정보 수집, 이용 동의<strong>(필수)</strong></span>
									</label><br>
									<label for="agree">
										<input type="checkbox" id="check3" name="agree" value="3" style="margin-right: 5px">
										<span>개인정보 이용 동의<strong>(필수)</strong></span>
									</label><br>
									<label for="agree">
										<input type="checkbox" name="agree" value="4" style="margin-right: 5px">
										<span>이벤트, 혜택정보 수신동의<strong class="select_disable">(선택)</strong></span>
									</label><br>
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
							<a href="/account/sign-in">
								<button type="button" class="btn btn-danger">로그인</button>
							</a>
						</div>
					</article>
				</section>
			</main>
		</div>
	</div>
</body>
</html>

