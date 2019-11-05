<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <!--当前页面更好支持移动端-->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>

    <%--引入bootstrap核心样式--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/boot/css/bootstrap.min.css">
    <%--引入jqgrid核心基础样式--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/jqgrid/css/ui.jqgrid.css">
    <%--引入jqgrid的bootstra皮肤--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/jqgrid/css/ui.jqgrid-bootstrap4.css">
    <%--引入jquery核心js--%>
    <script src="${pageContext.request.contextPath}/statics/boot/js/jquery-3.4.1.min.js"></script>
    <%--引入boot核心js--%>
    <script src="${pageContext.request.contextPath}/statics/boot/js/bootstrap.min.js"></script>
    <%--引入jqgrid核心js--%>
    <script src="${pageContext.request.contextPath}/statics/jqgrid/js/trirand/jquery.jqGrid.min.js"></script>
    <%--引入i18njs--%>
    <script src="${pageContext.request.contextPath}/statics/jqgrid/js/trirand/i18n/grid.locale-cn.js"></script>
    <script src="${pageContext.request.contextPath}/statics/jqgrid/js/ajaxfileupload.js"></script>
    <script charset="utf-8" src="${pageContext.request.contextPath}/kindeditor/kindeditor-all-min.js"></script>
    <script charset="utf-8" src="${pageContext.request.contextPath}/kindeditor/lang/zh-CN.js"></script>
    <script src="../echarts/echarts.min.js"></script>
    <style>
        .img-thumbnail{
            height: 400px
        }
        .panel-body {
            padding: 0px;
            padding-top: 0px;
            padding-right: 0px;
            padding-bottom: 0px;
            padding-left: 0px;
        }

        .navbar-inverse{
            background-color: #337ab7;
            border-color:#337ab7;
        }
        .navbar-inverse .navbar-brand {
            color: gainsboro;
        }
        .navbar-inverse .navbar-nav>li>a{
            color: gainsboro;
        }
        .navbar {
            border-radius: 0px;
        }
        .navbar-default {
            border-color: #f8f8f8;
        }

         .ui-jqgrid tr.jqgrow td {
             white-space: normal !important;
             height: auto;
             vertical-align:middle;
             padding-top:2px;

         }
        inner>.item>a>img, .carousel-inner>.item>img, .img-responsive, .thumbnail a>img, .thumbnail>img {
            display: block;
            max-width: 100%;
            height: 475px;
        }
        .h1, .h2, .h3, h1, h2, h3 {
            margin-top: 15px;
            margin-bottom: 10px;
        }
        .navbar-inverse {
            position: relative;
            min-height: 50px;
            margin-bottom: 10px;
            border: 1px solid transparent;
        }
        .btn-warning {
            width: 50%;
        }
        .page-header {
            padding-bottom: 0px;
            margin: 40px 0 20px;
            border-bottom: none;
        }
        .btn-default {
            width: 100%;
        }

    </style>

