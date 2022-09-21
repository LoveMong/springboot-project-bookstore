
$(function (){

    let email;
    let name;
    let pwd;
    let cpwd;
    let key;

    // 공백만 입력된 경우
    let blank_pattern = /^\s+|\s+$/g;
    //문자열에 공백이 있는 경우
    let blank_pattern_S = /[\s]/g;
    //특수문자가 있는 경우
    let special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
    // 비밀번호 유효성 검사
    let password_pattern = /^[a-zA-z0-9]{4,12}$/;
    // 이메일 유효성 검사
    let email_pattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;

    let token = $("meta[name='_csrf']").attr("content");
    let header = $("meta[name='_csrf_header']").attr("content");


    $('#signUp').click(function (){

        email = document.getElementById("memberEmail").value;

        if (document.getElementById("mail_check").value === "이메일인증받기") {
            setMessage_Join("메일인증이 필요합니다.", signFrm.memberEmail);
        }
        else if (document.getElementById("mail_num_sign").value === "인증번호확인") {
            setMessage_Join("메일인증이 필요합니다.", signFrm.memberEmail);
        } else {
            let url = "/account/resetPassword?email=" + email;
            let popupX = (window.screen.width / 2) - (450 / 2);
            popupX += window.screenLeft;
            let popupY = (window.screen.height / 2) - (400 / 2);
            let option = "toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=450, height=400, left=" + popupX + ", top=" + popupY;
            window.open(url, "_blank", option);
        }

    });



    $('#mail_check').click(function (){

        email = document.getElementById("memberEmail").value;

        if (email === "") {
            setMessage_Join("이메일을 입력해주세요.", signFrm.memberEmail);
        }
        else if (email_pattern.test(email) === false) {
            setMessage_Join("이메일 형식이 아닙니다.", signFrm.memberEmail);
        } else {
            $("#mail_sign_ch").slideDown(1000);
            document.getElementById("mail_check").value = "발송완료";
            document.getElementById("memberEmail").disabled = true;
            $('#mail_check').html('메일발송 완료').css('color', 'aquamarine');

            $.ajax({
                type : 'get', // 요청 메서드
                url : '/account/sendAuthKey?mail=' + email, // 요청 URI
                beforeSend : function (xhr){
                    xhr.setRequestHeader(header, token);
                },
                success : function (checkSuccessResult) {
                        key = checkSuccessResult;
                },
            })
        }
    });


    $('#mail_num_sign').click(function (){

        let entryKey = document.getElementById("user_mail_check").value;

        if (entryKey ==  key) {
            setMessage_Join("인증번호 확인 완료", signFrm.user_mail_check);
            document.getElementById("mail_num_sign").value = "인증완료";
            document.getElementById("user_mail_check").disabled = true;
            $('#mail_num_sign').html('메일인증 완료').css('color', 'aquamarine');
        } else {
            setMessage_Join("인증번호를 확인해주세요.", signFrm.user_mail_check);
        }

    });


    function setMessage_Join(joinMessage, element){

        document.getElementById("message_join").innerHTML = `<i class="fa fa-exclamation-circle"> ${joinMessage}</i>`;

        setTimeout(function (){
            document.getElementById("message_join").innerHTML = `<div><br></div>`;
        }, 2000);

        if(element) {
            element.select();
        }
    }


});
