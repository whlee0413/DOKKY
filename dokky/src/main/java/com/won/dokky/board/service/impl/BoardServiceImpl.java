package com.won.dokky.board.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.won.dokky.board.BoardVO;
import com.won.dokky.board.HashTagVO;
import com.won.dokky.board.mapper.BoardMapper;
import com.won.dokky.board.service.BoardService;
import com.won.dokky.board.utils.SearchCriteria;
import com.won.util.FileUtils;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private BoardMapper mapper;
	
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;

	@Override
	public void boardInsert(BoardVO board, MultipartHttpServletRequest mpRequest) throws Exception{
	 	mapper.boardInsert(board);
	 	
	 	
	 	List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(board, mpRequest);
	 	int size = list.size();
	 	for(int i=0; i<size; i++) {
	 		
	 		System.out.println("list [" +i+"]    :" + list.get(i));
	 		mapper.insertFile(list.get(i));
	 	}
		
	}
	


	@Override
	public BoardVO selectBoard(BoardVO board) {
		return mapper.selectBoard(board);
	}






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
	public void boardModify(BoardVO board,  
							String[] files, 
							String[] fileNames, 
							MultipartHttpServletRequest mpRequest) throws Exception {
		mapper.boardModify(board);
		
		//업뎃파일 리스트에 담음
		List<Map<String, Object>> list = fileUtils.parseUpdateFileInfo(board, files, fileNames, mpRequest);
		Map<String, Object> tempMap = null;
		int size = list.size();
		

		for(int i = 0; i<size; i++) {		//리스트 결과 사이즈만큼 돌림
			tempMap = list.get(i);
			if(tempMap.get("IS_NEW").equals("Y")) {
				mapper.insertFile(tempMap);
			}else {
				mapper.updateFile(tempMap);
			}
		}
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
	public List<BoardVO> readReply(String seq) throws Exception {
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
	public void boardReplyInsert(BoardVO board) {
		mapper.boardReplyInsert(board);
		
	}


	//댓글 삭제
	@Override
	public void boardReplyDelete(String seq, String rseq) throws Exception {
		mapper.boardReplyDelete(seq, rseq);
		
	}


	//댓글 수정
	@Override
	public int boardReplyModify(BoardVO board) throws Exception {
		return mapper.boardReplyModify(board);
	}


	//댓글 단 건 조회
	@Override
	public BoardVO selectReply(String seq, String rseq) throws Exception {
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


	//첨부파일조회
	@Override
	public List<Map<String, Object>> selectFileList(String seq) throws Exception {
		return mapper.selectFileList(seq);
	}


	//첨부파일다운로드
	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		return mapper.selectFileInfo(map);
	}


	//작성자별 게시물조회
	@Override
	public List<BoardVO> writerBoardList(SearchCriteria scri) throws Exception {
		return mapper.writerBoardList(scri);
	}


	// 작성자별 게시물 갯수
	@Override
	public int writerBoardListCount(SearchCriteria scri) throws Exception {
		return mapper.writerBoardListCount(scri);
	}




	



}
