
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
        pwd = document.getElementById("memberPassword").value;
        cpwd = document.getElementById("memberPassword2").value;

        if (pwd === "") {
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
                url : '/account/resetPassword', // 요청 URI
                beforeSend : function (xhr){
                    xhr.setRequestHeader(header, token);
                },
                data : {email : email,
                    password : pwd,
                }, // 서버로 전송할 데이터
                success : function (joinSuccessResult) {
                    if(joinSuccessResult === 1) {
                        swal({
                            icon: 'success',                         // Alert 타입
                            title: '비밀번호 재설정 완료',         // Alert 제목
                            text: '다시 로그인해주세요.',             // Alert 내용
                            button: '확인'
                        }).then((value) => {
                            if(value) {
                                opener.document.location.href = '/account/sign-in';
                                self.close();
                                // location.href = '/account/sign-in';
                            }
                        })
                    } else {
                        Swal.fire({
                            icon: 'error',                         // Alert 타입
                            title: '비밀번호 재설정에 실패했습니다.',         // Alert 제목
                            text: '다시 시도해주세요.',// Alert 내용
                            showConfirmButton: true,
                            timer: 1500
                        });
                    }
                },
            })
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
