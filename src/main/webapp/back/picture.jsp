<%--
  Created by IntelliJ IDEA.
  User: 林凯鹏
  Date: 2019/10/28
  Time: 10:38
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="app"></c:set>
<%@page contentType="text/html; UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!--页头-->
<div class="page-header" style="margin-top: -20px;">
    <h1>轮播图管理</h1>
</div>

<%--jqgrid--%>
<script>
    $(function(){
        //创建jqgrid
        $("#picTable").jqGrid({
            styleUI:"Bootstrap",//使用bootstrap样式
            autowidth:true,//自动适应父容器\
            height:"400px",
            url:"${app}/picture/findAll",//请求数据
            datatype:"json",//指定请求数据格式 json格式
            colNames:["编号","名称","图片","描述","状态","创建时间"],//用来指定显示表格列
            pager:"#pager",//指定分页工具栏
            rowNum:3,//每页展示2条
            rowList:[2,10,15,20,50],//下拉列表
            viewrecords:true,//显示总条数
            editurl:"${app}/picture/edit",//编辑时url(保存 删除 和 修改)
            colModel:[
                {id:"id",hidden:true},
                {name:"name",align:"center",editable:true},
                {name:'cover',align:"center",edittype:"file",editable:true,editoptions: {enctype: "multipart/form-data"},
                    formatter:function (value,option,rows) {
                        return "<img  style='width:100px;height:100px;' src='${pageContext.request.contextPath}/back/picture/"+rows.cover+"'/>";
                    }},
                {name:"description",align:"center",editable:true},
                {name:"status",align:"center",editable:true,edittype : "select", editoptions : {value:"正常:正常;冻结:冻结"}},
                {name:"createdate",align:"center"}
            ],//用来对当前列进行配置
        }).jqGrid("navGrid","#pager",{edit:true,add:true,del:true},{ closeAfterEdit:true,
            afterSubmit:function (response){
                console.log(response);
                $.ajaxFileUpload({
                    url: "${pageContext.request.contextPath}/picture/upload" ,
                    type:"post",
                    fileElementId:"cover",
                    success:function (reponse) {
                        $("picTable").trigger("reloadGrid");
                    }
                });
                return "110";
            }
        },{closeAfterAdd: true,
            afterSubmit:function (response){
                    console.log(response);
                    $.ajaxFileUpload({
                       url: "${pageContext.request.contextPath}/picture/upload" ,
                       type:"post",
                       fileElementId:"cover",
                       success:function (reponse) {
                           $("picTable").trigger("reloadGrid");
                       }
                    });
                    return "110";
            }
        });

    });

</script>


<!--创建表格-->
<table id="picTable"></table>

<!--分页-->
<div id="pager"></div>

