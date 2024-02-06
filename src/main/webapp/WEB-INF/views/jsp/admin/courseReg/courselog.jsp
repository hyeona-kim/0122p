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
                <header>&nbsp;&nbsp;과정등록</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                    <div id="staffWrap">
						<div id="courseList_top" class="title">교육과정리스트</div>
						<div id="ttop" class="main_item align_right" >
							<button type="button" onclick="set()" class="btn">과정등록</button>	
							<button type="button" onclick="set2()" class="btn">과정타입수정</button>	
							<button type="button" onclick="set3()" class="btn">강의실관리</button>	
						</div>
						<form>
							<table id="searchCourse" class="table">
							<caption>과정검색</caption>
								<thead>
									<tr>
										<th>검색</th>
										<td>
											<select id="numPerPage" class="select">
												<option value="5">표시개수</option>
												<option>5</option>
												<option>10</option>
												<option>15</option>
											</select>
											<select id="selectYear" class="select">
	
											</select>
										</td>
										<td>
											<select id="searchType" class="select">
												<option value="1">훈련강사</option>
												<option value="2">과정타입</option>
												<option value="3">과정명</option>
											</select>
											<input type="text" id="searchValue" class="text"/>
											<button type="button" id="search_bt" class="btn">검색</button>
										</td>
									</tr>
								</thead>
							</table>
						</form>
						<div id="courseLog_Table">
						
						</div>
					</div>
				</div>
            </div> 
        </article>
    </article>
    <form name="frm" action="course" method="post">
        <input type="hidden" name="type"  value=""/> 
        <input type="hidden" name="c_idx" value="" />
        <input type="hidden" name="cPage" value="" />
    </form>
    
    
    <div id="dialog" hidden="" title="교육과정등록">	
    </div>
    
    <div id="dialog2" hidden="" title="과정타입수정">
    </div>
    
    <div id="dialog3" hidden="" title="강의실관리">
    </div>
    
    <div id="dialog4" hidden="" title="교과목 관리/수정">
    </div>

    <div id="dialog5" hidden="" title="수정">
    </div>
    <div id="dialog6" hidden="" title="학습안내서 등록/수정">
    </div>
    <div id="dialog9" hidden title="교과목 수정">
        <form action="add_subject" method="post" name="sa_frm" enctype="multipart/form-data"  data-parsley-validate="true" >
            <input type="hidden" name="c_idx"/>
            <input type="hidden" name="cPage"/>
            <input type="hidden" name="value"/>
            <input type="hidden" name="year"/>
            <input type="hidden" name="select"/>
            <input type="hidden" name="num"/>
            <input type="hidden" name="listSelect" value="1"/>

            <input type="file" name="s_file"/>
            <hr/>
            <div align="right">
                <button type="button" id="sa_submit_btn">저장</button>
                <button type="button" id="cc_cancle2">취소</button>
            </div>
        </form>
    </div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        let select ="1";
		let select_year = "";
		let numPerPage = "";
		let value ="";
		let room_length =Number('${r_length}');
		let cPage =1;
		let html ="";
		let sb_num = 0;
		let sK_num =0;
		let upskillAdd ='${param.upskill}';
		let us_c_idx = '${param.c_idx}';
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
			$("#l_one").addClass("subSelect");
			if(upskillAdd == "upskill_add"){
				$.ajax({
					url: "upskill",
					type: "post",
					data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
						+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('1')+"&cPage="+encodeURIComponent(cPage)+"&c_idx="+us_c_idx,
				}).done(function(result){
					$(".right").html(result);
				});
			}else{
				console.log(value);
				$.ajax({
				url: "searchCourse",
				type: "post",
				data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
					+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('${param.listSelect}')+"&cPage="+cPage
				}).done(function(result){
					$("#courseLog_Table").html(result);
				});
			}
			
			let now = new Date();	// 현재 날짜 및 시간
			let year = now.getFullYear();
			let str = "<option>년도선택</option>";
			
			for(let i=year+1; i>year-5; i--){
				str+= "<option value="+i+">"+i+"</option>";
			}
			$("#selectYear").html(str);
			
			$("#searchType").on("change",function(){
				select = this.value;
			});
			$("#selectYear").on("change",function(){
				select_year = this.value;
				$.ajax({
					url: "searchCourse",
					type: "post",
					data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
						+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent("1")+"&cPage="+encodeURIComponent("1")
				}).done(function(result){
					$("#courseLog_Table").html(result);
				});
			});
			$("#numPerPage").on("change",function(){
				numPerPage = this.value;
				$.ajax({
					url: "searchCourse",
					type: "post",
					data:"&select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
						+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent("1")+"&cPage="+encodeURIComponent("1")
				}).done(function(result){
					$("#courseLog_Table").html(result);
				});
			});
			
			$("#search_bt").click(function(){
				value = $("#searchValue").val();
				console.log(value);
				console.log(cPage);
				$.ajax({
					url: "searchCourse",
					type: "post",
					data:"&select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
						+"&num="+encodeURIComponent(numPerPage)+"&listSelect=1&cPage="+cPage
				}).done(function(result){
					$("#courseLog_Table").html(result);
				});
			});	

			

		});

		function upskill(c_idx){
			$.ajax({
				url: "upskill",
				type: "post",
				data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
					+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('1')+"&cPage="+encodeURIComponent(cPage)+"&c_idx="+c_idx
			}).done(function(result){
				$(".right").html(result);
			});

		}
		function downSubject(){
			$.ajax({
				url: "downloadSubject",
				type: "post",
			}).done(function(result){
				console.log("완료");
			});
		}

		function set() {
			$.ajax({
				url:"c_dialog",
				type:"post",
				data:"&c_select="+encodeURIComponent("addCourse")+"&select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
					+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('1')+"&cPage="+cPage
			}).done(function(result){
			}).done(function(result){
				$("#dialog").html(result);
				
				$("#cc_cancle").click(function(){
					 $("#dialog").dialog("close");
				});
			});
            $("#dialog").dialog("open",{
            	width:500,
            	height:600
            });
        }
		function set2() {
			
			$.ajax({
				url:"c_dialog",
				type:"post",
				data:"&c_select="+encodeURIComponent("addCourseType")+"&listSelect=1&cPage="+cPage,
			}).done(function(result){
				$("#dialog2").html(result);
				$(".ccol").on("change input", function() {
		             $(this).prev().val("");
		             $(this).prev().val($(this).val());
		   		});
				
				$("#cancel").click(function(){
					 $("#dialog2").dialog( "close" );
				});
			});
			
            $("#dialog2").dialog("open");
        }
		function set3() {
            $("#dialog3").dialog("open");
            
            $.ajax({
				url:"c_dialog",
				type:"post",
				data:"c_select="+encodeURIComponent("addRoom")+"&listSelect=1&cPage="+cPage,
			}).done(function(result){
				$("#dialog3").html(result);
				
				$("#cl").click(function(){
					 room_length = 7;
					 $("#dialog3").dialog( "close" );
				});
				
				$(".ui-dialog-titlebar-close").click(function(){
					 room_length = 7;
					 $("#dialog3").dialog( "close" );
				});

			});
        }



		function set5(str,s_idx,c_idx) {
			$("#dialog5").dialog("open");
			$.ajax({
				url:"upskill",
				type:"post",
				data:"skill="+encodeURIComponent(str)+"&s_idx="+s_idx+"&c_idx="+c_idx
			}).done(function(result){
				sk_num = 0;
				$("#dialog5").html(result);
	
				$("#skill_cl").click(function(){
					 if(confirm("목록으로 돌아가시겠습니까? 변경내용은 저장되지 않습니다.")){
						 $("#dialog5").dialog("close");
					 }
				});

				$("#add_upskill").click(function(){
					//유효성 검사
					document.skill_frm.submit();
				});

			});

		}
		function addHtml(length){
			if(confirm("변경내용이 사라집니다. 추가 하시겠습니까?")){
				if(sk_num == 0 )
					sk_num = Number(length)	;
				sk_num +=1;
				let str = $("#addUpskill_tbody").html();
				let str2 = "<tr><td><strong>"+sk_num+"</strong><br/><button type='button' class='btn red'>삭제</button></td><td><input type='text' name='sk_name' class='text'>"+
					"<input type='hidden' name='sk_idx'/></td></tr>";
				if(str.includes('검색결과'))
					$("#addUpskill_tbody").html(str2);
				else
					$("#addUpskill_tbody").html(str+str2);
			}
		}

		function set4(c_idx) {
			let sb_num = 18;
            $("#dialog4").dialog("open");
            
            $.ajax({
				url:"c_dialog",
				type:"post",
				data:"c_select="+encodeURIComponent("updateSubject")+"&c_idx="+c_idx,
			}).done(function(result){
				
				$("#dialog4").html(result);
				
				$("#cl").click(function(){
					 room_length = 7;
					 $("#dialog4").dialog( "close" );
				});
				
				$(".ui-dialog-titlebar-close").click(function(){
					 room_length = 7;
					 $("#dialog4").dialog( "close" );
				});
				$("#cc_cancle").click(function(){
					$("#dialog4").dialog( "close" );
				});

				$("#add_subject_btn").click(function(){
					$("#dialog9").dialog("open");
					$("#cc_cancle2").click(function(){
						$("#dialog9").dialog("close");
					});
					$("#sa_submit_btn").click(function(){
						document.sa_frm.c_idx.value = c_idx;
						document.sa_frm.cPage.value =cPage; 
						document.sa_frm.value.value =value; 
						document.sa_frm.select.value =select; 
						document.sa_frm.num.value =numPerPage; 
						document.sa_frm.year.value =select_year; 
						
						document.sa_frm.submit();

					});
				});
				
				$("#sb_add_btn").click(function(){
					sb_num+=1;
					let str = $("#add_space").html();
					html = "<table class='subject_out table' style='margin: 0 auto;'><colgroup><col width='10%'/><col width='90%'/>"+
							"</colgroup><tr><th><p>과목"+sb_num+"</p> <select class ='select'>"+
							" <option>미삭제</option><option>삭제</option></select></th> <td>"+
							"<table id='innerTable' class='table' style='width: 95%; margin-top: 15px;'><colgroup> <col width='15%'/> <col width='15%'/>"+
							"<col width='20%'/><col width='20%'/> <col width='10%'/><col width='20%'/>"+
							"</colgroup><tr> <th>과목명</th><td><input type='text' class='text'/></td>"+
							"<th>분류/시수</th><td><select class='select'><option>NCS</option><option>비NCS</option>"+
							"</select><input type='text' class='text' style='width: 30%;'/></td><th>교수</th>"+
							"<td><input type='text' class='text'/></td></tr> <tr><th>능력단위명</th>"+
							"<td><input type='text' class='text'/></td><th>분류번호</th>"+
							"<td><input type='text' class='text'/></td><th>강의실</th>"+
							"<td><input type='text' class='text'/></td> </tr> </table></td> </tr></table>";
					$("#add_space").html(str+html);
				
					$("#add_space").attr("hidden",false);
					
				});
				$("#sb_db_btn").click(function(){
					document.sb_add_frm.submit();
				});
			});
        }

		function set6(c_idx) {
			$("#dialog6").dialog("open");
			$.ajax({
				url:"course_file",
				type:"post",
				data:"c_idx="+encodeURIComponent(c_idx)+"&listSelect=1&cPage="+cPage
			}).done(function(result){
				$("#dialog6").html(result);
				$("#cc_cancle").click(function(){
					$("#dialog6").dialog("close");
				});
			});
        }

		function editC(c_idx,nowPage){
			 $.ajax({
				url:"editCourse",
				type:"post",
				data:"&c_idx="+c_idx+"&cPage="+nowPage
			}).done(function(result){
				$("#dialog").html(result);
				
				$("#cancel3").click(function(){
					$("#dialog").dialog( "close" );
				});
			});
			$("#dialog").dialog("open");	
        }

		
		
		$( "#dialog" ).dialog({
            autoOpen: false,
            width:1000,
            modal: true,
        });

		$( "#dialog2" ).dialog({
            autoOpen: false,
            width: 750,
            modal: true,
           
        });

		$( "#dialog3" ).dialog({
            autoOpen: false,
            width: 700,
            modal: true,
            
        });
		
		$( "#dialog4" ).dialog({
            autoOpen: false,
            width: 1400,
            modal: true,
            height: 730,
        });

		$( "#dialog5" ).dialog({
            autoOpen: false,
            width: 600,
            modal: true,
            
        });

		$( "#dialog6").dialog({
            autoOpen: false,
            width: 700,
            modal: true,
            
        });

		$( "#dialog9" ).dialog({
            autoOpen: false,
            width: 900,
            modal: true,
           
        });

		function del(c_idx,str){
			if( confirm("삭제하시겠습니까?")){
			frm.action = "delCourse";
			document.frm.c_idx.value =c_idx; 
			document.frm.cPage.value =str; 
			document.frm.submit();
			}
		}
		
		function paging(str) {
			cPage=str;
			$.ajax({
				url: "searchCourse",
				type: "post",
				data:"&select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
					+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('${param.listSelect}')+"&cPage="+encodeURIComponent(str),
			}).done(function(result){
				$("#courseLog_Table").html(result);
				
			});
		}

		function addRoom() {
			room_length +=1;
			let str = $("#addRoom_tbody").html();
			let str2="<tr><td><strong>"+room_length+"</strong><br/><button type='button' class='btn red'>삭제</button> </td> "+
					"<td><input type='text' name='className' class='text'> </td> "+
					"<td> <select name='roomSep' class='select'>"+
					"<option value='1' selected>실습</option> <option value='2'>이론</option><option value='3'>겸용</option></select>"+
					"</td><td>  <select name='use' class='select'><option value='1' selected>사용</option><option value='0' >미사용</option></select></td> </tr>" ;
			
			$("#addRoom_tbody").html(str+str2);
		}
	
		
		function addCourse(frm) {
		    frm.action= "editCourse?edit=ok";
		    frm.submit();
		}

		function skill_delete(sk_idx,s_idx,c_idx){
			console.log(sk_idx+s_idx+c_idx);
			$.ajax({
				url:"del_skill",
				type:"post",
				data:"skill="+encodeURIComponent("skill")+"&s_idx="+s_idx+"&c_idx="+c_idx+"&sk_idx="+sk_idx,
			}).done(function(result){
				$("#dialog5").html(result);
				$("#skill_cl").click(function(){
					 $("#dialog5").dialog("close");
				});

			});
		}
    </script>
</body>
</html>