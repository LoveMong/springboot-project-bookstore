
let id;
let jpwd;
let cpwd;
let name;
let email;
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


$(document).ready(function(){

// login_register 폼 변경 TAP
    $('#login-form-link').click(function(e) {
        $("#login-form").delay(100).fadeIn(100);
        $("#register-form").fadeOut(100);
        $('#register-form-link').removeClass('active');
        $(this).addClass('active');
        e.preventDefault();
    });
    $('#register-form-link').click(function(e) {
        $("#register-form").delay(100).fadeIn(100);
        $("#login-form").fadeOut(100);
        $('#login-form-link').removeClass('active');
        $(this).addClass('active');
        e.preventDefault();
    });

// 아이디 생성 시 중복 검사
    $('#idCheck').click(function(){

        id = document.getElementById("member_id").value;

        if (id === "") {
            setMessage_Join("아이디를 입력해주세요.", jrm.member_id)
            jrm.member_id.focus();
        }
        else if (id.length < 4 || id.length > 12) {
            setMessage_Join("아이디 길이는 4 ~ 12 사이로 입력해주세요.", jrm.member_id)
            jrm.member_id.focus();
        }
        else if (id.replace(blank_pattern, '') === "") {
            setMessage_Join("아이디에 공백이 포함되었습니다.", jrm.member_id)
            jrm.member_id.focus();
        }
        else if (blank_pattern_S.test(id) === true) {
            setMessage_Join("아이디에 공백이 포함되었습니다.", jrm.member_id)
            jrm.member_id.focus();
        }
        else if (special_pattern.test(id) === true) {
            setMessage_Join("아이디에 특수문자가 포함되었습니다.", jrm.member_id)
            jrm.member_id.focus();
        }
        else if (id.search(/\W|\s/g) > -1) {
            setMessage_Join("아이디에 공백 또는 특수문자가 포함되었습니다.", jrm.member_id)
            jrm.member_id.focus();
        } else {
            $.ajax({
                type : 'get', // 요청 메서드
                url : '/register/checkId', // 요청 URI
                data : {member_id : id}, // 서버로 전송할 데이터
                success : function (result) {
                    if(result === 1) {
                        setMessage_Join("사용가능한 아이디입니다.", jrm.member_id);
                        document.getElementById("idCheck").value = "Check Completed";
                    } else {
                        setMessage_Join("이미 사용중인 아이디입니다.", jrm.member_id);
                    }

                },
            })
            // window.open을 이용한 idCheck version
            // let url = "/register/checkId?member_id=" + document.jrm.member_id.value;
            // let popupX = (window.screen.width / 2) - (450 / 2);
            // popupX += window.screenLeft;
            // let popupY = (window.screen.height / 2) - (400 / 2);
            // let option = "toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=450, height=400, left=" + popupX + ", top=" + popupY;
            // window.open(url, "_blank", option);
        }


    });

    // 아이디 입력칸 누르면 idCehck 다시 유도
    document.getElementById("member_id").onclick = function () {
        document.getElementById("idCheck").value = "Check ID";
    }

});

// Login 유효성 검사
function loginCheck() {

    if (document.frm.memberId.value.length === 0) {
        setMessage_Login('아이디를 입력해주세요.', frm.member_id)
        return false;
    }
    if (document.frm.memberPwd.value === "") {
        setMessage_Login('패스워드를 입력해주세요.', frm.memberPwd)
        return false;
    }

    return true;

}

function setMessage_Login(message, element){
    document.getElementById("message").innerHTML = `<i class="fa fa-exclamation-circle"> ${message}</i>`;
    if(element) {
        element.select();
    }
}


