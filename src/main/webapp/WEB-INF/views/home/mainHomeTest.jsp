<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    String[] cateArray = {"소설", "시/에세이", " 경제/경영", "자기계발 ", "인문", " 역사/문화", " 종교", " 정치/사회", " 예술/대중문화", " 과학", " 기술/공학", " 컴퓨터/IT"};
    pageContext.setAttribute("cateArray", cateArray);
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome! SJBook Store!</title>
    <link rel="stylesheet" href="/css/main/main.css">
    <link rel="stylesheet" type="text/css" href="/css/main/slick.css"/>
    <link rel="stylesheet" type="text/css" href="/css/main/slick-theme.css"/>
    <meta name="google-signin-scope" content="profile email">
    <meta name="google-signin-client_id" content="770076919086-eq6fgbjuq59078luff512ol07ifc52h8.apps.googleusercontent.com">
    <script
            src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous"></script>
    <script src="/js/main.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/slick.js"></script>
    <script src="https://apis.google.com/js/platform.js" async defer></script>

    <style>
        .starR1{
            background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat -52px 0;
            background-size: auto 100%;
            width: 15px;
            height: 30px;
            float:left;
            text-indent: -9999px;
            cursor: pointer;
        }
        .starR2{
            background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
            background-size: auto 100%;
            width: 15px;
            height: 30px;
            float:left;
            text-indent: -9999px;
            cursor: pointer;
        }
        .starR1.on{background-position:0 0;}
        .starR2.on{background-position:-15px 0;}
    </style>

</head>
<body>

<jsp:include page="../common/header.jsp"></jsp:include>




