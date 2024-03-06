<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/index.css"/>
</head>
<body>
	<article class="logo"><img alt="로고" src="${pageContext.request.contextPath }/image/ict_logo.png" /></article>
	<article class="wrap">
			<div class="right_main">
				<div id="text">
					<span class="admin select selected">관리자 로그인</span>
					<span class="teacher select">교강사 로그인</span>
				</div>
				<form action="login_ok" name="frm" method="post">
					<!-- 아이콘을 누르면 select테그의 value값이 변경된다-->
					<input type="hidden" name="select" value="admin">
					<div>
						<table class="login_area">
							<colgroup>
							<col width="10%"/>
							<col width="*"/>
							</colgroup>
							<tr>
								<th class="login_label"><img src="${pageContext.request.contextPath }/image/id.jpg" width="40px" height="40px"/></th>
								<td>
									<input type="text" name="ID" placeholder="ID" class="login_input"/>
								</td>
							</tr>
							<tr>
								<th class="login_label"><img src="${pageContext.request.contextPath }/image/pw.jpg" width="40px" height="40px"/></th>
								<td>
									<input type="password" name="PW" value="" placeholder="PW" class="login_input"/>
								</td>
							</tr>
							<tr>
								<td></td>
								<td>
									<input type="submit" value="LOG-IN" class="btn login_btn"/>
								</td>
							</tr>
						</table>
						<div id="login_fail" style=" font-size: 20px; color: #298ee6;"></div>
					</div>
				</form>
			</div>
	</article>
	<script src="https://code.jquery.com/jquery-3.7.1.slim.min.js" integrity="sha256-kmHvs0B+OpCW5GVHUNjv9rOmY0IvSIRcf7zGUDTDQM8=" crossorigin="anonymous"></script>
	<script>
		$(".select").click(function(){
			console.log("dd");
			$(".selected").removeClass("selected");
			$(this).addClass("selected");
		});
		$(".teacher").click(function(){
			console.log("teacher");
			document.frm.select.value="teacher";
		});
		$(".admin").click(function(){
			console.log("admin");
			document.frm.select.value="admin";
		});

		let value = '${login}';
		let block = '${block}';
		if(value == "fail"){
			//alert("아이디 또는 비밀번호를 잘못 입력했습니다.");
			document.getElementById("login_fail").innerHTML= "아이디 또는 비밀번호를 잘못 입력했습니다.(${cnt})";
		}

		if(block == 'true'){
			alert("아이디 또는 비밀번호를 5회 잘못 입력했습니다. 관리자에게 문의하세요.");
		}

	</script>
</body>
</html>