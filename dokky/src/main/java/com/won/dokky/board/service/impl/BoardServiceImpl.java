package com.won.dokky.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.won.dokky.board.BoardReplyVO;
import com.won.dokky.board.BoardVO;
import com.won.dokky.board.HashTagVO;
import com.won.dokky.board.mapper.BoardMapper;
import com.won.dokky.board.service.BoardService;
import com.won.dokky.board.utils.SearchCriteria;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private BoardMapper mapper;
	
	

	@Override
	public void boardInsert(BoardVO board) {
	 	mapper.boardInsert(board);
		
	}
	


	@Override
	public BoardVO selectBoard(BoardVO board) {
		return mapper.selectBoard(board);
	}



//	//페이징테스트


	@Override
	public List<BoardVO> list(SearchCriteria scri) throws Exception {
		return mapper.list(scri);
	}



	@Override
	public int listCount(SearchCriteria scri) throws Exception {
		return mapper.listCount(scri);
	}


	//게시물수정
	@Override
	public void boardModify(BoardVO board) {
		mapper.boardModify(board);
	}
	

	//게시물삭제
	@Override
	public void boardDelete(String seq) throws Exception {
		mapper.boardDelete(seq);
	}
	
	//조회수
	@Override
	public boolean plusCnt(String seq) {
		return mapper.plusCnt(seq);
	}


	//댓글조회
	@Override
	public List<BoardReplyVO> readReply(String seq) throws Exception {
		return  mapper.readReply(seq);
	}

	//댓글갯수
	@Override
	public int replyCount(String seq) throws Exception {
		return mapper.replyCount(seq);
	}


	//게시물 삭제할 때의 댓글 삭제
	public void boardRepliesDelete(String seq) throws Exception {
			mapper.boardRepliesDelete(seq);
		
	}


	//댓글작성
	@Override
	public void boardReplyInsert(BoardReplyVO board) {
		mapper.boardReplyInsert(board);
		
	}


	//댓글 삭제
	@Override
	public void boardReplyDelete(String seq, String rseq) throws Exception {
		mapper.boardReplyDelete(seq, rseq);
		
	}


	//댓글 수정
	@Override
	public int boardReplyModify(BoardReplyVO board) throws Exception {
		return mapper.boardReplyModify(board);
	}


	//댓글 단 건 조회
	@Override
	public BoardReplyVO selectReply(String seq, String rseq) throws Exception {
		return mapper.selectReply(seq, rseq);
	}


	//커뮤니티 게시글
	@Override
	public List<BoardVO> boardCummunity() throws Exception {
		return mapper.boardCummunity();
	}


	//QnA게시글
	@Override
	public List<BoardVO> boardQandA() throws Exception {
		return mapper.boardQandA();
	}


	//해쉬태그조회
	@Override
	public HashTagVO readHashtag(String tagName) throws Exception {
		return mapper.readHashtag(tagName);
	}


	//해쉬태그복합키생성
	@Override
	public void boardHashtagInsert(HashTagVO hashtagVO) {
		mapper.boardHashtagInsert(hashtagVO);
	}


	//해쉬태그 등록
	@Override
	public void hashtagInsert(HashTagVO hashtagVO) {
		mapper.hashtagInsert(hashtagVO);
	}


	// 가장 최근 게시물 조회
	@Override
	public String boardMaxSeq() throws Exception {
		return mapper.boardMaxSeq();
	}


	 //해쉬태그 참조테이블 삭제
	@Override
  	public void boardHashtagDelete(String seq) throws Exception{
		mapper.boardHashtagDelete(seq);
	}

	//게시글-해쉬태그조회
	@Override
	public List<HashTagVO> selectHashTags(String seq) throws Exception {
		return mapper.selectHashTags(seq);
	}


	//메인 해쉬태그 리스트 조회
	@Override
	public List<HashTagVO> boardHashTags() throws Exception {
		return mapper.boardHashTags();
	}




	



}