<div id="main_contents">

    <div id="main_section" class="mt-3" style="width: 60%; margin-left: 300px">

        <div id="main_container_">

            <section class="hero-section">
                <div id="slideWrap" class="carousel slide" data-ride="carousel">
                    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                        <ol class="carousel-indicators">
                            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                            <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
                            <li data-target="#carouselExampleIndicators" data-slide-to="4"></li>
                        </ol>
                        <div class="carousel-inner owl-drag">
                            <div class="carousel-item active">
                                <a href="/detail?num=189"><img class="w-100" src="http://image.kyobobook.co.kr/ink/images/prom/2020/banner/200123/bnN_01.jpg"></a>
                            </div>
                            <div class="carousel-item">
                                <a href="/detail?num=190"><img class="w-100" src="http://image.kyobobook.co.kr/ink/images/prom/2020/banner/200221/bnA_a03.jpg"></a>
                            </div>
                            <div class="carousel-item">
                                <a href="/detail?num=191"><img class="w-100" src="http://image.kyobobook.co.kr/ink/images/prom/2020/banner/200221/bnA_a06.jpg"></a>
                            </div>
                            <div class="carousel-item">
                                <a href="/detail?num=188"><img class="w-100" src="http://image.kyobobook.co.kr/ink/images/prom/2020/banner/200123/bnN_03.jpg"></a>
                            </div>
                            <div class="carousel-item">
                                <a href="/detail?num=192"><img class="w-100" src="http://image.kyobobook.co.kr/ink/images/prom/2020/banner/200221/bnA_a04.jpg"></a>
                            </div>
                        </div>
                        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                </div>
            </section>


            <section class="categories-section mt-5">
                <div class="container">
                    <div class="row mb-3">
                        <div class="col-lg-6 col-md-6">
                            <div class="section-title">
                                <h2>베스트 셀러</h2>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6">
                            <div class="right-btn">
                                <a href="#" class="primary-btn" style="color:#fff;">VIew all</a>
                            </div>
                        </div>
                    </div>

                    <div class="categories-slider owl-carousel" id="best_slide">
                        <c:forEach items="${bookListBest}" var="bestlist" varStatus="i">
                            <div class="cs-item" >
                                <a href="detail?num=${bestlist.bookNum}">
                                    <div class="cs-pic set-bg" ><img class="h-100" src="<c:out value="/image${bestlist.bookPictureUrl}" />"></div>
                                    <div class="cs-text">
                                        <h4>${bestlist.bookTitle }</h4>
                                        <span class="main2_1_box_con_cate " id="cate${i.getIndex() }">
                                                ${cateArray[(bestlist.bookCategory - 1 )] }
                                        </span>
                                        <c:if test="${bestlist.bookGrade!=0}">
                                            <div class="starRev mt-1" id="revStar${i.getIndex() }" style="width:62%; margin:0 auto;">
                                                <div>
                                                    <span class="starR1 d-inline-block" id="star0" value="0.5">별1_왼쪽</span>
                                                    <span class="starR2 d-inline-block" id="star1" value="1">별1_오른쪽</span>
                                                    <span class="starR1 d-inline-block" id="star2" value="1.5">별2_왼쪽</span>
                                                    <span class="starR2 d-inline-block" id="star3" value="2">별2_오른쪽</span>
                                                    <span class="starR1 d-inline-block" id="star4" value="2.5">별3_왼쪽</span>
                                                    <span class="starR2 d-inline-block" id="star5" value="3">별3_오른쪽</span>
                                                    <span class="starR1 d-inline-block" id="star6" value="3.5">별4_왼쪽</span>
                                                    <span class="starR2 d-inline-block" id="star7" value="4">별4_오른쪽</span>
                                                    <span class="starR1 d-inline-block" id="star8" value="4.5">별5_왼쪽</span>
                                                    <span class="starR2 d-inline-block" id="star9" value="5">별5_오른쪽</span>
                                                </div>
                                                <span class="d-inline-block">(${bestlist.bookGrade})</span>
                                                <input type="hidden" id="star_rank" value="${bestlist.bookGrade}">
                                            </div>

                                        </c:if>
                                        <c:if test="${bestlist.bookGrade==0}">
                                            <span>평점 없음</span>
                                        </c:if>
                                        <input type="hidden" id="catenum${i.getIndex() }" value="${bestlist.bookCategory }">
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </section>






            <section class="categories-section mt-5">
                <div class="container">
                    <div class="row mb-3">
                        <div class="col-lg-6 col-md-6">
                            <div class="section-title">
                                <h2>신간</h2>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6">
                            <div class="right-btn">
                                <a href="#" class="primary-btn" style="color:#fff;">VIew all</a>
                            </div>
                        </div>
                    </div>

                    <div class="categories-slider owl-carousel" id="best_slide">
                        <c:forEach items="${bookListNew}" var="list" varStatus="i">
                            <div class="new_box_list cs-item" >
                                <a href="detail?num=${list.bookNum}">
                                    <div class="cs-pic set-bg" ><img class="h-100" src="<c:out value="/image${list.bookPictureUrl}" />"></div>
                                    <div class="cs-text">
                                        <h4>${list.bookTitle}</h4>
                                        <span class="main2_1_box_con_cate"id="newcate${i.getIndex() }" >
                                                ${cateArray[(list.bookCategory - 1 )] }
                                        </span>
                                        <span class="main2_1_box_con_year mb-2">${list.bookPublishingDate}</span>
                                        <input type="hidden" id="newcatenum${i.getIndex() }" value="${list.bookCategory }">
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </section>




            <section class="categories-section mt-5 mb-5">
                <div class="container">
                    <div class="row mb-3">
                        <div class="col-lg-6 col-md-6">
                            <div class="section-title">
                                <h2>평점순</h2>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6">
                            <div class="right-btn">
                                <a href="#" class="primary-btn" style="color:#fff;">VIew all</a>
                            </div>
                        </div>
                    </div>

                    <div class="categories-slider owl-carousel" id="best_slide">
                        <c:forEach items="${bookListGrade}" var="ranklist" varStatus="i">
                            <div class="new_box_list cs-item" >
                                <a href="detail?num=${ranklist.bookNum}">
                                    <div class="cs-pic set-bg" ><img class="h-100" src="<c:out value="/image${ranklist.bookPictureUrl}" />"></div>
                                    <div class="cs-text">
                                        <h4>${ranklist.bookTitle }</h4>
                                        <span class="main2_1_box_con_cate" id="newcate${i.getIndex() }" >
                                                ${cateArray[(ranklist.bookCategory - 1 )] }
                                        </span>
                                        <c:if test="${ranklist.bookGrade!=0}">
                                            <div class="starRev mt-1" id="starRev${i.getIndex() }" style="width:62%; margin:0 auto;">
                                                <span class="starR1" id="star0" value="0.5">별1_왼쪽</span>
                                                <span class="starR2" id="star1" value="1">별1_오른쪽</span>
                                                <span class="starR1" id="star2" value="1.5">별2_왼쪽</span>
                                                <span class="starR2" id="star3" value="2">별2_오른쪽</span>
                                                <span class="starR1" id="star4" value="2.5">별3_왼쪽</span>
                                                <span class="starR2" id="star5" value="3">별3_오른쪽</span>
                                                <span class="starR1" id="star6" value="3.5">별4_왼쪽</span>
                                                <span class="starR2" id="star7" value="4">별4_오른쪽</span>
                                                <span class="starR1" id="star8" value="4.5">별5_왼쪽</span>
                                                <span class="starR2" id="star9" value="5">별5_오른쪽</span>

                                                <input type="hidden" id="star_rank" value="${ranklist.bookGrade}">
                                                <span>(${ranklist.bookGrade})</span>
                                            </div>
                                        </c:if>
                                        <c:if test="${ranklist.bookGrade==0}">
                                            <span>평점 없음</span>
                                        </c:if>

                                        <input type="hidden" id="rankcatenum${i.getIndex() }" value="${ranklist.bookCategory }">
                                    </div>
                                </a>
                            </div>
                        </c:forEach>

                    </div>
                </div>
            </section>



        </div>
    </div>

    <jsp:include page="../common/footer.jsp"></jsp:include>







