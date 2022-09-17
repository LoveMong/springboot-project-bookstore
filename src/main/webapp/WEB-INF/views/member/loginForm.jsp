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
<%--    <script src="https://apis.google.com/js/platform.js"></script>--%>
    <script type="text/javascript" src="/js/loginForm.js"></script>
</head>
<body>
<div id="main">
    <div class="main_title" style="margin-top: 80px">
        <!-- 북로고 -->
        <div class="book_logo mt-0 mb-2">
            <a href="/main"> <img src="/img/bk_store2.png" alt=""></a>
        </div>
        <!-- 로그인 -->
<%--        <c:url value='/account/sign-in'/>--%>
        <form class="login__input" action="/login" method="post" id="loginFrm" name="loginFrm">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <div class="form-group" style="margin-top: 50px">
                <label class="form-label mt-4">로그인</label>
                <div id="main_id" class="form-floating mb-3" style="width: 350px">
                    <input type="text" name="memberEmail" class="form-control" id="memberEmail" placeholder="ID">
                    <label for="memberEmail">이메일</label>
                </div>
                <div id="main_pw" class="form-floating" style="width: 350px">
                    <input type="password" name="memberPassword" class="form-control" id="memberPassword" placeholder="PW">
                    <label for="memberPassword">비밀번호</label>
                </div>

                <a href="https://kauth.kakao.com/oauth/authorize?client_id=22968e372ff6eb359a4c50fa6ac2ad49&redirect_uri=http://localhost:8080/kakaoLogin&response_type=code">
                    <img src="/img/kakao_login_medium_narrow.png" style="width: 170px; margin-top: 35px; float: left;">
                </a>
                <div id="button" class="g-signin2" data-onsuccess="onSignIn" style="float: left; margin-left: 10px; width: 170px; margin-top: 35px; height: 40px"></div>
                <br>
                <c:if test="${not empty cookie.user_check}">
                    <c:set value="checked" var="checked" />
                </c:if>

                <fieldset style="clear: left;">
                    <br />
                    <div class="form-check form-switch" style="margin-top: 10px">
                        <input class="form-check-input" type="checkbox" id="remember" name="remember-me">
                        <label class="form-check-label" for="remember" style="margin-right: 160px">자동로그인</label>
                        <a href="/passearch"><label class="form-check-label">비밀번호찾기</label></a>
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

<!-- 구글 로그인 스크립트 -->
<!-- Option 1: Bootstrap Bundle with Popper -->
<%--<script--%>
<%--        src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"--%>
<%--        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"--%>
<%--crossorigin="anonymous"></script>--%>
<%--<!-- Option 2: Separate Popper and Bootstrap JS -->--%>
<%--<script--%>
<%--        src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"--%>
<%--        integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"--%>
<%--crossorigin="anonymous"></script>--%>
<%--<script--%>
<%--        src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"--%>
<%--        integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"--%>
<%--crossorigin="anonymous"></script>--%>
<%--<script>--%>

<%--    function onSignIn(googleUser) {--%>

<%--        var profile = googleUser.getBasicProfile();--%>
<%--        var profile;--%>
<%--        var email;--%>
<%--        var userName;--%>

<%--        email =  profile.getEmail();--%>
<%--        userName = profile.getName();--%>
<%--        console.log("email: " + email);--%>
<%--        console.log('userName: ' + userName);--%>

<%--        $.ajax({--%>
<%--            url: "googleLogin",--%>
<%--            type: "POST",--%>
<%--            data:{--%>
<%--                "email" : email,--%>
<%--                "userName" : userName--%>

<%--            },--%>
<%--            success: function(data) {--%>
<%--                console.log("data: " + data);--%>

<%--                if(data === "suc") {--%>
<%--                    alert("로그인 성공.");--%>

<%--                    location.href="main";--%>

<%--                }--%>
<%--            }--%>

<%--        });--%>
<%--    }--%>
<%--</script>--%>

</body>




</html>