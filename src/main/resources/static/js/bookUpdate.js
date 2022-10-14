$(function (){


    $("#image").change(function(){
        if(this.files && this.files[0]) {
            var reader = new FileReader;
            reader.onload = function(data) {
                $("#image_preview").attr("src", data.target.result).width(200);
            }
            reader.readAsDataURL(this.files[0]);
        }
    });


    $("#delete").click(function(){
        $('#image').val('');
        $("#image_preview").attr("src", '');
    });





});


