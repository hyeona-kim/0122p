<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/main2.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/right.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/paging.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/summernote-lite.css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
</head>
<body>
    <article class="logo"><img alt="로고" src="${pageContext.request.contextPath }/image/ict_logo.png" /></article>
    <article class="bottom">
        <article>
            <jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/head.jsp"></jsp:include>
        </article>
        <article class="center">
            <div>
                <header>&nbsp;&nbsp;학적부</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                    <div id="staffWrap">
                        <div id="staffList_top" class="title">확인서류등록</div>
						<form action="uploadwrite" method="post" encType="multipart/form-data">
							<table id="makeTime" class="table">
							<caption>확인서류등록 리스트</caption>
							<colgroup>
								<col width="20%"/>
								<col width="80%"/>
							</colgroup>
								<tbody>
									<tr>
										<th>확인서류명</th>
										<td><input type="text" name="subject" size="45" data-str="서류명" class="text"/></td>
									</tr>
									<tr>
										<th>과정별 자동입력</th>
										<td>
											<table id="t2" class="table" style="margin: 0; margin: auto; width: 95%;">
												<colgroup>
													<col width="20%"/>
													<col width="30%"/>
													<col width="20%"/>
													<col width="30%"/>
												</colgroup>
												<tbody>
													<tr>
														<th>훈련생명</th>
														<td colspan="3"></td>
													</tr>
													<tr>	
														<th>과정명</th>
														<td></td>
														<th>훈련기간</th>
														<td></td>
													</tr>
												</tbody>
											</table>
										</td>
									</tr>
									<tr>
										<th>내용</th>
										<td><textarea id="content" name="content" cols="130" rows="25" class="textarea"></textarea></td>
									</tr>
									<tr>
										<th>첨부파일:</th>
										<td><input type="file" name="file" data-str="파일" class="text"/></td>
									</tr>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="2">
											<input type="button" value="저장" onclick="sendData()" class="btn"/>
											<input type="button" value="닫기" onclick="javascript:location.href='trainupload'" class="btn">
										</td>
									</tr>
								</tfoot>
							</table>
						</form>
                	</div>
				</div>
            </div> 
        </article>
    </article>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="js/lang/summernote-ko-KR.js"></script>
    <script>
        $(".sub_manu").mouseover(function(){
            $(this).css("display","block");
        });
        $(".menu1").mouseover(function(){
            $(this).next().css("display","block");
        });
        $(".menu1").mouseout(function(){
            $(this).next().css("display","none");
        });
        $(".sub_manu").mouseout(function(){
            $(this).css("display","none");
        });
        $(function() {
			//$().removeClass("selected");
			$(".subSelect").removeClass("subSelect")
			$("#l_three").addClass("subSelect");

			//textarea에 에디터 가져다 놓기
			$("#content").summernote({
					height:200,
					focus : true, /* 커서를 미리 가져다 놓는다 */
					lang : "ko-KR",
					callbacks:{
						onImageUpload:function(files, editor){
							// 이미지가 에디터에 추가 될 때마다 수행하는곳
							// 추가되어 들어온 이미지는 여러개일수 있기 때문에 files 으로 받아야함.(배열)
							// 배열로 받아야하기때문에 반복문을 돌림
							for(let i=0; i<files.length; i++)
								sendImage(files[i],editor);
							
						}
						
					}
				});
				$("#content").summernote("lineHeight", .7);
			});
	 	function sendData(){
        		let ar = document.forms[0].elements;
        	
        			let str = ar[0].dataset.str;
        			if(document.forms[0].elements[0].value==""){
        				alert(str+"를 입력하세요");
        				document.forms[0].elements[i].focus();
        				return;
        			}
        	
        		document.forms[0].submit();
        		
        	}
    </script>
</body>
</html>