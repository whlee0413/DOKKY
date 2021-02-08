package com.won.dokky.board;

public class BoardVO {
	
	
	String seq; 
	String cnt;
	String title; 
	String writer; 
	String content;
	String category;
	String regdate;
	String modidate;
	
	String rseq;
	
	String memId;
	String tagName;
	
	
	
	public String getRseq() {
		return rseq;
	}
	public void setRseq(String rseq) {
		this.rseq = rseq;
	}
	public String getTagName() {
		return tagName;
	}
	public void setTagName(String tagName) {
		this.tagName = tagName;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getModidate() {
		return modidate;
	}
	public void setModidate(String modidate) {
		this.modidate = modidate;
	}
	
	@Override
	public String toString() {
		return "BoardVO [seq=" + seq + ", cnt=" + cnt + ", title=" + title + ", writer=" + writer + ", content="
				+ content + ", category=" + category + ", regdate=" + regdate + ", modidate=" + modidate + ", rseq="
				+ rseq + ", memId=" + memId + ", tagName=" + tagName + "]";
	}
}
