package com.ict.project.util;

public class Paging {
	int nowPage =1; 	// ���� ������ �� == cPage
	int numPerPage =5;		// �� �������� ������ �Խù��� �� 
	
	int totalRecord; //�ѰԽù��� �� 
	int pagePerBlock = 5; // �� ���� ǥ���� ������ �� 
	
	int totalPage; //��ü������ �� 
	
	int begin; //���� �������� �Խù��� ���ȣ
	int end; //���� �������� �Խù��� ������ ���ȣ
	
	int startPage; //�� ���� ���� ������ ��
	int endPage; // �� ���� ������ ������ ��
	
	// ��ü�� ������ �� �⺻ �����ڸ� �θ��� �� �������� 10���� �����ִ� ����¡ ����� ����
	public Paging(){}
	
	public Paging(int numPerPage, int pagePerBlock) {
		this.numPerPage = numPerPage;
		this.pagePerBlock = pagePerBlock;
		
	}

	public int getNowPage() {
		return nowPage;
	}

	public void setNowPage(int nowPage) {
		// ���� ���������� �� ������ ���� �ѱ������ϵ��� ����
		if(nowPage > totalPage)
			nowPage = totalPage;

		this.nowPage = nowPage;
		// ���� �� ��ȣ�� ������ ���ȣ ����
		begin = (nowPage-1)*numPerPage+1;
		end = nowPage*numPerPage;
		
		// ���� ������ ���� ���� ���� ����������(startPage)���ϱ�
		startPage =(int)((nowPage-1)/pagePerBlock)*pagePerBlock+1;
		
		// ���� ������ �������� ���ϱ�
		endPage = startPage + pagePerBlock - 1;
		
		// ������ ������ ���� ��ü ������ ������ Ŭ���� �����Ͽ�
		if(endPage > totalPage)
			endPage = totalPage;
		
		
	}

	public int getNumPerPage() {
		return numPerPage;
	}

	public void setNumPerPage(int numPerPage) {
		this.numPerPage = numPerPage;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		this.totalPage =(int)Math.ceil((double)totalRecord/numPerPage);
	}

	public int getPagePerBlock() {
		return pagePerBlock;
	}

	public void setPagePerBlock(int pagePerBlock) {
		this.pagePerBlock = pagePerBlock;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getBegin() {
		return begin;
	}

	public void setBegin(int begin) {
		this.begin = begin;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
	

}
