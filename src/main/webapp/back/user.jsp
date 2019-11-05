<%--
  Created by IntelliJ IDEA.
  User: 林凯鹏
  Date: 2019/10/29
  Time: 16:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<script>
    $(function () {
        jQuery("#userTable").jqGrid(
            {
                url : "${pageContext.request.contextPath}/user/findUserByStarId?starId="+"",
                datatype : "json",
                styleUI:"Bootstrap",
                colNames : [ '编号','昵称', '照片','地址','签名','性别','创建日期' ],
                colModel : [
                    {name : "id",hidden: true},
                    {name : "nickname",align : "center"},
                    {name:"photo",editable:true,align:"center",edittype:"file",editable:true,editoptions: {enctype: "multipart/form-data"},
                        formatter:function (value,option,rows) {
                            return "<img  style='width:100px;height:100px;' src='${pageContext.request.contextPath}/back/user-img/"+rows.photo+"'/>";
                        }},
                    {
                        name:'province',align:"center",
                        formatter : function(value, options, rData){
                            return value + " - "+rData['city'];
                        }
                    },
                    {name : "sign",align : "center"},
                    {name:"sex",align : "center"},
                    {name:"createDate",align : "center"}
                ],
                rowNum : 3,
                pager : "#pager",
                autowidth:true,
                height : '400px'
            }).jqGrid('navGrid',
            "#pager", {
                edit : false,
                add : false,
                del : false,
                search:false
            });
    });

</script>
<div>
    <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">所有用户</a></li>
        <li role="presentation"><a href="${pageContext.request.contextPath}/user/userExport" id="add" >导出用户</a></li>
    </ul>

    <!-- Tab panes -->
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane active" id="home">
            <!--创建表格-->
            <table id="userTable"></table>

            <!--分页-->
            <div id="pager"></div>
        </div>
        <div role="tabpanel" class="tab-pane" id="profile">...</div>
    </div>

</div>

