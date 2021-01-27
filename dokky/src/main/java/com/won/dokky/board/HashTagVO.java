package com.won.dokky.board;

public class HashTagVO {

	String tagName;
	String tagId;
	String seq;
	
	
	public String getTagName() {
		return tagName;
	}
	public void setTagName(String tagName) {
		this.tagName = tagName;
	}
	public String getTagId() {
		return tagId;
	}
	public void setTagId(String tagId) {
		this.tagId = tagId;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	@Override
	public String toString() {
		return "HashTagVO [tagName=" + tagName + ", tagId=" + tagId + ", seq=" + seq + "]";
	}
	
	
}
