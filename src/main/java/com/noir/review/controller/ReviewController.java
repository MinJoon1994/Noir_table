package com.noir.review.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.noir.review.service.ReviewServiceImpl;
import com.noir.review.vo.ReviewVO;

@Controller
public class ReviewController {

	@Autowired
	private ReviewServiceImpl reviewService;
	
	
	//http://localhost:8090/noir/review.do
	//리뷰게시판 리스트 성공
	@RequestMapping(value="/review.do")
	public ModelAndView reviewList(HttpServletRequest request,
			 			HttpServletResponse response) throws Exception {

		ModelAndView mav = new ModelAndView();
		String viewName = (String)request.getAttribute("viewName");

		int page = 1;
		int pageSize = 10;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		int offset = (page - 1) * pageSize;

		List<ReviewVO> reviewList = reviewService.getReviewsByPaging(offset, pageSize);
		int totalCount = reviewService.getReviewCount();
		int totalPage = (int)Math.ceil((double)totalCount / pageSize);

		int blockSize = 10;
		int startBlock = ((page - 1) / blockSize) * blockSize + 1;
		int endBlock = Math.min(startBlock + blockSize - 1, totalPage);

		mav.addObject("currentPage", page);
		mav.addObject("totalPage", totalPage);
		mav.addObject("startBlock", startBlock);
		mav.addObject("endBlock", endBlock);
		mav.addObject("currentPage", page);

		mav.addObject("reviewList", reviewList);
		mav.setViewName(viewName);

		return mav;
	}

	// http://localhost:8090/noir/review/detail.do 
	// 상세페이지 보기 성공
	@RequestMapping(value="/review/detail.do")
	public ModelAndView reviewDetail(HttpServletRequest request,
						HttpServletResponse response) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		String viewName = (String)request.getAttribute("viewName");
		System.out.println("viewName :" + viewName); //   viewName :/review/detail
		
		Long reviewId = Long.parseLong(request.getParameter("reviewId"));
		System.out.println("reviewId : " +reviewId) ;

		ReviewVO review = reviewService.getReviewById(reviewId);
		ReviewVO prevReview = reviewService.getPrevReview(reviewId);
	    ReviewVO nextReview = reviewService.getNextReview(reviewId);
	    
		mav.addObject("review", review);
		mav.addObject("prevReview", prevReview);
		mav.addObject("nextReview", nextReview);

		mav.setViewName(viewName);

		return mav;
	}

	//  http://localhost:8090/noir/review/wirte.do
	// 글쓰기 폼
	@RequestMapping(value="/review/write.do", method=RequestMethod.GET)
	public ModelAndView writeReviewForm(HttpServletRequest request,
						HttpServletResponse response) throws Exception {
		String viewName = (String)request.getAttribute("viewName");
		System.out.println("viewName :" + viewName); //   viewName :/review/wirte
		ModelAndView mav = new ModelAndView(viewName);
		ReviewVO emptyReview = new ReviewVO();
		// 필요시 reservationId 값 미리 세팅
		// emptyReview.setReservationId(...);
		mav.addObject("review", emptyReview);
		mav.addObject("formTitle", "리뷰 작성");
		mav.addObject("formAction", request.getContextPath() + "/review/write.do");
		mav.addObject("submitBtnText", "등록");
		return mav;
	}

	//  http://localhost:8090/noir/review/wirte.do
	// 글쓰기 처리
	@RequestMapping(value="/review/write.do", method=RequestMethod.POST)
	public ModelAndView writeReview(MultipartHttpServletRequest request, ReviewVO review) throws Exception {
		List<MultipartFile> files = request.getFiles("images");
		//String uploadDir = request.getServletPath().getRealPath("/resources/review");
		String uploadDir = null;
		reviewService.addReviewWithImages(review, files, uploadDir);
		return new ModelAndView("redirect:/review.do");
	}

 
	// GET  http://localhost:8090/noir/review/edit.do
	// 수정 폼
	@RequestMapping(value="/review/edit.do", method=RequestMethod.GET)
	public ModelAndView editReviewForm(HttpServletRequest request,
						HttpServletResponse response) throws Exception {
		String viewName = (String)request.getAttribute("viewName");
		System.out.println("viewName :" + viewName); 
		
		Long reviewId = Long.parseLong(request.getParameter("reviewId"));
		ReviewVO review = reviewService.getReviewById(reviewId);

		ModelAndView mav = new ModelAndView(viewName);

		mav.addObject("review", review);
		mav.addObject("formTitle", "리뷰 수정");
		mav.addObject("formAction", request.getContextPath() + "/review/edit.do");
		mav.addObject("submitBtnText", "수정");

		return mav;
	}

	// POST  http://localhost:8090/noir/review/edit.do
	// 수정 처리
	@RequestMapping(value="/review/edit.do", method=RequestMethod.POST)
	public ModelAndView editReview(MultipartHttpServletRequest request, ReviewVO review) throws Exception {
		List<MultipartFile> files = request.getFiles("images");
		//String uploadDir = request.getServletPath().getRealPath("/resources/review");
		String uploadDir = null;
		reviewService.updateReviewWithImages(review, files, uploadDir);
		return new ModelAndView("redirect:/review/detail.do?reviewId=" + review.getReviewId());
	}

	// 리뷰게시판 상세페이지 및 이미지 폴더 같이 삭제 
	@RequestMapping(value="/review/delete.do", method=RequestMethod.POST)
	public ModelAndView deleteReview(HttpServletRequest request,
						HttpServletResponse response) throws Exception {
		Long reviewId = Long.parseLong(request.getParameter("reviewId"));
		//String uploadDir = request.getServletPath().getRealPath("/resources/review");
		String uploadDir = null;
		reviewService.deleteReview(reviewId, uploadDir);
		System.out.println("reviewId :" + reviewId);
		return new ModelAndView("redirect:/review.do");
	}

}