</div>
<script>
    $(document).ready(function(){
        for(var i =0; i <10; i++){
            var idx = $("#revStar"+i).find("input").val() ;
            idx = ( idx - 0.5 )*2
            idx = Math.floor(idx);
            $('#revStar'+i).find('#star'+idx).addClass(' on').prevAll('span').addClass(' on');
        }
    });
</script>
<script>
    $(document).ready(function(){
        for(var i =0; i <10; i++){
            var idx = $("#starRev"+i).find("input").val() ;
            idx = ( idx - 0.5 )*2
            idx = Math.floor(idx);
            $('#starRev'+i).find('#star'+idx).addClass(' on').prevAll('span').addClass(' on');
        }
    });
</script>



<script>
    function cateSwitch(val) {
        var result = "";
        switch(val){
            case 1:
                result = "소설";
                break;
            case 2:
                result = "시/에세이";
                break;
            case 3:
                result = "경제/경영";
                break;
            case 4:
                result = "자기계발";
                break;
            case 5:
                result = "인문";
                break;
            case 6:
                result = "역사/문화";
                break;
            case 7:
                result = "종교";
                break;
            case 8:
                result = "정치/사회";
                break;
            case 9:
                result = "예술/대중문화";
                break;
            case 10:
                result = "과학";
                break;
            case 11:
                result = "기술/공학";
                break;
            case 12:
                result = "컴퓨터/IT";
                break;
        }
        return result;
    }
</script>
<script>
    function user_grade(val) {
        var result = "";
        switch(val){
            case 0:
                result = "실버";
                break;
            case 1:
                result = "골드";
                break;
            case 2:
                result = "다이아";
                break;
        }
        return result;
    }
</script>

<style type="text/css">
    .categories-slider.owl-carousel .owl-nav button {
        font-size: 24px;
        color: #ffffff;
        height: 35px;
        width: 35px;
        line-height: 36px;
        text-align: center;
        background: rgba(0, 0, 0, 0.3);
        border-radius: 50%;
        position: absolute;
        left: 30px;
        top: 210px;
    }
    .carousel-indicators .active {
        background-color: #009603;
    }
</style>
</body>
</html>