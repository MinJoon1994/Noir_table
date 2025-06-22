package com.noir.review.service;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.noir.member.vo.MemberVO;
import com.noir.review.dao.ReviewDAOImpl;
import com.noir.review.vo.ReviewCustomerVO;
import com.noir.review.vo.ReviewVO;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewDAOImpl reviewDAO;
	
	@Override
	public List<ReviewVO> getReviewsByPaging(int offset, int limit) throws Exception {
		return reviewDAO.selectReviewsByPaging(offset, limit);
	}

	@Override
	public int getReviewCount() throws Exception {
		return reviewDAO.selectReviewCount();
	}

	//리뷰게시판 상세페이지 보기
	@Override
	public ReviewVO getReviewById(int reviewId) throws Exception {
		
		ReviewVO review = reviewDAO.selectReviewById(reviewId);
		
		return review;
	}

	@Override
	public void addReviewWithImages(ReviewVO review) throws Exception {
		
		reviewDAO.insertReview(review);
	}

	@Override
	public void updateReviewWithImages(ReviewVO review, List<MultipartFile> images, String uploadDir) throws Exception {
		
	}

	//리뷰게시판 삭제하기
	@Override
	public void deleteReview(int reviewId, String uploadDir) throws Exception {
		reviewDAO.deleteReviewPhotos(reviewId);
		reviewDAO.deleteReview(reviewId);
		// 폴더 삭제
		String reviewFolderPath = uploadDir + File.separator + reviewId;
		File dir = new File(reviewFolderPath);
		if (dir.exists()) {
			for (File file : dir.listFiles()) file.delete();
			dir.delete();
		}
	}

	private String getExtension(String filename) {
		int dot = filename.lastIndexOf('.');
		return dot == -1 ? "" : filename.substring(dot + 1).toLowerCase();
	}

	private boolean isImageExt(String ext) {
		return ext.equals("jpg") || ext.equals("jpeg") || ext.equals("png") || ext.equals("gif");
	}
	
	
	//고객 리뷰 남길수 있는 목록 불러오기
	public List<ReviewCustomerVO> getCustomerReservation(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		
		int member_id = member.getId();
		
		List<ReviewCustomerVO> list = reviewDAO.findReserveByMemberId(member_id);
		
		return list;
				
	}
	
	//고객 리뷰 남길수 있는 목록 불러오기
	public List<ReviewCustomerVO> getCustomerReservation2(HttpServletRequest request) {
		

		List<ReviewCustomerVO> list = reviewDAO.findReserve();
		
		return list;
		
	}
	
	
	public ReviewCustomerVO getReserveByCustomId(int customer_id) {
		
		return reviewDAO.getReserveByCustomId(customer_id);
	}
}