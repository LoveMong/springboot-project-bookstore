

$(function (){

    let email;
    let password;

    // 이메일 유효성 검사
    let email_pattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;

    let token = $("meta[name='_csrf']").attr("content");
    let header = $("meta[name='_csrf_header']").attr("content");


    $('#loginBtn').click(function (e){

        e.preventDefault(); // 자동으로 submit을 시키는 것을 막는다.

        email = document.getElementById("memberEmail").value;
        password = document.getElementById("memberPassword").value;

        console.log("email : " + email);

        if (email === "") {
            setMessage_Login("이메일을 입력해주세요.", loginFrm.memberEmail);
            return false;
        }
        else if (email_pattern.test(email) === false) {
            setMessage_Login("이메일 형식이 아닙니다.", loginFrm.memberEmail);
            return false
        }
        else if (password === "") {
            setMessage_Login("비밀번호를 입력해주세요.", loginFrm.memberPassword);
            return false
        } else {
            // $('#loginFrm').attr("action", "/account/sign-in").submit();
            $('#loginFrm').submit();
        }


    });


        function setMessage_Login(loginMessage, element){

            document.getElementById("message_Login").innerHTML = `<i class="fa fa-exclamation-circle"> ${loginMessage}</i>`;

            setTimeout(function (){
                document.getElementById("message_Login").innerHTML = `<div><br></div>`;
            }, 2000);

            if(element) {
                element.select();
            }
        }





});

function join_link() {
    location.href = '/account/sign-up';
}