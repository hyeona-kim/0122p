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
<style>
	#comments{
		width: 600px;
		height: 100px;
	}

	#provide_type, #img1, #img2, #img3{
		text-align: left;
	}
</style>
<body>
	<article>
		<jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/top_head.jsp"></jsp:include>
	</article>
    <article class="bottom">
        <article>
            <jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/head.jsp"></jsp:include>
        </article>
        <article class="center">
            <div>
                <header>&nbsp;&nbsp;기타관리</header>
                <div> 
                    <ul>
                        <jsp:include page="../leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
					<div id="staffWrap">
						<div id="staffList_top" class="title">훈련교재현황</div>
						<table id="staffList" class="table">
							<col width="13%">
							<col width="67%">
							<col width="20%">
							<thead>
								<tr>
									<th>검색</th>
									<td>
										<select id="numPerPage" class="select">
											<option>표시개수</option>
											<option>5</option>
											<option>10</option>
											<option>15</option>
										</select>
										<select id="searchType" class="select">
											<option value="1">교재명</option>
										</select>
										<input type="text" id="searchValue" class="text"/>
										<button type="button" id="search_bt" class="btn">검색</button>
									</td>
									<td>
										<button type="button" onclick="addTrainingBook()" class="btn">훈련교재 등록</button>
									</td>
								</tr>
							</thead>
						</table>
						<div id="trainingBook_table">	
							<!--비동기로 받아올 부분-->
						</div>

					</div>

				</div> 
			</div>
        </article>
    </article>
    <div id="add_dialog" hidden="" title="훈련교재 등록">	
    </div>

    <div id="edit_dialog" hidden="" title="훈련교재 정보수정">
    </div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        /* let select ="";
		let numPerPage = "";
		let value ="";
		let cPage = 1; */
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
			$("#l_four").addClass("subSelect");

			// 비동기 통신으로 
			$.ajax({
				url: "trainingBookMain",
				type: "post",
				data:"listSelect="+encodeURIComponent("1"),
			}).done(function(result){
				$("#trainingBook_table").html(result);
			});

			$("#add_dialog").dialog({
				autoOpen: false,
				width:900,
				maxHeight : 900,
				modal: true,	
			});

			/* $("#numPerPage").on("change",function(){
				numPerPage = this.value;
				$.ajax({
					url: "searchweeklyMeeting",
					type: "post",
					data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)
						+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent("1")+"&cPage="+encodeURIComponent("1")
				}).done(function(result){
					$("#trainingBook_table").html(result);
				});



				$("#searchType").on("change",function(){
					select = this.value;
				});


				$("#search_bt").click(function(){
					value = $("#searchValue").val();
				
					$.ajax({
						url: "searchweeklyMeeting",
						type: "post",
						data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)
							+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent("1")+"&cPage="+encodeURIComponent("1")
					}).done(function(result){
						$("#trainingBook_table").html(result);
					});

				});

			}); */
			
		});

		function paging(cPage) {
			$.ajax({
				url: "trainingBookMain",
				type: "post",
				data: "&cPage="+encodeURIComponent(cPage),
			}).done(function(result){
				$("#trainingBook_table").html(result);
			});
		}

		function delBook(idx) {
			if(confirm("삭제하시겠습니까?")){
				location.href="delBook?tb_idx="+idx;
			}else{
				return false;
			}
		};

		// ============================================================
		
		function addTrainingBook() {
			$.ajax({
				url:"addTrainingBookAjax",
				type:"post",
			}).done(function(result){
				$("#add_dialog").html(result);
				$("#add_dialog").dialog("open");
			});
        }

		

		 function editWeeklyMeeting(wk_idx) {
			$.ajax({
				url: "weeklyMeetingEditForm",
				type: "post",
				data: "wk_idx="+wk_idx
			}).done(function(result){
				$("#edit_dialog").html(result);

				$("#edit_dialog").dialog({
					title : '주간회의록',
					modal : true,
					width : 900,
					maxHeight : 900
				});
			});
			
		};


		function editWk(frm) {
			
			frm.submit();
		};



		

		

    </script>
</body>
</html>