</head>
<body>
<c:if test="${sessionScope.admin == null}"><c:redirect url="../login/login.jsp"></c:redirect> </c:if>
     <nav class="navbar navbar-inverse">
         <div class="container-fluid">

             <div class="navbar-header">
                 <a class="navbar-brand" href="${pageContext.request.contextPath}/back/main.jsp">持明法洲后台管理系统 </a>
             </div>
             <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                 <ul class="nav navbar-nav navbar-right">
                     <li><a href="#">欢迎:<font color="#00ced1">${sessionScope.admin.username}</font></a></li>
                     <li><a href="${pageContext.request.contextPath}/admin/quite">安全退出<span class="glyphicon glyphicon-log-out"></span> </a></li>
                 </ul>
             </div>
         </div>
     </nav>
     <!--页面主体内容-->
     <div class="container-fluid">
         <!--row-->
         <div class="row">

             <!--菜单-->
             <div class="col-sm-2">

                 <!--手风琴控件-->
                 <div class="panel-group" id="accordion" >

                     <!--面板-->
                     <div class="panel panel-primary">
                         <div class="panel-heading" role="tab" id="picturePanel">
                             <h4 class="panel-title">
                                 <a role="button" data-toggle="collapse" data-parent="#accordion" href="#pictureLists" aria-expanded="true" aria-controls="collapseOne">
                                    <center>轮播图管理</center>
                                 </a>
                             </h4>
                         </div>
                         <div id="pictureLists" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                             <div class="panel-body">
                                 <ul class="list-group">
                                     <li class="list-group-item"><a role="button" class="btn btn-default " href="javascript:$('#centerLayout').load('${pageContext.request.contextPath}/back/picture.jsp');" id="btn"><center>所有轮播图</center></a></li>
                                 </ul>
                             </div>
                         </div>
                     </div>

                     <!--类别面板-->
                     <div class="panel panel-primary">
                         <div class="panel-heading" role="tab" id="categoryPanel">
                             <h4 class="panel-title">
                                 <a role="button" data-toggle="collapse" data-parent="#accordion" href="#categoryLists" aria-expanded="true" aria-controls="collapseOne">
                                     <center>专辑管理</center>
                                 </a>
                             </h4>
                         </div>
                         <div id="categoryLists" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                             <div class="panel-body">
                                 <ul class="list-group">
                                     <li class="list-group-item"><a role="button" class="btn btn-default " href="javascript:$('#centerLayout').load('${pageContext.request.contextPath}/back/album.jsp')"><center>专辑列表</center></a></li>
                                     <%--<li class="list-group-item"><a href="">歌曲添加</a></li>--%>
                                 </ul>
                             </div>
                         </div>
                     </div>

                     <!--面板-->
                     <div class="panel panel-primary">
                         <div class="panel-heading" role="tab" id="articlePanel">
                             <h4 class="panel-title">
                                 <a role="button" data-toggle="collapse" data-parent="#accordion" href="#articleLists" aria-expanded="true" aria-controls="collapseOne">
                                     <center>文章管理</center>
                                 </a>
                             </h4>
                         </div>
                         <div id="articleLists" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                             <div class="panel-body">
                                 <ul class="list-group">
                                     <li class="list-group-item"><a role="button" class="btn btn-default " href="javascript:$('#centerLayout').load('${pageContext.request.contextPath}/back/article.jsp')"><center>文章列表</center></a></li>
                                     <%--<li class="list-group-item"><a href="">图书添加</a></li>--%>
                                 </ul>
                             </div>
                         </div>
                     </div>


                     <!--面板-->
                     <div class="panel panel-primary">
                         <div class="panel-heading" role="tab" id="userPanel">
                             <h4 class="panel-title">
                                 <a role="button" data-toggle="collapse" data-parent="#accordion" href="#userLists" aria-expanded="true" aria-controls="collapseOne">
                                     <center>用户管理</center>
                                 </a>
                             </h4>
                         </div>
                         <div id="userLists" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                             <div class="panel-body">
                                 <ul class="list-group">
                                     <li class="list-group-item"><a role="button" class="btn btn-default " href="javascript:$('#centerLayout').load('${pageContext.request.contextPath}/back/user.jsp')"><center>用户列表</center></a></li>
                                     <li class="list-group-item"><a role="button" class="btn btn-default " href="javascript:$('#centerLayout').load('${pageContext.request.contextPath}/back/userCount.jsp')"><center>用户注册趋势</center></a></li>
                                 </ul>
                             </div>
                         </div>
                     </div>

                     <!--面板-->
                     <div class="panel panel-primary">
                         <div class="panel-heading" role="tab" id="starPanel">
                             <h4 class="panel-title">
                                 <a role="button" data-toggle="collapse" data-parent="#accordion" href="#starLists" aria-expanded="true" aria-controls="collapseOne">
                                     <center>明星管理</center>
                                 </a>
                             </h4>
                         </div>
                         <div id="starLists" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                             <div class="panel-body">
                                 <ul class="list-group">
                                     <li class="list-group-item"><a role="button" class="btn btn-default " href="javascript:$('#centerLayout').load('${pageContext.request.contextPath}/back/star.jsp')"><center>明星列表</center></a></li>
                                 </ul>
                             </div>
                         </div>
                     </div>
                 </div>
             </div>
             <div class="col-sm-10" id="centerLayout">
                 <div class="panel panel-primary">
                     <div class="panel-heading"><center><h1>欢迎来到持明法洲后台管理系统</h1></center></div>
                     <div class="panel-body">
                         <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                             <!-- Indicators -->
                             <ol class="carousel-indicators">
                                 <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                                 <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                                 <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                                 <li data-target="#carousel-example-generic" data-slide-to="3"></li>
                                 <li data-target="#carousel-example-generic" data-slide-to="4"></li>
                                 <li data-target="#carousel-example-generic" data-slide-to="5"></li>
                             </ol>

                             <!-- Wrapper for slides -->
                             <div class="carousel-inner" role="listbox">
                                 <div class="item active">
                                     <img src="${pageContext.request.contextPath}/statics/image/bg.jpeg" width="100%" class="img-thumbnail" >
                                    <%-- <div class="carousel-caption">
                                         ...
                                     </div>--%>
                                 </div>
                                 <div class="item">
                                     <img src="${pageContext.request.contextPath}/statics/image/2.jpg" width="100%" class="img-thumbnail" >
                                    <%-- <div class="carousel-caption">
                                         ...
                                     </div>--%>
                                 </div>
                                 <div class="item">
                                     <img src="${pageContext.request.contextPath}/statics/image/3.jpg" width="100%" class="img-thumbnail" >
                                     <%-- <div class="carousel-caption">
                                          ...
                                      </div>--%>
                                 </div>
                                 <div class="item">
                                     <img src="${pageContext.request.contextPath}/statics/image/4.jpg" width="100%" class="img-thumbnail" >
                                     <%-- <div class="carousel-caption">
                                          ...
                                      </div>--%>
                                 </div>
                                 <div class="item">
                                     <img src="${pageContext.request.contextPath}/statics/image/5.jpg" width="100%" class="img-thumbnail" >
                                     <%-- <div class="carousel-caption">
                                          ...
                                      </div>--%>
                                 </div>
                                 <div class="item">
                                     <img src="${pageContext.request.contextPath}/statics/image/6.jpg" width="100%" class="img-thumbnail" >
                                     <%-- <div class="carousel-caption">
                                          ...
                                      </div>--%>
                                 </div>
                             </div>

                             <!-- Controls -->
                             <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                                 <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                                 <span class="sr-only">Previous</span>
                             </a>
                             <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                                 <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                                 <span class="sr-only">Next</span>
                             </a>
                         </div>
                     </div>
                 </div>
             <!--巨幕-->
                <%-- <div class="jumbotron">
                     <div class="container">
                          <h3>欢迎来到持明法洲后台管理系统</h3>
                     </div>
                  </div>--%>
                 <%-- <div>
                      <img src="${pageContext.request.contextPath}/statics/image/bg.jpeg" width="100%" height="200px"  class="img-thumbnail">
                  </div>--%>

         </div>
         </div>
     </div>
     <nav class="navbar navbar-default navbar-fixed-bottom">
         <div class="row">
             <div class="col-md-4 col-md-offset-4">
             <p class="navbar-text" style="padding-left: 50px">持明法洲后台管理系统@百知教育2019.10.25</p>
             </div>
         </div>
     </nav>

</body>
</html>