package com.kh.spring.board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.spring.board.model.service.BoardService;
import com.kh.spring.board.model.service.BoardServiceImpl;
import com.kh.spring.board.model.vo.Board;
import com.kh.spring.common.model.vo.PageInfo;
import com.kh.spring.common.template.Pagination;
@Controller
public class BoardController {
	
	@Autowired
	private BoardServiceImpl bService;
	
	//메뉴바 클릭시    /list.bo(기본적으로 1번페이지)
	//페이징바 클릭 시  /list.bo?cpage=요청페이지번호
	/*
	@RequestMapping("list.bo")
	public String selectList(@RequestParam(value="cpage", defaultValue="1") int currentPage, Model model) {
		int listCount = bService.selectListCount();
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		
		ArrayList<Board> list = bService.selectList(pi);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		
		//포워딩할 뷰 (/WEB-INF/views/  board/boardListView  .jsp)
		return "board/BoardListView";
		
	}*/
	
	@RequestMapping("list.bo")
	public ModelAndView selectList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv) {
		int listCount = bService.selectListCount();
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		
		ArrayList<Board> list = bService.selectList(pi);
		
		/*
		mv.addObject("pi", pi);
		mv.addObject("list", list);
		mv.setViewName("board/BoardListView");
		*/
		mv.addObject("pi",pi).addObject("list", list).setViewName("board/BoardListView");
		
		return mv;
		
	}
	
	
	@RequestMapping("enrollForm.bo")
	public String enrollForm() {
		//포워딩할 뷰 (/WEB-INㄲF/views/  board/boardEnrollForm  .jsp)
		return "board/BoardEnrollForm";
	}
	
	@RequestMapping("insert.bo")
	public String insertBoard(Board b, MultipartFile upfile, HttpSession session, Model model) {
		//System.out.println(b);
		//System.out.println(upfile); 첨부파일 선택하든 안하든 생성되는 객체지만 filename에 원본명 있냐 없냐 그차이 그걸로 첨부파일 유무가리면되겠네 
		
		//전달된 파일명 있을경우 파일명 수정 후 서버 업로드
		//파일 첨부할떄!
		if(!upfile.getOriginalFilename().equals("")) {
			/*
			//파일명 수정후 서버업로드하기
			String originName = upfile.getOriginalFilename(); //flower.png
			//"2025082512345553"
			String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			int ranNum = (int)(Math.random()*90000+10000);
			String ext = originName.substring(originName.lastIndexOf(".")); //.png
			
			String changeName = currentTime + ranNum + ext;
			
			//업로드 시키고자하는 폴더의 물리적 경로 알아내기 
			String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
			try {
				upfile.transferTo(new File(savePath + changeName));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}*/
			
			
			//원본명, 서버 업로드된 경로 Board b에 마저담기
			String changeName = saveFile(upfile, session);
			b.setOriginName(upfile.getOriginalFilename());
			b.setChangeName("/resources/uploadFiles/" + changeName);			
			
		}	
		// 넘어온 첨부파일 있는경우 b= 제목, 작성자, 내용, 파일원본명, 파일저장로 
		// 넘어온 첨부파일 없는경우 b= 제목, 작성자, 내용
		int result = bService.insertBoard(b);
		
		if(result>0) {//성공
			session.setAttribute("alertMsg", "성공적으로 게시글 등록");
			return "redirect:list.bo";
		}else {//실패
			model.addAttribute("errorMsg", "게시글 등록 실패 ");
			return "common/errorPage";
		}
	}
	
	//현재 넘어온 첨부파일을 서버 폴더에 저장시키는 역할
	public String saveFile(MultipartFile upfile, HttpSession session) {
		String originName = upfile.getOriginalFilename(); //flower.png
		//"2025082512345553"
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		int ranNum = (int)(Math.random()*90000+10000);
		String ext = originName.substring(originName.lastIndexOf(".")); //.png
		
		String changeName = currentTime + ranNum + ext;
		
		//업로드 시키고자하는 폴더의 물리적 경로 알아내기 
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
			
		return changeName;
	}
	
	@RequestMapping("detail.bo")
	public ModelAndView selectBoard(int bno, ModelAndView mv) {

		//bno에 조회할 게시글번호담김		
		// 해당 게시글 조회수 증가용 update 하고옴
		int result =bService.increaseCount(bno);
		
		if(result > 0) {//성공적으로 조회수 증가
			// >> boardDetailView.jsp 상 필요한 데이터 조회 (게시글 상세정보 조회용 서비스 호출)
	        Board b = bService.selectBoard(bno);	   
	        // >> 조회된 데이터 담아서  board/boardDetailView.jsp로 포워딩	
	        mv.addObject("b", b).setViewName("board/boardDetailView");
	    } else {
	        mv.addObject("errorMsg", "게시글 조회 실패").setViewName("common/errorPage");
	    }
		
		return mv;	
		
	}
		
}

