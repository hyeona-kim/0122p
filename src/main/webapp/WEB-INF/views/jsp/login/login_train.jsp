<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#login_admin{
		width: 300px;
		margin: 70px auto ; 
	}
	#table2 p{
		font-size: 12px;
		color: #343434;
	}
	#table2 tr:first-child img{
		width: 220px;
	}
	#table2 tr:nth-child(2){
		margin: 0;
	}
	#table2 h2 {
		font-size: 19px;
		text-align: left;
	}
	#table2 hr {
		border: 1px solid #ddd;
	}
	#table2 #notice{
		font-size: 12px;
		color: red;
	}
	#table2 #login_btn{
		width: 95%;
		height: 35px;
		background-color:  #49b6d6;
		border: 1px #49b6d6;
		border-radius: 4px 4px;
		color: white;
		margin: auto;
	}
	#table2 .login_id{
		width: 95%;
		height: 40px;
		border: 1px solid #ddd;
		border-radius: 4px 4px;
		font-size: 15px;
	}
	#table2 .login-form{
		margin-top: 20px;
	}
</style>
</head>
<body bgcolor="eeeeee">
	<div id="login_admin">
		
			<form method="post" action="Controller" >
				<input type="hidden" name="select" value="train">
				<input type="hidden" name="type" value="login_ok">
				<table id="table2">
					<tr>
						<td colspan="3" align="center">
							<img src="${pageContext.request.contextPath }/image/ict_logo.png" style="max-width: 100%" alt="왼쪽이미지">
						</td>
					</tr>
					<tr>
						<td valign="top">

							<div class="login-layout">
								<h2>수강생 로그인</h2>
								<hr/>
								<div class="login-form">
									<div class="login-input">
										<div>
											<input type="text" id="search" name="ID"
												placeholder="수강생 이름" class="form-control input-lg login_id"
												style="margin-bottom: 5px" /> 
												<input type="hidden" name="strCode" id="strPN">
										</div>
										<div>
											<input type="password" id="strLoginPwd" name="PW"
												placeholder="수강생 비밀번호" autocomplete="atosoft_02 strLoginPwd"
												class="form-control input-lg login_id" /> 
												<input type="hidden"
												name="strLoginPwd1" id="strLoginPwd1" value="">
										</div>
									</div>
									<div class="login-bottom" style="padding-bottom: 20px; color: red; text-align: left">
										<span id="notice">*이름을 입력하시고 본인의 휴대폰을 꼭 선택해주세요!</span>
										<div class="login-btn" style="margin-top: 10px">
											<input type="submit" value="로그인"
												class="btn btn-info block full-width" id="login_btn"
												style="cursor: pointer;" />
										</div>
									</div>
									<div class="login-bottom"></div>
								</div>
								</div>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<div class="clear"></div>
							<div class="copyright" align="center">
								<p class="m-t">Copyright &copy; 한국ict인재개발원 All Rights
									Reserved.</p>
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
</body>
</html>