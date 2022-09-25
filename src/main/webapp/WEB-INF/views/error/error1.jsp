<%@ page contentType="text/html;charset=utf-8" isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
  <link rel="stylesheet" href="/css/common/error.css">
  <title>error.jsp</title>
</head>
<body>
<div class="page-404">
  <div class="outer">
    <div class="middle">
      <div class="inner">
        <!--BEGIN CONTENT-->
        <div class="inner-circle"><i class="fa fa-home"></i><span>400</span></div>
        <span class="inner-status">잘못된 요청입니다.</span>
        <span class="inner-detail">
                            ${pageContext.exception.message}
                    <a href="/" class="btn btn-info mtl"><i class="fa fa-home"></i>&nbsp;
                        Return home
                    </a>
                </span>
      </div>
    </div>
  </div>
</div>
</body>
</html>