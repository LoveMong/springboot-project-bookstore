$(function (){



});




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



});






