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
	<script type="text/javascript" src="/js/resetPasswordForm.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>

	<div class="main_title">
		<div class="container">
			<main class="resetPasswordMain">
				<section class="resetPassword">
					<article class="resetPassword__form__container">
						<div class="resetPassword__form">
							<div>
								<h2 id="guide_message"> 비밀번호 재설정 </h2>
							</div>
							<form class="login__input" action="" method="" id="signFrm" name="signFrm">
								<input type="hidden" name="memberEmail" id="memberEmail" value="${email}">
								<div id="main_pw" class="form-floating mb-4" style="width: 330px">
									<input type="password" name="memberPassword" class="form-control" id="memberPassword" placeholder="Password" required="required">
									<label for="memberPassword">새로운 비밀번호</label>
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
								<button type="button" class="btn btn-primary" name="signUp" id="signUp" value="회원가입">확인</button>
							</form>
						</div>
					</article>
				</section>
			</main>
		</div>
	</div>
</body>
</html>

