package com.won.dokky.board.web;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.won.dokky.board.BoardReplyVO;
import com.won.dokky.board.BoardVO;
import com.won.dokky.board.HashTagVO;
import com.won.dokky.board.service.BoardService;
import com.won.dokky.board.utils.PageMaker;
import com.won.dokky.board.utils.SearchCriteria;
import com.won.dokky.member.service.MemberService;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	MemberService memberService;
	@Autowired
	PageMaker pageMaker;
	
	
	//페이징 리스트
	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public String list(Model model,   @ModelAttribute("scri") SearchCriteria scri) throws Exception{
		  //@ModelAttribute 어노테이션이 붙은 객체가 (scri객체) 자동으로 Model객체에 추가되고 뷰단으로 전달된다.
		 //@ModelAttribute("scri") SearchCriteria scri 에서 괄호안에있는 scri 값을 통해서 뷰단에서 데이터들을 호출할수있다.

		
		
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(boardService.listCount(scri));

		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("list", boardService.list(scri));
		
		
		
		return "/board/boardPaging";
	}
	
	//작성자 게시글 조회
	@RequestMapping(value="/writerBoardList", method = RequestMethod.GET)
	public String writerBoardList(Model model, @ModelAttribute("scri") SearchCriteria scri
								) throws Exception{

		
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(boardService.writerBoardListCount(scri));
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("list", boardService.writerBoardList(scri));
		return "/board/writerBoard";
		
		
	}
	
	
	
	
	// 게시글 등록폼
	@RequestMapping("/boardInsertForm")
	public String boardInsertForm(BoardVO board, HttpSession session)   {
		return "/board/boardInsert";
	}
	
	// 게시글 등록	
	@RequestMapping(value = "/boardInsert", method = RequestMethod.POST)
	public String boardInsert(BoardVO board, HttpSession session, Model model
							, @RequestParam(value="category", required=false) String category
							, HashTagVO vo
							, MultipartHttpServletRequest mpReqeust) throws Exception {
		//category를 redirect 뒤로 같이 보냄
		model.addAttribute("category",category);
		boardService.boardInsert(board, mpReqeust); 
		//공백, 콤마, # 제거
		String hashtags = vo.getTagName().replace(" ", "").replace(",", "");
		String[] tagName = hashtags.split("#");
		
		for(int i=1; i<tagName.length; i++) {
			try {
				//중복조회
				HashTagVO result = boardService.readHashtag(tagName[i]);
				
				//기존 해쉬태그에서 조회값이 없으면 새로 생성
				if(result==null) {
				vo.setTagName(tagName[i]);
				boardService.hashtagInsert(vo);
				}
				System.out.println("tagNane?:  " +tagName[i] + "  tagId?:  "+boardService.readHashtag(tagName[i]) );
				//참조테이블 생성
				vo.setSeq(boardService.boardMaxSeq());
				vo.setTagId(boardService.readHashtag(tagName[i]).getTagId());
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
		
		List<BoardVO> replyList = boardService.readReply(seq);
		model.addAttribute("replyList", replyList);
		int replyCount = boardService.replyCount(seq);
		model.addAttribute("replyCount", replyCount);
		model.addAttribute("hashTagList", boardService.selectHashTags(seq));

		List<Map<String, Object>> fileList = boardService.selectFileList(seq);
		System.out.println("fileList : " +fileList);
		model.addAttribute("file",fileList);
		
		return "/board/boardContent";
	}
	
	// 게시물 수정폼
	@RequestMapping("/boardModifyForm")
	public String boardModifyForm( BoardVO board, Model model ) throws Exception {
		model.addAttribute("board", boardService.selectBoard(board));
		
		//해쉬태그 배열 -> String 값으로 담아서 input Value값으로 전달.
		List<HashTagVO> hashTag =  boardService.selectHashTags(board.getSeq());
		String result = "";
		for(int i=0; i<hashTag.size(); i++) {
			if(i==hashTag.size()-1) {
				result += "#" + hashTag.get(i).getTagName();	
			}else {
				result += "#" + hashTag.get(i).getTagName() + ", " ;	
			}
		}
		model.addAttribute("hashTag", result);
		
		List<Map<String, Object>> fileList = boardService.selectFileList(board.getSeq());
		model.addAttribute("file", fileList);
		
		return "/board/boardModify";
	}
	// 게시물 수정
	@RequestMapping(value = "/boardModify", method = RequestMethod.POST)
	public String boardModify(BoardVO board, Model model, 
							  HashTagVO vo,
							  @RequestParam(value="fileNoDel[]") String[] files,
							  @RequestParam(value="fileNameDel[]") String[] fileNames,
							  MultipartHttpServletRequest mpRequest) throws Exception {
		
		model.addAttribute("seq", board.getSeq());
		boardService.boardModify(board, files, fileNames, mpRequest);
		boardService.boardHashtagDelete(board.getSeq());
		//공백, 콤마, # 제거
				String hashtags = vo.getTagName().replace(" ", "").replace(",", "");
				String tagName[] = hashtags.split("#");
				
				for(int i=1; i<tagName.length; i++) {
					try {
						//중복조회
						HashTagVO result = boardService.readHashtag(tagName[i]);
						
						//기존 해쉬태그에서 조회값이 없으면 새로 생성
						if(result==null) {
						vo.setTagName(tagName[i]);
						boardService.hashtagInsert(vo);
						}
						//참조테이블 생성
						vo.setSeq(board.getSeq());
						vo.setTagId(boardService.readHashtag(tagName[i]).getTagId());
						boardService.boardHashtagInsert(vo);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
		
		
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
	@RequestMapping(value = "/boardReplyInsert", method = RequestMethod.POST)
	public String boardReplyInsert(BoardVO board, BoardReplyVO boardReply, HttpSession session, Model model
							) {
		//category를 redirect 뒤로 같이 보냄
		model.addAttribute("seq",board.getSeq());
		
		boardReply.setWriter(board.getMemId());
		boardReply.setSeq(board.getSeq());
		
		
		boardService.boardReplyInsert(boardReply);
		return "redirect:/boardRead";
	}
	
	// 댓글 삭제
		@RequestMapping("/boardReplyDelete")
		public String boardReplyDelete(BoardVO board, BoardReplyVO boardReplyVO, Model model) throws Exception {

			
			boardService.boardReplyDelete(boardReplyVO.getSeq(), boardReplyVO.getRseq());
			model.addAttribute("category",board.getSeq());
			model.addAttribute("seq",board.getSeq());
			return "redirect:/boardRead";
		}
		
		
		//댓글 수정
		@RequestMapping( value = "/boardReplyModify", method =RequestMethod.POST)   
	    public String boardReplyModify( BoardReplyVO boardReplyVO
	    							 , Model model) throws Exception{
			
			//seq 중복으로 들어오는거 함수로 처리해보기.
			String seq = boardReplyVO.getSeq().substring(0, boardReplyVO.getSeq().indexOf(","));
			boardReplyVO.setSeq(seq);
			boardService.boardReplyModify(boardReplyVO);
	        model.addAttribute("seq", boardReplyVO.getSeq());
	        return "redirect:boardRead";
	    }
		

		// 댓글 단건 조회
		@RequestMapping("/boardReplySelect")
		@ResponseBody
		public BoardVO boardReplySelect(@RequestParam String seq, @RequestParam String rseq) throws Exception {
			return  boardService.selectReply(seq, rseq);
		}
		
		

//메인페이지 리스트
		//커뮤니티 게시글 조회
		@RequestMapping("/boardCummunity")
		@ResponseBody
		public List<BoardVO> boardCummunity() throws Exception{
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
		
		
		//파일다운로드
		@RequestMapping(value="/fileDown")
		public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception{
			Map<String, Object> resultMap = boardService.selectFileInfo(map);
			String storedFileName = (String) resultMap.get("STORED_FILE_NAME");
			String originalFileName = (String) resultMap.get("ORG_FILE_NAME");
			
			// 파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환한다.
			byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:\\mp\\file\\"+storedFileName));
			
			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition",  "attachment; fileName=\""+URLEncoder.encode(originalFileName, "UTF-8")+"\";");
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();
			
		}
}
