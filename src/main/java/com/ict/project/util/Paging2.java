package com.ict.project.util;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Paging2 {
	private int nowPage , 
	 			rowTotal , 
	 			blockList, 
	
	 			blockPage, 
	 			totalPage, 
	 			startPage,
	 			endPage,
	
	 			begin, 
 				end; 
	
	private boolean isPrePage,
					isNextPage;
	

	private StringBuffer sb;
	
	public Paging2(int nowPage, int rowTotal, int blockList, int blockPage) {
		this.nowPage = nowPage;
		this.rowTotal = rowTotal;
		
		this.blockList = blockList;
		this.blockPage = blockPage;
		
		isPrePage = false;
		isNextPage = false;
		
		
		this.totalPage =(int)Math.ceil((double)rowTotal/blockList);
		
		if(nowPage > totalPage) {
			nowPage = totalPage;
			this.nowPage = nowPage;
		}
		
		startPage = ((int)(nowPage-1)/blockPage)*blockPage+1; 
		endPage = startPage+blockPage-1;
		if(endPage > totalPage)
			endPage = totalPage;
	
		begin = (nowPage-1)*blockList+1;
		end = nowPage*blockList;
		
		if(startPage >1)
			isPrePage = true;
		
		if(endPage < totalPage)
			isNextPage = true;
		/*
		
				<c:if test="${requestScope.page.startPage >= requestScope.page.pagePerBlock }">
					<c:if test="${param.select != null}">
						${page.startPage-page.pagePerBlock }
					</c:if>
				</c:if>
	
				<c:forEach begin="${page.startPage }" end="${page.endPage }" varStatus="vs">
					<c:if test="${vs.index eq page.nowPage }">
						${vs.index }</li>
					</c:if>
					<c:if test="${vs.index ne page.nowPage }">
						<li><a href="javascript:paging('${vs.index}')${vs.index}</a></li>
					</c:if>
				</c:forEach>
		
				<c:if test="${page.endPage < page.totalPage }">
					<li><a href="javascript:paging('${page.startPage + page.pagePerBlock }'
				</c:if>
				
	                      		</ol> */
		sb = new StringBuffer();
		sb.append("<ol class='page'>");
		if(isPrePage) {
			sb.append("<li><a href='javascript:paging(");
			sb.append(startPage-blockPage);
			sb.append(")'>&lt;</a></li>");
		}else
			sb.append("<li class='disable'>&lt;</li>");
		
		for(int i = startPage; i<=endPage; i++) {
			if(i==nowPage) {
				sb.append("<li class='now'>");
				sb.append(i);
				sb.append("</li>");
			}else {
				sb.append("<li><a href='javascript:paging(");
				sb.append(i);
				sb.append("'>");
				sb.append(i);
				sb.append("</a></li>");
			}
		}
		if(isNextPage) {
			sb.append("<li><a href='javascript:paging(");
			sb.append(startPage+blockPage);
			sb.append(")'>&gt;</a></li>");
		}else
			sb.append("<li class='disable'>&gt;</li></ol>");
	}


}
