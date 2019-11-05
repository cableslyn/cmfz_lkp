<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>

    <script charset="utf-8" src="kindeditor/kindeditor-all-min.js"></script>
    <script charset="utf-8" src="kindeditor/lang/zh-CN.js"></script>

    <script type="text/javascript" src="http://cdn-hangzhou.goeasy.io/goeasy.js"></script>


    <script>
        var goEasy = new GoEasy({
        //发布的appkey
            appkey: "BC-1ccdaa0f28804547bef4454f960e5bef"
        });
        goEasy.publish({
        //当前的channel名称
            channel: "lkp_channel",
        //发送（发布）的内容
            message: "心里的花，我多想带你回家!"
        });
    </script>
</head>
<body>




</body>
</html>