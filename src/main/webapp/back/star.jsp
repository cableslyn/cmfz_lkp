<%--
  Created by IntelliJ IDEA.
  User: 林凯鹏
  Date: 2019/10/29
  Time: 10:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<div class="page-header" style="margin-top: -20px;">
    <h1>明星列表</h1>
</div>

<script>
    $(function(){
       $("#starTable").jqGrid({
           styleUI:"Bootstrap",//使用bootstrap样式
           autowidth:true,//自动适应父容器\
           height:"400px",
           url:"${pageContext.request.contextPath}/star/findAllStar",//请求数据
           datatype:"json",
           colNames:["编号","名称","艺名","图片","性别","生日"],
           pager:"#pager",//指定分页工具栏
           rowNum:3,//每页展示2条
           rowList:[2,10,15,20,50],//下拉列表
           viewrecords:true,//显示总条数
           editurl:"${pageContext.request.contextPath}/star/edit",
           colModel:[
               {name:"id",hidden:true},
               {name:"name",editable:true,align:"center"},
               {name:"nickname",editable: true,align: "center"},
               {name:"photo",editable:true,align:"center",edittype:"file",editable:true,editoptions: {enctype: "multipart/form-data"},
                   formatter:function (value,option,rows) {
                       return "<img  style='width:100px;height:100px;' src='${pageContext.request.contextPath}/back/star_img/"+rows.photo+"'/>";
                   }},
               {name:"sex",editable:true,align:"center"},
               {name:"bir",editable:true,align:"center"}
           ],
           subGrid : true,
           subGridRowExpanded : function(subgrid_id, id) {
               var subgrid_table_id, pager_id;
               subgrid_table_id = subgrid_id + "_t";
               pager_id = "p_" + subgrid_table_id;
               $("#" + subgrid_id).html(
                   "<table id='" + subgrid_table_id
                   + "' class='scroll'></table><div id='"
                   + pager_id + "' class='scroll'></div>");
               jQuery("#" + subgrid_table_id).jqGrid(
                   {
                       url : "${pageContext.request.contextPath}/user/findUserByStarId?starId=" + id,
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
                           {name:"creatDate",align : "center"}
                       ],
                       rowNum : 3,
                       pager : "#"+pager_id,
                       autowidth:true,
                       caption : "粉丝列表",
                       height : '100%'
                   }).jqGrid('navGrid',
                   "#" + pager_id, {
                       edit : false,
                       add : false,
                       del : false,
                       search:false
                   });
           },
       }).jqGrid("navGrid","#pager",{edit:true,add:true,del:true},{ closeAfterEdit:true,
           afterSubmit:function (response){
               console.log(response);
               $.ajaxFileUpload({
                   url: "${pageContext.request.contextPath}/star/upload" ,
                   type:"post",
                   fileElementId:"photo",
                   success:function (reponse) {
                       $("starTable").trigger("reloadGrid");
                   }
               });
               return "110";
           }
       },{closeAfterAdd: true,
           afterSubmit:function (response){
               console.log(response);
               $.ajaxFileUpload({
                   url: "${pageContext.request.contextPath}/star/upload" ,
                   type:"post",
                   fileElementId:"photo",
                   success:function (reponse) {
                       $("starTable").trigger("reloadGrid");
                   }
               });
               return "110";
           }
       });
    });
</script>

<!--创建表格-->
<table id="starTable"></table>

<!--分页-->
<div id="pager"></div>