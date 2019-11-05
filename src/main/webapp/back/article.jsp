
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<head>

    <script>
        var editor = KindEditor.create('#editor_id',{
                width : '750px',
                //点击图片空间按钮时发送的请求
                fileManagerJson:"${pageContext.request.contextPath}/article/browse",
                //展示图片空间按钮
                allowFileManager:true,
                //上传图片所对应的方法
                uploadJson:"${pageContext.request.contextPath}/article/upload",
                //上传图片是图片的形参名称
                filePostName:"articleImg",
                afterBlur:function () {
                    this.sync();
                },
                afterCreate : function() {
                    this.sync();
                },
        });

    $(function () {
        $("#articleTable").jqGrid({
            styleUI:"Bootstrap",//使用bootstrap样式
            autowidth:true,//自动适应父容器\
            height:"400px",
            url:"${pageContext.request.contextPath}/article/findAll",//请求数据
            datatype:"json",//指定请求数据格式 json格式
            colNames:["编号","标题","作者","简介","内容","创建时间","操作"],//用来指定显示表格列
            pager:"#pager",//指定分页工具栏
            rowNum:4,//每页展示2条
            rowList:[2,10,15,20,50],//下拉列表
            viewrecords:true,//显示总条数
            editurl:"${pageContext.request.contextPath}/article/del",//编辑时url(保存 删除 和 修改)
            colModel:[
                {name:"id",align:"center"},
                {name:"title",align:"center",editable:true},
                {name:'author',align:"center"},
                {name:"brief",align:"center",editable:true},
                {name:"content",align:"center",hidden: true},
                {name:"createDate",align:"center"},
                {name:"delete",align:"center",formatter:function (value,option,rows) {
                        return "<a href='#' class='btn btn-warning '  onclick=\"openModal('update','"+rows.id+"')\" role='button'>修改</a>";
                    }}
            ],//用来对当前列进行配置
        }).jqGrid("navGrid","#pager",{edit:false,add:false,del:true,search:false},{ closeAfterEdit:true})



    });

        //展示模态框
        function openModal(oper,id) {
            if("add"==oper){
                $("#article-id").val("");
                $("#article-title").val("");
                $("#article-author").val("");
                $("#article-brief").val("");
                KindEditor.html("#editor_id","");
            }
            if("update"==oper){
                var article = $("#articleTable").jqGrid("getRowData",id);
                console.log(article);
                $("#article-id").val(article.id);
                $("#article-title").val(article.title);
                $("#article-author").val(article.author);
                $("#article-brief").val(article.brief);
                KindEditor.html("#editor_id",article.content);
            }
            $("#mm").modal("show");
        }
        function save() {
            var id = $("#article-id").val();
            var url;
            if(id==null||id==("")){
                url = "${pageContext.request.contextPath}/article/save";
            }else{
                url= "${pageContext.request.contextPath}/article/update";
            }
            $.ajax({
                type:"post",
                url:url,
                data: $("#articleform").serialize(),
                dataType:"JSON",
                success:function(result){
                    if (result.status == false){
                        alert(result.message);
                    }
                    $('#articleTable').jqGrid('setGridParam',{
                        datatype:'json',
                        postData:{} //发送数据  
                        //page:1  
                    }).trigger("reloadGrid");
                }
            });
        };

</script>

</head>
<body>
    <div>
        <!-- Nav tabs -->
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">所有文章</a></li>
            <li role="presentation"><a href="#" id="add" onclick="openModal('add','')">添加文章</a></li>
        </ul>

        <!-- Tab panes -->
        <div class="tab-content">
            <div role="tabpanel" class="tab-pane active" id="home">
                <table id="articleTable"></table>

                <div id="pager"></div>
            </div>
            <div role="tabpanel" class="tab-pane" id="profile">...</div>
        </div>

    </div>

<!--构建模态框-->
<div class="modal fade" id="mm" data-backdrop="static" data-keyboard="false" data-show="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <!--头-->
            <div class="modal-header">
                <button class="close" data-dismiss="modal"> <span>&times;</span></button>
                <div class="modal-title">保存用户信息</div>
            </div>

            <!--身体-->
            <div class="modal-body">

                <!--row-->
                <div class="row">
                    <div class="col-sm-10 col-sm-offset-1">
                        <form action="" class="form-horizontal" method="post" id="articleform">
                        <input type="hidden" name="id" id="article-id">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">文章标题:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="title" id="article-title">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">文章作者:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="author" id="article-author">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">文章简介:</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="brief" id="article-brief">
                                </div>
                            </div>

                            <textarea id="editor_id" name="content" style="width:700px;height:300px;">

                            </textarea>
                        </form>
                    </div>
                </div>

            </div>
            <!--脚-->
            <div class="modal-footer">
                <button class="btn btn-danger" data-dismiss="modal">关闭</button>
                <button type="submit" class="btn btn-primary" onclick="javascript:editor.sync();save()" data-dismiss="modal">提交</button>
            </div>

        </div>
    </div>
</div>


</body>

</html>
