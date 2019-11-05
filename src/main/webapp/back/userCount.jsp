<%--
  Created by IntelliJ IDEA.
  User: 林凯鹏
  Date: 2019/11/1
  Time: 15:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<html>
<head>

</head>
<body>
<div>
    <br>
</div>

<div id="main" style="width: 1000px;height:500px;"></div>
<script>
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));

    // 指定图表的配置项和数据
    var option = {
        title: {
            text: '用户注册趋势'
        },
        tooltip: {},
        legend: {
            data:['男','女']
        },
        xAxis: {
            data: ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]
        },
        yAxis: {},
       /* series: [{
            name: '男',
            type: 'line',//bar:柱状图
            data: [5, 20, 36, 10, 10, 20]
        },{
            name: '女',
            type: 'line',//bar:柱状图
            data: [15, 20, 32, 40, 20, 25]
        }]*/
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);

    $.ajax({
        url:"${pageContext.request.contextPath}/user/userCount",
        type:"get",
        datatype:"json",
        success:function (data) {
            myChart.setOption({
                series: [{
                    name: '男',
                    type: 'bar',//bar:柱状图
                    data: data.men
                },{
                    name: '女',
                    type: 'bar',//bar:柱状图
                    data: data.women
                }]
            });
        }
    })
</script>

</body>
</html>