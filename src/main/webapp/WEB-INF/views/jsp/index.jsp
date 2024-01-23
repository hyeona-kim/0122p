<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.text-center {
	text-align: center;
}

.direct {
	display: inline-block;
	width: 200px;
	height: 250px;
	margin: 20px;
	text-align: center;
}

.direct a{
	display: inline-block;
	position: relative;
	width: 100%;
	height: 100%;
	text-align: center;
	border-radius: 10px 10px;
}

.direct:first-child a{
	background:#3765a3;
}

.direct:last-child a{
	background:#60ba2a;
}

.direct:nth-child(2) a{
	background:#6abde5;
}

.direct:first-child a:hover{
	background:#324e97;
}

.direct:last-child a:hover{
	background:#4ea51a;
}

.direct:nth-child(2) a:hover{
	background:#39a8df;
}
.direct a img{
	position: absolute;
	display: block;
	width: 65%;
	height: 50%;
	left: 32px;
	top: 20px;
}

.direct a span{
	text-decoration: none;
	position: absolute;
	bottom: 65px;
	font-size: 25px;
	right: 32px;
	color: white;
	font-weight: bold;
}
.direct:last-child a span{
	right: 25px;
}
#logo{
	margin-top: 110px;
}
</style>
</head>
<body bgcolor="eeeeee">
	<div class="text-center loginscreen2">
		<div id="logo"><img alt="관리자 이미지" src="${pageContext.request.contextPath }/image/ict_logo.png" /></div>
		<div class="text-center" style="margin: 20px auto 0;">
			<div class="direct facebook">
				<a href="login?select=admin"> <img alt="관리자 이미지" src="${pageContext.request.contextPath }/image/admin.png" />
					
					<span>관리자 모드</span>
				</a>
			</div>
			<div class="direct twitter">
				<a href="login?select=train"> <img alt="수강생이미지" src="${pageContext.request.contextPath }/image/trainee.png" />
					<span>수강생 모드</span>
				</a>
			</div>
			<div class="direct green">
				<a href="login?select=teacher">
					<img alt="교.강사 이미지" src="${pageContext.request.contextPath }/image/teach.png"/>
					<span>교•강사 모드</span>
				</a>
			</div>
		</div>
		<div class="clear"></div>
		<p class="m-t">
			<small>Copyright &copy; 한국ict인재개발원. All rights reserved.</small>
		</p>
	</div>
</body>
</html>