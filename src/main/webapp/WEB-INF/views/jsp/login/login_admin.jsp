<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#login_admin{
		width: 600px;
		margin: 70px auto ; 
	}
	#table2{
	 	border:0; 
	 	text-align: center; 
	 	
	}
	#table2 tr:first-child img{
		width: 220px;
	}
	#table2 tr:nth-child(2){
		margin: 0;
	}
	#table2 h2 {
		font-size: 18px;
		text-align: left;
	}
	#table2 .login_id {
		width: 90%;
		height: 35px;
		border: 1px solid #ddd;
		border-radius: 4px 4px;
		font-size: 15px;
	}
	
	#table2 #login_btn{
		width: 90%;
		height: 35px;
	}
	#table2 p{
		font-size: 12px;
		color: #343434;
	}
	#table2 #login_btn{
		background-color:  #49b6d6;
		border: 1px #49b6d6;
		border-radius: 4px 4px;
		color: white;
	}
	
</style>
</head>
<body bgcolor="eeeeee">
	<div id="login_admin">
		<table id="table2">
			<tr>
				<td colspan="3" align="center">
					<a href="Controller"><img src="${pageContext.request.contextPath }/image/ict_logo.png" alt="상단이미지"></a>
				</td>
			</tr>
			<tr>
				<td valign="top">
					<div style="padding-top: 20px">
						<img src="${pageContext.request.contextPath }/image/admin_left.png" style="max-width: 100%" alt="왼쪽이미지">
					</div>
				</td>
				<td width="20px"></td>
				<td valign="top">
					<form name="theForm" method="post" action="login_ok">
						<input type="hidden" name="select" value="admin">
						<div class="login-layout">
							<h2>관리자 로그인</h2>
							<hr/>
							<div class="login-form">
								<div class="login-input">
									<div>
										<input type="text" id="strLoginID" name="ID" value=""
											placeholder="관리자 아이디" class="form-control input-lg login_id"
											style="margin-bottom: 5px" />
									</div>
									<div>
										<input type="password" id="strLoginPwd" name="PW" value="" placeholder="관리자 비밀번호" autocomplete="atosoft_02 strLoginPwd" class="form-control input-lg login_id" />
										 <input type="hidden" name="strLoginPwd1" id="strLoginPwd1" value="">
									</div>
								</div>
								<div class="login-btn" style="margin-top: 10px">
									<input type="submit" value="로그인" class="btn btn-info block full-width" style="cursor: pointer;" id="login_btn"/>
								</div>
							</div>
							<div class="login-bottom"></div>
						</div>
					</form>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<div class="clear"></div>
					<div class="copyright" align="center">
						<p class="m-t">Copyright &copy; 한국ict인재개발원 All Rights Reserved.</p>
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>