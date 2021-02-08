package com.won.dokky.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.won.dokky.board.BoardVO;
import com.won.dokky.board.HashTagVO;
import com.won.dokky.board.utils.SearchCriteria;

public interface BoardMapper {
	//게시물작성
	public void boardInsert(BoardVO board);
	//게시물수정
	public void boardModify(BoardVO board);
	//게시물 삭제
	public void boardDelete(String seq) throws Exception;
	//게시물 삭제할 때의 댓글 삭제
	public void boardRepliesDelete(String seq) throws Exception;
	//단건조회
	public BoardVO selectBoard(BoardVO board);
	// 가장 최근 게시물 조회
	public String boardMaxSeq() throws Exception;
	// 리스트(페이징)
	public List<BoardVO> list(SearchCriteria scri) throws Exception;
	// 총게시물. 검색기능에서 쓰기 위해서 scri 넘겨줌.
	public int listCount(SearchCriteria scri) throws Exception; 
	// 작성자별 게시물
	public List<BoardVO> writerBoardList(SearchCriteria scri) throws Exception;
	// 작성자별 게시물 갯수
	public int writerBoardListCount(SearchCriteria scri) throws Exception;
	// 조회수	
	public boolean plusCnt(String seq);
	
	// 첨부파일 업로드
	public void insertFile(Map<String,Object> map) throws Exception;
	// 첨부파일 조회
	public List<Map<String, Object>> selectFileList(String seq) throws Exception;
	// 첨부파일 다운
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;
	// 첨부파일 수정
	public void updateFile(Map<String, Object> map) throws Exception;
	
	// 댓글조회	
	public List<BoardVO> readReply(String seq) throws Exception;
	// 댓글 갯수
	public int replyCount(String seq) throws Exception;
	// 댓글 작성
	public void boardReplyInsert(BoardVO board);
	// 댓글 삭제
	public void boardReplyDelete(@Param("seq")String seq, @Param("rseq")String rseq) throws Exception;
	// 댓글 수정
    public int boardReplyModify(BoardVO board) throws Exception;
    // 댓글 한 건 조회
    public BoardVO selectReply(@Param("seq")String seq, @Param("rseq")String rseq) throws Exception;

	
    //커뮤니티게시글 조회
    public List<BoardVO> boardCummunity() throws Exception;
    //Q/A조회
    public List<BoardVO> boardQandA() throws Exception;
    //메인 해쉬태그 리스트 조회
    public List<HashTagVO> boardHashTags() throws Exception;
    
    
    //게시글-해쉬태그조회
    public  List<HashTagVO> selectHashTags(String seq) throws Exception;
    //해쉬태그중복값조회
    public HashTagVO readHashtag(String tagName) throws Exception;
    //해쉬태그복합키 생성
    public void boardHashtagInsert(HashTagVO hashtagVO);
    //해쉬태그 생성
    public void hashtagInsert(HashTagVO hashtagVO);
    //해쉬태그 참조테이블 삭제
  	public void boardHashtagDelete(String seq) throws Exception;

  	
}