function joinCheck() {

    id = document.getElementById("member_id").value;
    jpwd = document.getElementById("member_jpwd").value;
    cpwd = document.getElementById("member_cpwd").value;
    name = document.getElementById("member_name").value;
    email = document.getElementById("member_email").value;

    if(document.getElementById("idCheck").value === "Check ID") {
        setMessage_Join("아이디 확인이 필요합니다.", jrm.member_id);
        jrm.member_id.focus();
    }
    else if (name === "") {
        setMessage_Join("이름을 입력해주세요.", jrm.member_name);
    }
    else if (name.length < 2 || name.length > 10) {
        setMessage_Join("이름은 2 ~ 10 사이로 입력해주세요.", jrm.member_name);
    }
    else if (email === "") {
        setMessage_Join("이메일을 입력해주세요.", jrm.member_email);
    }
    else if (email_pattern.test(email) === false) {
        setMessage_Join("이메일 형식이 아닙니다.", jrm.member_email);
    }
    else if (jpwd === "") {
        setMessage_Join("비밀번호를 입력해주세요.", jrm.member_jpwd);
    }
    else if (password_pattern.test(jpwd) === false) {
        setMessage_Join("비밀번호는 영문 대소문자와 숫자 4~12자리로 입력해주세요.", jrm.member_jpwd);
    }
    else if (cpwd === "") {
        setMessage_Join("비밀번호를 확인해주세요.", jrm.member_cpwd);
    }
    else if (jpwd !== cpwd) {
        setMessage_Join("비밀번호가 일치하지 않습니다.", jrm.member_cpwd);
    } else {
        $.ajax({
            type : 'post', // 요청 메서드
            url : '/register/save', // 요청 URI
            data : {member_id : id,
                    member_name : name,
                    member_pwd : jpwd,
                    member_email : email}, // 서버로 전송할 데이터
            success : function (result) {
                if(result === 1) {
                    alert("회원가입에 성공했습니다. 다시 로그인해주세요.");
                    location.reload();
                } else {
                    alert("회원가입에 실패했습니다. 다시 시도해주세요.");
                }

            },
        })
    }


}

function setMessage_Join(joinMessage, element){
    document.getElementById("message_join").innerHTML = `<i class="fa fa-exclamation-circle"> ${joinMessage}</i>`;
    if(element) {
        element.select();
    }
}


function editCheck() {

    id = document.getElementById("member_id").value;
    name = document.getElementById("member_name").value;
    jpwd = document.getElementById("member_pwd").value;
    cpwd = document.getElementById("member_cpwd").value;
    email = document.getElementById("member_email").value;


    if (email === "") {
        setMessage_edit("이메일을 입력해주세요.", prm.member_email);
    }
    else if (email_pattern.test(email) === false) {
        setMessage_edit("이메일 형식이 아닙니다.", prm.member_email);
    }
    else if (jpwd === "") {
        setMessage_edit("비밀번호를 입력해주세요.", prm.member_jpwd);
    }
    else if (password_pattern.test(jpwd) === false) {
        setMessage_edit("비밀번호는 영문 대소문자와 숫자 4~12자리로 입력해주세요.", prm.member_jpwd);
    }
    else if (cpwd === "") {
        setMessage_edit("비밀번호를 확인해주세요.", prm.member_cpwd);
    }
    else if (jpwd !== cpwd) {
        setMessage_edit("비밀번호가 일치하지 않습니다.", prm.member_cpwd);
    } else {
        $.ajax({
            type : 'post', // 요청 메서드
            url : '/login/edit', // 요청 URI
            data : {member_id : id,
                member_name : name,
                member_pwd : jpwd,
                member_email : email}, // 서버로 전송할 데이터
            success : function (result) {
                if(result === 1) {
                    alert("회원정보 수정 완료. 다시 로그인 해주세요.");
                    location.href="login";
                } else {
                    alert("회원정보 수정에 실패했습니다. 다시 시도해주세요.");
                }

            },
        })
    }




}

function setMessage_edit(editMessage, element){
    document.getElementById("message_edit").innerHTML = `<i class="fa fa-exclamation-circle"> ${editMessage}</i>`;
    if(element) {
        element.select();
    }
}

//----------------------------------------------------------------------------------------------------------------------------------


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
