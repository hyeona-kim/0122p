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
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css"/>
<style>
    #search_area{
        position: relative;
    }
    #icon{
        position: absolute;
        right: 0px;
        width: 35px;
        height: 35px;
        top:-5px;
    }
    #icon>img{
        display: inline-block;
        width: 100%;
        height: 100%;
    }
    

    .chk{
        display: inline-block;
        width: 100px;
        height: 30px;
        text-align: left;
    }
</style>
</head>
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
						<div id="search_top">
                            <!--검색을 위한 영역-->
                            <h2 class="title">교육생 통합 검색</h2>
                            <article class="main_item" id="search_area">
                                표시개수:
                                <select class="select" style="width: 60px;" id="num_select" >
                                    <option>5</option>
                                    <option>10</option>
                                    <option>15</option>
                                </select>
                                검색:
                                <select class="select" style="width: 80px;" id="selectYear">
                                 
                                </select>
                                <select class="select" style="width: 120px;" id="ct_select">
                                    <option value="0">타입검색</option>
                                    <c:forEach var="ctvo" items="${ct_ar}">
                                        <option value="${ctvo.ct_idx}">${ctvo.ct_name}</option>
                                    </c:forEach>
                                </select>
                                <select class="select" style="width: 500px;" id="c_select">
                                    <option value="0">과정검색</option>
                                    <c:forEach var="cvo" items="${c_ar}">
                                        <option value="${cvo.c_idx}">${cvo.c_name}</option>
                                    </c:forEach>
                                </select>
                                <select class="select" style="width: 80px;" id="searchType">
                                    <option value="0">이름</option>
                                    <option value="1">핸드폰</option>
                                    <option value="2">전화</option>
                                    <option value="3">메모</option>
                                </select>
                                <input type="text" style="width: 120px;" id="searchValue" class="text"/>
                                <input type="button" class="btn" value="검색" id="search_btn" class="btn"/>
                                <a href="" id="icon"><img src="${pageContext.request.contextPath }/image/doc_icon.png" alt="문서이미지"/></a>
                            </article>
                        </div>
						<div id="select_top">
                            <form name="frm">
                                <table id="select_table" class="table">
                                <colgroup>
                                    <col width="20%"/>
                                    <col width="*"/>
                                    <col width="10%"/>
                                </colgroup>
                                    <tr>
                                        <th>검색</th>
                                        <td id="check_area">
                                            <!-- tr_name, tr_rrn, tr_phone, tr_hp, c_idx, tr_pos_code, tr_addr, status, memo, c_idx, ct_code, tr_total_fee, s_code, c_img, ss_end, 
                                            ss_num, tr_nowstatus, tr_cancel_date, tr_cancel_text, t_path, file_name, ori_name, tr_hrd, tr_refund, tr_bc, tr_card, tr_charge-->
                                            <span class="chk"><input type="checkbox" name="chk1" value="0" checked/>이름</span>
                                            <span class="chk"><input type="checkbox" name="chk1" value="1" checked/>주민번호</span>
                                            <span class="chk"><input type="checkbox" name="chk1" value="2" checked/>핸드폰</span>
                                            <span class="chk"><input type="checkbox" name="chk1" value="3"/>전화</span>
                                            <span class="chk"><input type="checkbox" name="chk1" value="4" checked/>과정</span>
                                            <span class="chk"><input type="checkbox" name="chk1" value="5" checked/>결재일</span>
                                            <span class="chk"><input type="checkbox" name="chk1" value="6"/>지원경로</span>
                                            <span class="chk"><input type="checkbox" name="chk1" value="7" checked/>개강일</span>
                                            <br/>
                                            <span class="chk"><input type="checkbox" name="chk1" value="8" checked/>HRD등록일</span>
                                            <span class="chk"><input type="checkbox" name="chk1" value="9" checked/>현재상태</span>
                                            <span class="chk"><input type="checkbox" name="chk1" value="10"/>제적일</span>
                                            <span class="chk"><input type="checkbox" name="chk1" value="11" checked/>제적사유</span>
                                            <span class="chk"><input type="checkbox" name="chk1" value="12" checked/>수료일</span>
                                            <span class="chk"><input type="checkbox" name="chk1" value="13"/>전체교육비</span>
                                            <span class="chk"><input type="checkbox" name="chk1" value="14" checked/>카드유형</span>
                                            <span class="chk"><input type="checkbox" name="chk1" value="15"/>우편번호</span>
                                            <br/>
                                            <span class="chk"><input type="checkbox" name="chk1" value="16"/>주소</span>
                                            <span class="chk"><input type="checkbox" name="chk1" value="17"/>메모</span>
                                            <span class="chk"><input type="checkbox" name="chk1" value="18"/>이전직장명</span>
                                            <span class="chk"><input type="checkbox" name="chk1" value="19"/>학생코드</span>
                                            <span class="chk"><input type="checkbox" name="chk1" value="20"/>과정타입</span>
                                        </td>
                                        <td>
                                            <input type="button" class="btn" id="check_btn" value="검색"/>
                                            <br/>
                                            <br/>
                                        </td>
                                    </tr>
                                </table>
                            </form>
						</div>
						<div id="traineeReceipt_Table">
                            <!--훈련생에대한 정보 가져오기 -->

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
        let searchType ="0";
        let searchValue ="";
        let numSelect="5";
        let yearSelect="0";
        let ctSelect="";
        let cSelect="";
        let cPage ="";
        let str = "";
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
            let ar = document.frm.chk1;
            for(let i=0; i<ar.length;i++){
                if(ar[i].checked){
                    str+=ar[i].value+",";
                }
            }

            let now = new Date();	// 현재 날짜 및 시간
            let year = now.getFullYear();
            let str2 ="<option value='0'>년도선택</option>";
            for(let i=year+1; i>year-5; i--){
                str2+= "<option value="+i+">"+i+"</option>";
            }
            
            $("#selectYear").html(str2);

            $.ajax({
                url:"trainee",
                type:"post",
                data:"chk1="+str+"&num="+numSelect+"&c_idx="+cSelect+"&year="+yearSelect+"&ct_idx="+ctSelect+"&select="+searchType+"&value="+searchValue,
            }).done(function(result){
                $("#traineeReceipt_Table").html(result);
            });

            $("#num_select").change(function(){
                numSelect =this.value;
                $.ajax({
                    url:"trainee",
                    type:"post",
                    data:"chk1="+str+"&num="+numSelect+"&c_idx="+cSelect+"&year="+yearSelect+"&ct_idx="+ctSelect+"&select="+searchType+"&value="+searchValue,
                }).done(function(result){
                    $("#traineeReceipt_Table").html(result);
                });
            });

            $("#selectYear").change(function(){
                yearSelect =this.value;
                $.ajax({
                    url:"trainee",
                    type:"post",
                    data:"chk1="+str+"&num="+numSelect+"&cPage="+cPage+"&c_idx="+cSelect+"&year="+yearSelect+"&ct_idx="+ctSelect+"&select="+searchType+"&value="+searchValue,
                }).done(function(result){
                    $("#traineeReceipt_Table").html(result);
                });
            });
            $("#ct_select").change(function(){
                ctSelect =this.value;
                $.ajax({
                    url:"trainee",
                    type:"post",
                    data:"chk1="+str+"&num="+numSelect+"&cPage="+cPage+"&c_idx="+cSelect+"&year="+yearSelect+"&ct_idx="+ctSelect+"&select="+searchType+"&value="+searchValue,
                }).done(function(result){
                    $("#traineeReceipt_Table").html(result);
                });
            });

            $("#c_select").change(function(){
                cSelect =this.value;
                $.ajax({
                    url:"trainee",
                    type:"post",
                    data:"chk1="+str+"&num="+numSelect+"&cPage="+cPage+"&c_idx="+cSelect+"&year="+yearSelect+"&ct_idx="+ctSelect+"&select="+searchType+"&value="+searchValue,
                }).done(function(result){
                    $("#traineeReceipt_Table").html(result);
                });
            });

            $("#check_btn").click(function(){
                ar = document.frm.chk1;
                str = "";
                for(let i=0; i<ar.length;i++){
                    if(ar[i].checked){
                        str+=ar[i].value+",";
                    }
                }
                $.ajax({
                    url:"trainee",
                    type:"post",
                    data:"chk1="+str+"&num="+numSelect+"&cPage="+cPage+"&c_idx="+cSelect+"&year="+yearSelect+"&ct_idx="+ctSelect+"&select="+searchType+"&value="+searchValue,
                }).done(function(result){
                    $("#traineeReceipt_Table").html(result);
                });
            });
            $("#search_btn").click(function(){
            searchType = $("#searchType").val();
            searchValue =$("#searchValue").val();
            $.ajax({
                    url:"trainee",
                    type:"post",
                    data:"chk1="+str+"&num="+numSelect+"&cPage="+cPage+"&c_idx="+cSelect+"&year="+yearSelect+"&ct_idx="+ctSelect+"&select="+searchType+"&value="+searchValue,
                }).done(function(result){
                    $("#traineeReceipt_Table").html(result);
                });
            });

        });

        function paging(page) {
        console.log(str);
        cPage=page;
        $.ajax({
            url:"trainee",
            type:"post",
            data:"chk1="+str+"&num="+numSelect+"&cPage="+cPage+"&c_idx="+cSelect+"&year="+yearSelect+"&ct_idx="+ctSelect+"&select="+searchType+"&value="+searchValue,
        }).done(function(result){
            $("#traineeReceipt_Table").html(result);
        });
        }

    </script>
</body>
</html>