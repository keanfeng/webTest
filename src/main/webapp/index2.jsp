<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="resource/css/timeline.css">
    <title>jQuery时间轴</title>
</head>
<body>
<div class="page">
    <div class="search"><input type="text" id="date">  <input type="button" value="查询"></div>
    <div class="box">
        <ul class="event_year" ></ul>
        <ul class="event_list"  style="max-height:600px;overflow:auto;"></ul>
    </div>
</div>
    <script src="resource/js/jquery-3.2.1.min.js" type="text/javascript"></script>
    <script>
        var dateSet = new Set();

        function addLabelClick(){
            $('label').click(function () {
                $('.event_year>li').removeClass('current');
                $(this).parent('li').addClass('current');
                var year = $(this).attr('for');
                $('#' + year).parent().prevAll('div').slideUp(800);
                $('#' + year).parent().slideDown(800).nextAll('div').slideDown(800);
            });
        }

        function refleshLabel(){
            $(".event_year").empty();
            var index = 1;
            dateSet.forEach(function(element) {
                if (index == 1) {
                    $(".event_year").append("<li  class=\"current\" ><label  for=\"" + element + "\">" + element + "</label></li>");
                } else {
                    $(".event_year").append("<li><label for=\"" + element + "\">" + element + "</label></li>");
                }
                index++;
            });
        }

        function addEvent(){
            var events = getEvent();
            var tempDate = '';

            for(var obj in events){

                if(dateSet.size>0){
                    var notExist = true;
                    dateSet.forEach(function (element) {
                        if(element == events[obj].date) {
                            notExist = false;
                        }
                    });
                    if(notExist){
                        tempDate = events[obj].date;
                        dateSet.add(events[obj].date);
                        $('.event_list').append("<div><h3 id=\""+events[obj].date+"\">"+events[obj].date+"</h3></div>");
                    }
                    $('#'+events[obj].date).parent().append("<li><span>"+events[obj].time+"</span>\n" +
                        "<p><span class=\"alarmed\" >"+events[obj].content+"</span></p></li>");

                }else{
                    tempDate = events[obj].date;
                    dateSet.add(events[obj].date);
                    $('.event_list').append("<div><h3 id=\""+events[obj].date+"\">"+events[obj].date+"</h3></div>");
                    $('#'+events[obj].date).parent().append("<li><span>"+events[obj].time+"</span>\n" +
                        "<p ><span class=\"alarming\" ><b>告警内容：</b>"+events[obj].content+" <br/><b>告警级别：</b> 3 <br/><b>发生时间：</b> 2018－01-13 15:23 </span></p></li>");
                }

            }

            refleshLabel();

            addLabelClick();

        }
        function getEvent(){
            var jsonStr = "[{'id':'1','content':'冷水机组告警1','alertClass':4,'date':'2018-01-01','time':'12:12:12'}," +
                "{'id':'2','content':'冷水机组告警2','alertClass':4,'date':'2018-01-01','time':'12:12:13'}," +
                "{'id':'3','content':'冷水机组告警3','alertClass':4,'date':'2018-01-01','time':'12:12:14'}," +
                "{'id':'4','content':'冷水机组告警4','alertClass':4,'date':'2018-01-02','time':'12:12:15'}," +
                "{'id':'5','content':'冷水机组告警5','alertClass':4,'date':'2018-01-02','time':'12:12:16'}]";
            var jsonObj = eval('(' + jsonStr + ')');
            return jsonObj;
        }

        $(function () {
            addLabelClick();
        });

    </script>
    <div style="text-align:center;clear:both;cursor:pointer;">
        <p onclick="addEvent()">点击显示更多数据……</p>
    </div>
</body>
</html>