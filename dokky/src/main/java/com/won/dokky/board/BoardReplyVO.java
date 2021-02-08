package com.won.dokky.board;

public class BoardReplyVO extends BoardVO{

	private String seq;
	private String rseq;
	private String content;
	private String writer;
	private String regdate;
	
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getRseq() {
		return rseq;
	}
	public void setRseq(String rseq) {
		this.rseq = rseq;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "BoardReplyVO [seq=" + seq + ", rseq=" + rseq + ", content=" + content + ", writer=" + writer + "]";
	}
	
		
	
}
