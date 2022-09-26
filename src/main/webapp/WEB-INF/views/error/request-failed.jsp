<%@ page contentType="text/html;charset=utf-8" isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="/css/common/errorPage.css">
    <title>error.jsp</title>
</head>
<body>
<div class="page-404">
  <div class="outer">
    <div class="middle">
      <div class="inner">
        <!--BEGIN CONTENT-->
          <div class="container">
              <div class="row">
                  <div class="col-md-6 mx-auto mt-5">
                      <div class="payment">
                          <div class="payment_header">
                              <div class="check"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i></div>
                          </div>
                          <div class="content">
                              <h1>Opps ! ${errorTitle}</h1>
                              <p>${errorDescription}</p>
                              <a href="/">Go to Home</a>
                          </div>
                      </div>
                  </div>
              </div>
          </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>