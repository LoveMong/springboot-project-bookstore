$(function (){

    $("#image").change(function(){
        if(this.files && this.files[0]) {
            var reader = new FileReader;
            reader.onload = function(data) {
                $("#img-preview").attr("src", data.target.result).width(400);
            }
            reader.readAsDataURL(this.files[0]);
        }
    });

    $("#delete").click(function(){
        $('#image').val('');
        $("#img-preview").attr("src", '');
    });

    $(document).ready(function(){

        let idx = false;

        let imgFile;
        let fileSize;
        let fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/;
        let maxSize = 5 * 1024 * 1024;

        $("#image").change(function(){
            fileSize = document.getElementById("image").files[0].size;
            imgFile = document.getElementById("image").files[0].name;
        });



        $('#signUp').click(function(){
            if($.trim($('#bookTitle').val()) === ''){
                alert("제목을 입력해주세요.");
                $('#bookTitle').focus();
                return false;
            }else if($.trim($('#bookAuthor').val()) === ''){
                alert("작가를 입력해주세요.");
                $('#authorName').focus();
                return false;
            }else if($.trim($('#bookPublisher').val()) === ''){
                alert("출판사를 입력해주세요.");
                $('#publisher').focus();
                return false;
            }else if($.trim($('#bookPrice').val()) === ''){
                alert("도서가격을 입력해주세요.");
                $('#bookPrice').focus();
                return false;
            }else if($.trim($('#bookPublishingDate').val()) === '') {
                alert("출판일을 입력해주세요.");
                $('#publeYear').focus();
                return false;
            }else if($.trim($('#bookStock').val()) === ''){
                alert("재고를 입력해주세요.");
                $('#bookStock').focus();
                return false;
            }else if($.trim($('#bookContent').val()) === ''){
                alert("도서내용을 입력해주세요.");
                $('#contents').focus();
                return false;
            } else if ($('#image').val() === "") {
                alert("도서 표지를 등록해주세요.")
                $('#image').focus();
                return false;
            } else if (!imgFile.match(fileForm)) {
                alert("이미지 파일만 업로드 가능합니다.");
                return false;
            } else if (fileSize === maxSize) {
                alert("파일 사이즈는 5MB까지 가능합니다.")
                return false;
            } else {
                $('#book_reg').submit();
            }
        });
    });


    $(document).ready(function(){

        let token = $("meta[name='_csrf']").attr("content");
        let header = $("meta[name='_csrf_header']").attr("content");

        $("#search").click(function () {
            $.ajax({
                method: "GET",
                url: "https://dapi.kakao.com/v3/search/book?target=title",
                data: { query: $("#bookName").val() },
                headers : {Authorization: "KakaoAK 7277ba284ecfcf5b6513ac9ba4c9348f"}
            })
                .done(function (res) {
                    $('#coverimg').attr('src',res.documents[0].thumbnail);
                    $('#bookTitle').attr('value',res.documents[0].title);
                    $('input[name=bookPublisher]').attr('value',res.documents[0].publisher);
                    $('input[name=bookAuthor]').attr('value',res.documents[0].authors);
                    $('input[name=bookPublishingDate]').attr('value',res.documents[0].datetime.substr(0,10));
                    $('#bookContent').val(res.documents[0].contents);
                    $('input[name=bookPrice]').attr('value',res.documents[0].price);
                    $('#imageUrl').attr('src',res.documents[0].thumbnail);
                    $('#bookSearchPictureUrl').attr('value',res.documents[0].thumbnail);
                });
        });
    });
});


