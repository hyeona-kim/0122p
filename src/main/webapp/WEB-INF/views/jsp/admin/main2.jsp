<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.logo{
    width: 90%;
    margin: 15px auto;
}
.bottom{
    width: 100%;
    height: 100vh;
    background-color: #dedede;
    display: flex;
}
.bottom>article:first-child{
    display: inline-block;
    width: 20%;
    position: relative;
}
.bottom>article:last-child{
    display: inline-block;
    width: 80%;
    border: 1px solid red;
}
.bottom>article:first-child>div{
    height: 100vh;
    position: absolute;
    right: 0;
    width: 250px;
    background-color: #154790;
}
.bottom>article:first-child>div>article{
    display: flex;
    flex-direction: column;
    width: 100%;
}
.bottom>article:first-child>div>article>div{
    width: 100%;
    height: 45px;
}
.bottom>article:first-child>div>article>div>a{
    display: inline-block;
    width: 85%;
    height: 100%;
    line-height: 45px;
    color: white;
    font-size: 18px;
    font-weight: 600;
    text-decoration: none;
    margin-left: 40px;
}
.bottom>article:first-child>div>article>div>a:hover{
    border-bottom: 1px solid white;
}
</style>
</head>
<body>
    <article class="logo"><img alt="로고" src="${pageContext.request.contextPath }/image/ict_logo.png" /></article>
    <article class="bottom">
        <article class="main_menu">
            <div>
                <article>
                    <div>x</div>
                    <div>
                        <a href="">상담 및 접수</a>
                    </div>
                    <div>
                        <a href="">과정등록</a>
                    </div>
                    <div>
                        <a href="">학적부</a>
                    </div>
                    <div>
                        <a href="">상담관리</a>
                    </div>
                    <div>
                        <a href="">훈련일지</a>
                    </div>
                    <div>
                        <a href="">사전평가</a>
                    </div>
                    <div>
                        <a href="">자기/수행평가</a>
                    </div>
                    <div>
                        <a href="">평가관리</a>
                    </div>
                    <div>
                        <a href="">설문관리</a>
                    </div>
                    <div>
                        <a href="">증서관리</a>
                    </div>
                    <div>
                        <a href="">사후관리</a>
                    </div>
                    <div>
                        <a href="">통합관리</a>
                    </div>
                    <div>
                        <a href="">자료실</a>
                    </div>
                    <div>
                        <a href="">커뮤니티</a>
                    </div>
                    <div>
                        <a href="">로그현황</a>
                    </div>
                    <div>
                        <a href="">시스템문의</a>
                    </div>
                </article>
            </div>
        </article>
        <article class="main_area">
    
        </article>
    </article>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
    
    </script>
</body>
</html>