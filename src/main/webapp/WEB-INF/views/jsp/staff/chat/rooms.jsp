<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/main.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/main_staff.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/right.css"/>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/fullcalendar2.css"/>
</head>
<body>


    <div class="container">
        <div>
            <input type="hidden" value="${roomName.name}" id="roomName">
            <c:forEach var="room" items="${list}">
                <ul >
                    <li><a href="/chat/room?roomId=${room.roomId}">${room.name}</a></li>
                </ul>
            </c:forEach>
        </div>
    </div>
    <form action="/chat/room" method="post">
        <input type="text" name="name" class="form-control">
        <button class="btn">개설하기</button>
    </form>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>
    $(document).ready(function(){

        let roomName = document.getElementById("roomName").value;

        if(roomName != null && roomName.trim().length)
            alert(roomName + "방이 개설되었습니다.");
        
    });
</script>
</body>
</html>