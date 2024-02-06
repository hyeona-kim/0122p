<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions"  %>

   <h2 id="ct_h2" class="title">과정타입 등록/수정</h2>
   
  <form action="addCourseType" method="post" name="fm">
         <table id="ct_t1" class="table">
            <colgroup>
               <col width="10%"/>
               <col width="40%"/>
               <col width="10%"/>
               <col width="40%"/>
            </colgroup>
            <tbody>
            <c:if test="${c_ar ne null}">
               <c:forEach var="tvo" items="${c_ar }">
               <tr>
                  <th class="num" >${tvo.ct_idx }</th>
                  
                  <td>
                     <input type="text" name="name"  value="${tvo.ct_name }" class="text"/>
                  </td>
                  <th class="color">색상</th>
                  <td>
                     <input type="text"  name ="text" value="${tvo.ct_color }" class="text"/>
                     <input type="color"  name ="color" class="ccol" value="${tvo.ct_color }"/>
                  </td>
               </tr>
               </c:forEach>
            <c:forEach var="i" begin="${f:length(c_ar)+1}" end="7">
               <tr>
                  <th class="num">${i}</th>
                  <td>
                     <input type="text" name="name" class="text"/>
                  </td>
                  <th class="color">색상</th>
                  <td>
                     <input type="text"  name ="text" class="text"/>
                     <input type="color"  name ="color" class="ccol"/>
                  </td>
            
               </tr>
            </c:forEach>
            </c:if>
            <c:if test="${c_ar eq null }">
            <c:forEach var="i" begin="1" end="7">
               <tr>
                  <th class="num" >${i}</th>
                  <td>
                     <input type="text"  name="name" />
                  </td>
                  <th class="color">색상</th>
                  <td>
                     <input type="text"  name ="text" class="text"/>
                     <input type="color"  name ="color"  class="ccol"/>
                  </td>
               </tr>
            </c:forEach>
            </c:if>
            </tbody>
			<tfoot>
				<tr>
					<td colspan="4">
					  	<input type="submit" value="저장" class="btn"/>
    	    			 <input type="button" value="취소" id="cancel" class="btn"/>
					</td>
				</tr>
	       
    	    </tfoot>
         </table>
         <input type="hidden" name="listSelect" value="${param.listSelect}"/>
         <input type="hidden" name="cPage" value="${param.cPage}"/>
      </form>
  
