
$(function (){

    let email;
    let name;
    let pwd;
    let cpwd;

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

        // email = document.getElementById("memberEmail").value;
        name = document.getElementById("memberName").value;
        pwd = document.getElementById("memberPassword").value;
        cpwd = document.getElementById("memberPassword2").value;


        if (name === "") {
            setMessage_Join("이름을 입력해주세요.", signFrm.memeberName);
        }
        else if (name.length < 2 || name.length > 10) {
            setMessage_Join("이름은 2 ~ 10 사이로 입력해주세요.", signFrm.memeberName);
        }
        else if (name.replace(blank_pattern, '') === "") {
            setMessage_Join("이름에 공백이 포함되었습니다.", signFrm.memeberName);
        }
        else if (blank_pattern_S.test(name) === true) {
            setMessage_Join("이름에 공백이 포함되었습니다.", signFrm.memeberName);
        }
        else if (document.getElementById("mail_check").value === "이메일인증받기") {
            setMessage_Join("메일인증이 필요합니다.", signFrm.memberEmail);
        }
        else if (pwd === "") {
            setMessage_Join("비밀번호를 입력해주세요.", signFrm.memberPassword);
        }
        else if (password_pattern.test(pwd) === false) {
            setMessage_Join("비밀번호는 영문 대소문자와 숫자 4~12자리로 입력해주세요.", signFrm.memberPassword);
        }
        else if (cpwd === "") {
            setMessage_Join("비밀번호를 확인해주세요.", signFrm.memberPassword2);
        }
        else if (pwd !== cpwd) {
            setMessage_Join("비밀번호가 일치하지 않습니다.", signFrm.memberPassword2);
        } else {
            $.ajax({
                type : 'post', // 요청 메서드
                url : '/account/sign-up', // 요청 URI
                beforeSend : function (xhr){
                    xhr.setRequestHeader(header, token);
                },
                data : {memberName : name,
                    memberEmail : email,
                    memberPassword : pwd
                }, // 서버로 전송할 데이터
                success : function (joinSuccessResult) {
                    if(joinSuccessResult === 1) {
                        alert("회원가입에 성공했습니다. 다시 로그인해주세요.");
                        location.href = '/account/sign-in';
                    } else {
                        alert("회원가입에 실패했습니다. 다시 시도해주세요.");
                    }

                },
            })
        }

    });

    function setMessage_Join(joinMessage, element){
        document.getElementById("message_join").innerHTML = `<i class="fa fa-exclamation-circle"> ${joinMessage}</i>`;
        if(element) {
            element.select();
        }
    }




    $('#mail_check').click(function (){


        email = document.getElementById("memberEmail").value;

        if (email === "") {
            setMessage_emailCheck("이메일을 입력해주세요.", signFrm.memberEmail);
        }
        else if (email_pattern.test(email) === false) {
            setMessage_emailCheck("이메일 형식이 아닙니다.", signFrm.memberEmail);
        } else {
            document.getElementById("mail_check").value = "발송완료";
            $('#mail_check').html('메일발송 완료');
            $("#mail_sign_ch").slideDown("slow");

            $.ajax({
                type : 'get', // 요청 메서드
                url : '/account/mailCheck?mail=' + email, // 요청 URI
                beforeSend : function (xhr){
                    xhr.setRequestHeader(header, token);
                },
                success : function (joinSuccessResult) {
                    if(joinSuccessResult === 1) {
                        alert("회원가입에 성공했습니다. 다시 로그인해주세요.");
                        location.href = '/account/sign-in';
                    } else {
                        alert("회원가입에 실패했습니다. 다시 시도해주세요.");
                    }

                },
            })

        }




    });


    function setMessage_emailCheck(joinMessage, element){
        document.getElementById("message_join").innerHTML = `<i class="fa fa-exclamation-circle"> ${joinMessage}</i>`;
        if(element) {
            element.select();
        }
    }



});



// 중복 체크된 아이디 사용
// $('#start').click(function(){
//
//     let member_id = $('#member_id').val();
//
//     opener.jrm.member_id.value = member_id; //opener -> 자식창에서 부모창 선택
//     opener.jrm.idCheck.value = "Check Completed";
//
//     self.close();
//
// });
