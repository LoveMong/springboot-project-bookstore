<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="/css/member/loginForm.css">
    <link rel="stylesheet" href="/css/bootstraps/css/bootstrap.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <meta name="google-signin-scope" content="profile email">
    <meta name="google-signin-client_id" content="770076919086-eq6fgbjuq59078luff512ol07ifc52h8.apps.googleusercontent.com">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript" src="/js/loginForm.js"></script>
</head>
    <body>
        <div id="main">
            <div class="main_title" style="margin-top: 80px">
                <!-- 북로고 -->
                <div class="book_logo mt-0 mb-2">
                    <a href="/main"> <img src="/img/bk_store2.png" alt=""></a>
                </div>
                <!-- 구글 로그인 -->
                <a href="/oauth2/authorization/google">
                    <img src="/img/btn_google.png" id="btn_google">
                </a>
                <!-- 로그인 -->
                <form class="login__input" action="/login" method="post" id="loginFrm" name="loginFrm">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <div class="form-group">
                        <label class="form-label mt-4" id="line">또는 이메일로 로그인</label>
                        <div id="main_id" class="form-floating mb-3" style="width: 350px">
                            <input type="text" name="memberEmail" class="form-control" id="memberEmail" placeholder="ID">
                            <label for="memberEmail">이메일</label>
                        </div>
                        <div id="main_pw" class="form-floating" style="width: 350px">
                            <input type="password" name="memberPassword" class="form-control" id="memberPassword" placeholder="PW">
                            <label for="memberPassword">비밀번호</label>
                        </div>
                        <br>
                        <c:if test="${not empty cookie.user_check}">
                            <c:set value="checked" var="checked" />
                        </c:if>
                        <fieldset style="clear: left;">
                            <br />
                            <div class="form-check form-switch" style="margin-top: 10px">
                                <input class="form-check-input" type="checkbox" id="remember" name="remember-me">
                                <label class="form-check-label" for="remember" style="margin-right: 160px">자동로그인</label>
                                <a href="/account/searchPassword">비밀번호찾기</a>
                            </div>
                        </fieldset>
                    </div>
                </form>
                <div class="form-group text-center" id="message_Login" style="color: red; margin-top: 35px">
                    <c:choose>
                        <c:when test="${not empty param.loginMessage}">
                            ${URLDecoder.decode(param.loginMessage, "utf-8")}
                        </c:when>
                        <c:when test="${not empty param.message}">
                            ${param.message}
                        </c:when>
                        <c:otherwise>
                            <br>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div style="margin-top: 30px;">
                    <button type="button" id="loginBtn" class="btn btn-warning" style="width:350px; color: white;background-color: #ff7f00;">로그인</button>
                    <br />
                    <button type="button" class="btn btn-warning" style="width: 350px;margin-top: 15px;color: black;background-color: #e9ecef;border-color: #e9ecef;" onclick="join_link(); return false;">이메일로 회원가입</button>
                    <br /> <br />
                </div>
            </div>
        </div>
    </body>
</html>