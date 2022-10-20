$(function (){








});

$(document).ready(function(){
    for(var i =0; i <10; i++){
        var idx = $("#starRev"+i).find("input").val() ;
        idx = ( idx - 0.5 )*2
        idx = Math.floor(idx);
        $('#starRev'+i).find('#star'+idx).addClass(' on').prevAll('span').addClass(' on');
    }
});


$(document).ready(function(){
    var idx = $("#revStar").find("input").val() ;
    idx = ( idx - 0.5 )*2
    idx = Math.floor(idx);
    $('#revStar').find('#star'+idx).addClass(' on').prevAll('span').addClass(' on');
});

function comma(num){
    var len, point, str;

    num = num + "";
    point = num.length % 3 ;
    len = num.length;

    str = num.substring(0, point);

    while (point < len) {
        if (str != "") str += ",";
        str += num.substring(point, point + 3);
        point += 3;
    }

    return str;

}


$(function(){
    $("#reply_btn").click(function(e){
        const userid=$('#userid').val();
        const bknum=$('#bknum').val();
        const revcomment=$('#revdate').val();
        const revRank=$('#revRank').val();

        console.log("userid : "+userid);
        console.log("bknum : "+bknum);
        console.log("revcomment : "+revcomment);
        console.log("revRank : "+revRank);
        if(userid!=null&&userid!=""&&userid!=0){
            if(revcomment!=null&&revcomment!=""){
                $.ajax({
                    type:"POST",
                    url:"/comment",
                    data: {
                        rev_rank : revRank,
                        user_id : userid,
                        bk_num : bknum,
                        rev_comment : revcomment
                    },
                    dataType: "text",
                    success:function(result){
                        const resultSet = $.trim(result);

                        if(resultSet==="notorder"){
                            alert('구매 후 리뷰 작성이 가능합니다.')
                            location.reload();
                        }
                        else if(resultSet==="order"){
                            console.log('성공');
                            location.reload();
                        }

                    }
                });
            }
            else{
                alert('댓글을 입력해주세요');
            }
        }
        else{
            alert('로그인 해주세요')
        }
    });

    $('.starRev a').click(function(){
        $(this).parent().children("a").removeClass("on");
        $(this).addClass("on").prevAll("a").addClass("on");
        value=$(this).attr("value");
        $('#revRank').val(value);
        console.log($(this).attr("value"));
    });

});






