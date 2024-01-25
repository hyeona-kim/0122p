package com.ict.project.vo;

public class TraineeVO {
	
	private String tr_idx, tr_name, tr_rrn, tr_phone, tr_hp, tr_pos_code, tr_addr, status, memo, c_idx, ct_code, tr_total_fee, ss_end;

	private CourseVO cvo;

	public CourseVO getCvo(){
		return cvo;
	}

	public void setCvo(CourseVO cvo){
		this.cvo = cvo;
	}
	
	public String getSs_end() {
		return ss_end;
	}

	public void setSs_end(String ss_end) {
		this.ss_end = ss_end;
	}

	public String getTr_idx() {
		return tr_idx;
	}

	public void setTr_idx(String tr_idx) {
		this.tr_idx = tr_idx;
	}

	public String getTr_name() {
		return tr_name;
	}

	public void setTr_name(String tr_name) {
		this.tr_name = tr_name;
	}

	public String getTr_rrn() {
		return tr_rrn;
	}

	public void setTr_rrn(String tr_rrn) {
		this.tr_rrn = tr_rrn;
	}

	public String getTr_phone() {
		return tr_phone;
	}

	public void setTr_phone(String tr_phone) {
		this.tr_phone = tr_phone;
	}

	public String getTr_hp() {
		return tr_hp;
	}

	public void setTr_hp(String tr_hp) {
		this.tr_hp = tr_hp;
	}

	public String getTr_pos_code() {
		return tr_pos_code;
	}

	public void setTr_pos_code(String tr_pos_code) {
		this.tr_pos_code = tr_pos_code;
	}

	public String getTr_addr() {
		return tr_addr;
	}

	public void setTr_addr(String tr_addr) {
		this.tr_addr = tr_addr;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getC_idx() {
		return c_idx;
	}

	public void setC_idx(String c_idx) {
		this.c_idx = c_idx;
	}

	public String getCt_code() {
		return ct_code;
	}

	public void setCt_code(String ct_code) {
		this.ct_code = ct_code;
	}

	public String getTr_total_fee() {
		return tr_total_fee;
	}

	public void setTr_total_fee(String tr_total_fee) {
		this.tr_total_fee = tr_total_fee;
	}

}
