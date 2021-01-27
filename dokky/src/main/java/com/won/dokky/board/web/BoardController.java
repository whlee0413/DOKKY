package com.won.dokky.board.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.won.dokky.board.BoardReplyVO;
import com.won.dokky.board.BoardVO;
import com.won.dokky.board.HashTagVO;
import com.won.dokky.board.service.BoardService;
import com.won.dokky.board.utils.PageMaker;
import com.won.dokky.board.utils.SearchCriteria;
import com.won.dokky.member.MemberVO;
import com.won.dokky.member.service.MemberService;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	MemberService memberService;
	
	//페이징 리스트
	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public String list(Model model,  String category, String tagName
					   ,@ModelAttribute("scri") SearchCriteria scri) throws Exception{
		  //@ModelAttribute 어노테이션이 붙은 객체가 (scri객체) 자동으로 Model객체에 추가되고 뷰단으로 전달된다.
		 //@ModelAttribute("scri") SearchCriteria scri 에서 괄호안에있는 scri 값을 통해서 뷰단에서 데이터들을 호출할수있다.

		System.out.println("category :    " + category);
		
		PageMaker pageMaker = new PageMaker();
		
		pageMaker.setTagName(tagName);
		pageMaker.setCri(scri);
		pageMaker.setCategory(category);
		pageMaker.setTotalCount(boardService.listCount(scri));
		
		
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("list", boardService.list(scri));
		
		System.out.println("리스트 결과값 : " +boardService.list(scri));
		
		
		return "/board/boardPaging";
	}
	
	
	// 게시글 등록폼
	@RequestMapping("/boardInsertForm")
	public String boardInsertForm(BoardVO board, HttpSession session)   {
		return "/board/boardInsert";
	}
	
	// 게시글 등록	
	@RequestMapping("/boardInsert")
	public String boardInsert(BoardVO board, HttpSession session, Model model
							, @RequestParam(value="category", required=false) String category
							, HashTagVO vo) throws Exception {
		//category를 redirect 뒤로 같이 보냄
		model.addAttribute("category",category);
		boardService.boardInsert(board);
		
		System.out.println("seq 값은???    " + boardService.boardMaxSeq());
		System.out.println("해쉬태그   " +vo.getTagName());
		
		//공백, 콤마, # 제거
		String hashtags = vo.getTagName().replace(" ", "").replace(",", "");
		String tagName[] = hashtags.split("#");
		for(int i=1; i<tagName.length; i++) {
			System.out.println("tagName["+i+"] :  " +   tagName[i]);
			
			try {
				//중복조회
				String result = boardService.readHashtag(tagName[i]);
				System.out.println("결과값은???    "+result);
				
				//기존 해쉬태그에서 조회값이 없으면 새로 생성
				if(result==null) {
				vo.setTagName(tagName[i]);
				boardService.hashtagInsert(vo);
				}
				System.out.println("이건?:  " +tagName[i] + "요고는?:  "+boardService.readHashtag(tagName[i]) );
				//참조테이블 생성
				vo.setSeq(boardService.boardMaxSeq());
				vo.setTagId(boardService.readHashtag(tagName[i]));
				boardService.boardHashtagInsert(vo);
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "redirect:/boardList";
	}
	
	// 게시글 내용 조회
	@RequestMapping("/boardRead")
	public String boardReadForm( String seq, BoardVO board, Model model) throws Exception {
		model.addAttribute("board", boardService.selectBoard(board));
		boardService.plusCnt(seq);
		
		List<BoardReplyVO> replyList = boardService.readReply(seq);
		model.addAttribute("replyList", replyList);
		int replyCount = boardService.replyCount(seq);
		model.addAttribute("replyCount", replyCount);
		model.addAttribute("hashTagList", boardService.selectHashTags(seq));
		System.out.println("해쉬태그들  :" +boardService.selectHashTags(seq));
		return "/board/boardContent";
	}
	
	// 게시물 수정폼
	@RequestMapping("/boardModifyForm")
	public String boardModifyForm(String seq, BoardVO boardVO, MemberVO memberVO, Model model ) {
		
		model.addAttribute("board", boardService.selectBoard(boardVO));
		System.out.println(boardService.selectBoard(boardVO));
		return "/board/boardModify";
	}
	// 게시물 수정
	@RequestMapping("/boardModify")
	public String boardModify(BoardVO board, Model model, String seq) {
		System.out.println("뭐가 넘어올까나 : " + board);
		model.addAttribute("seq", seq);
		boardService.boardModify(board);
		return	"redirect:/boardRead";
	}
	
	// 게시물 삭제
	@RequestMapping("/boardDelete")
	public String boardDelete(BoardVO board, Model model) throws Exception {
		
		//굳이 파라미터 seq를 안받아도 board객체의 getSeq()로 받아서 넘기면 됨.
		boardService.boardRepliesDelete(board.getSeq());	//댓글삭제
		boardService.boardHashtagDelete(board.getSeq());	//해쉬태그삭제
		boardService.boardDelete(board.getSeq());			//게시글삭제
		model.addAttribute("category",board.getCategory());
		return "redirect:/boardList";
	}
	
	// 댓글 작성
	@RequestMapping("/boardReplyInsert")
	public String boardReplyInsert(BoardVO board, BoardReplyVO boardReply, HttpSession session, Model model
							) {
		//category를 redirect 뒤로 같이 보냄
		model.addAttribute("seq",board.getSeq());
		
		System.out.println( "board : " +board);
		System.out.println( "boardReply : " +boardReply);
		boardReply.setWriter(board.getMemId());
		boardReply.setSeq(board.getSeq());
		
		
		boardService.boardReplyInsert(boardReply);
		return "redirect:/boardRead";
	}
	
	// 댓글 삭제
		@RequestMapping("/boardReplyDelete")
		public String boardReplyDelete(BoardVO board, BoardReplyVO boardReplyVO, Model model) throws Exception {

			System.out.println( "boardReplyVO : " +boardReplyVO);
			
			boardService.boardReplyDelete(boardReplyVO.getSeq(), boardReplyVO.getRseq());
			model.addAttribute("category",board.getSeq());
			model.addAttribute("seq",board.getSeq());
			return "redirect:/boardRead";
		}
		
		
		//댓글 수정
		@RequestMapping("/boardReplyModify")   
	    public String boardReplyModify( BoardReplyVO boardReplyVO
	    							 , @RequestParam("rseq") String rseq
	    							 , @RequestParam("seq") String seq
	    							 , Model model) throws Exception{
	        boardService.boardReplyModify(boardReplyVO);
	        model.addAttribute("seq", boardReplyVO.getSeq());
	        return "redirect:boardRead";
	    }
		

		// 댓글 단건 조회
		@RequestMapping("/boardReplySelect")
		@ResponseBody
		public BoardReplyVO boardReplySelect(@RequestParam String seq, @RequestParam String rseq) throws Exception {
			return  boardService.selectReply(seq, rseq);
		}
		
		

//메인페이지 리스트
		//커뮤니티 게시글 조회
		@RequestMapping("/boardCummunity")
		@ResponseBody
		public List<BoardVO> boardCummunity() throws Exception{
			System.out.println("asdasdasdas"+boardService.boardCummunity());
			return boardService.boardCummunity();
		}
		
		//Q/A 게시글 조회
		@RequestMapping("/boardQandA")
		@ResponseBody
		public List<BoardVO> boardQandA() throws Exception{
			return boardService.boardQandA();
		}
		
		//해쉬태그 조회
		@RequestMapping("/boardHashTags")
		@ResponseBody
		public List<HashTagVO> boardHashTags() throws Exception{
			return boardService.boardHashTags();
		}
}
