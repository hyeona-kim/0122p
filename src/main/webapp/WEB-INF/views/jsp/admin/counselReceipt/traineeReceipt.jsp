<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/main2.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/right.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/paging.css"/>
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
                <header>&nbsp;&nbsp;상담 및 접수</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                    <!--  여기서 표시될 테이블들 가지고오기 -->
					<div id="staffWrap">
						<div id="courseList_top" class="title">
                            <strong>&nbsp;&nbsp;&nbsp;수강생 등록</strong>
                        </div>
						<div id="counselReceipt_Table">
                            <!--과정에 대한 정보 가져오기 -->
							<article class="main_item align_right">
								<button class="btn" id="exelDown_btn" >수강생데이터입력샘플EXCEL</button>
							</article>
							<article>
								<div id="exel_d">
									<form action="t_exelDown" method="post" enctype="multipart/form-data" name="frm">
										<table id="exel_t" class="table">
											<colgroup>
												<col width="30%"/>
												<col width="70%"/>
											</colgroup>
											<tr>
												<th>
													수강생일괄등록
												</th>
												<td >
													<input type="file" name="t_file" style="border: 1px solid #ababab;" class="text"/>
													<input type="button" class="btn" id="submit_btn" value="등록"/>
												</td>
											</tr>
										</table>
									</form>
									<div class="main_item" style="color: rgb(21, 71, 144); font-weight: bold;">[파일 등록 시 아래사항들을 다시한번 확인해주세요!]</div>
									<br/>
									<div class="main_item" style="color: rgb(21, 71, 144); font-size: 13px; font-weight: bold;">
										*필수입력사항:성함,연락처,훈련과정명(코드값),수강상태<br/>
										*훈련과정명(코드값)은 과정등록에 있는 과정코드값을 입력해야합니다, 과정명을 입력하면 저장되지 않습니다.<br/>
										*수강상태는 수강,수료,조기수료,미수료,제적 중에 하나를 택하여 정확히 입력해주세요.<br/>
										*카드유형을 취성패1,취성패2,국가취업지원제도1,국가취업지원제도2,내일배움카드(실업자),근로자카드,일반(근로복지공단),일반,일반(기타)중에 하나를 입력해주세요<br/>
										*전체교육비가 없을경우 0을 입력합니다.<br/>
										*주민번호,전화,우편번호,주소,상담메모,카드유형은 필수 입력값이 아니며 내용이 없으면 공란으로 작성해주세요.<br/>
										*이외에 입력할 내용은 등록 후 수정바라며, 파일 업로드시 참고사항내용은 삭제 후 업로드 바랍니다.<br/>
										*파일형식은 97-2003파일형식으로 저장하셔야 합니다.<br/>
									</div>
								</div>
							</article>
						</div>
					</div>
				</div>
				</div>

            </div> 
        </article>
    </article>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
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
        $(function(){
			$(".subSelect").removeClass("subSelect");
			$("#l_five").addClass("subSelect");
			//$().removeClass("selected");
			$(".selected").removeClass("selected");
			$(".l_select").removeClass("l_selected");
			$("#firstmenu").addClass("selected");
			$("#l_five").addClass("l_select");
			$("#submit_btn").click(function(){
				document.frm.submit();
			});
            $("#exelDown_btn").click(function(){
				
			});
		});
    </script>
</body>
</html>