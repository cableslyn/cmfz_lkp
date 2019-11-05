<%--
  Created by IntelliJ IDEA.
  User: 林凯鹏
  Date: 2019/10/29
  Time: 17:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<div class="page-header" style="margin-top: -20px;">
    <h1>专辑列表</h1>
</div>

<script>
    $(function(){
        //创建jqgrid
        $("#albumTable").jqGrid({
            styleUI:"Bootstrap",//使用bootstrap样式
            autowidth:true,//自动适应父容器\
            height:"400px",
            url:"${pageContext.request.contextPath}/album/findAllAlbums",//请求数据
            datatype:"json",//指定请求数据格式 json格式
            colNames:["编号","标题","作者","封面","章节数","得分","简介","创建时间"],//用来指定显示表格列
            pager:"#pager",//指定分页工具栏
            rowNum:3,//每页展示2条
            rowList:[2,10,15,20,50],//下拉列表
            viewrecords:true,//显示总条数
            editurl:"${pageContext.request.contextPath}/album/edit",//编辑时url(保存 删除 和 修改)
            colModel:[
                {id:"id",hidden:true},
                {name:"title",align:"center",editable:true},
                {name: "author", align: "center", editable: true, edittype: "select",
                    editoptions: {
                        value: kechengSelecthz()
                    },
                },
                {name:'cover',align:"center",edittype:"file",editable:true,editoptions: {enctype: "multipart/form-data"},
                    formatter:function (value,option,rows) {
                        return "<img  style='width:100px;height:100px;' src='${pageContext.request.contextPath}/back/album_img/"+rows.cover+"'/>";
                    }},
                {name:"count",align:"center"},
                {name:"score",align:"center"},
                {name:"brief",align:"center",editable:true},
                {name:"createDate",align:"center",editable:true,edittype:"date"}
            ],//用来对当前列进行配置
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
                        url : "${pageContext.request.contextPath}/chapter/findAllByAlbums?albumId=" + id,
                        datatype : "json",
                        styleUI:"Bootstrap",
                        colNames : [ '编号','专辑名', '文件名','大小','时长','创建日期' ,"播放"],
                        editurl:"${pageContext.request.contextPath}/chapter/edit?albumId="+id,
                        colModel : [
                            {name : "id",hidden: true,editable:true},
                            {name : "title",align : "center",hidden:true},
                            {name:"name",editable:true,align:"center",edittype:"file",editable:true,editoptions: {enctype: "multipart/form-data"}},
                            {name:'size',align:"center"},
                            {name : "duration",align : "center"},
                            {name:"createDate",align : "center"},
                            {name:"operation",align:"center", width:300,formatter:function (value,option,rows) {
                                    return "<audio controls>\n" +
                                        "  <source src='${pageContext.request.contextPath}/back/mp3/"+rows.name+"' >\n" +
                                        "</audio>";
                                }}
                        ],
                        rowNum : 3,
                        pager : "#"+pager_id,
                        autowidth:true,
                        caption : "歌曲列表",
                        height : '100%'
                    }).jqGrid('navGrid',
                    "#" + pager_id, {
                        edit : false,
                        add : true,
                        del : true,
                        search:false
                    },{},{closeAfterAdd: true,
                        afterSubmit:function (response){
                            console.log(response);
                            var id = response.responseJSON.message;
                            $.ajaxFileUpload({
                                url: "${pageContext.request.contextPath}/chapter/upload?albumId="+id ,
                                type:"post",
                                fileElementId:"name",
                                data:{id:id},
                                success:function (reponse) {
                                    $("subgrid_table_id").trigger("reloadGrid");
                                }
                            });
                            return "110";
                        }}
                    );
            }
        }).jqGrid("navGrid","#pager",{edit:true,add:true,del:true},{ closeAfterEdit:true,
            afterSubmit:function (response){
                console.log(response);
                $.ajaxFileUpload({
                    url: "${pageContext.request.contextPath}/album/upload" ,
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
                    url: "${pageContext.request.contextPath}/album/upload" ,
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
    var datajaon1;
    var str1 = "";
    function kechengSelectDatahz() {
        $.ajax({
            url : "${pageContext.request.contextPath}/star/findAll",
            type : "post",
            async : false,
            success : function(data) {
                if (data != null) {
                    datajaon1 = data
                }
            },
            error: function () {
                alert('请求失败');
            }
        });
    }
    function kechengSelecthz() {
        kechengSelectDatahz();
        var jsonobj = eval(datajaon1.rows);
        var length = jsonobj.length;
        for (var i = 0; i < length; i++) {
            if (i != length - 1) {
                str1 += jsonobj[i].name + ":" + jsonobj[i].name + ";";
            } else {
                str1 += jsonobj[i].name + ":" + jsonobj[i].name;
            }
        }
        return str1;
    }
</script>

<table id="albumTable"></table>

<div id="pager"></div>