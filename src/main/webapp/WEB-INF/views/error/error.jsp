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
        <div class="inner-circle"><i class="fa fa-home"></i><span>${status}</span></div>
        <span class="inner-status">Oops! You're lost</span>
        <span class="inner-detail">
                    We can not find the page you're looking for.
            <div>${message}</div>
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