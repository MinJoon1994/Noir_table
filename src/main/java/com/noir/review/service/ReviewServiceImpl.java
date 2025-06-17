package com.noir.review.service;

import java.util.List;
import java.util.UUID;
import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.noir.review.dao.ReviewDAOImpl;
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
	public ReviewVO getReviewById(Long reviewId) throws Exception {
		ReviewVO review = reviewDAO.selectReviewById(reviewId);
		if (review != null)
			review.setPhotoUrls(reviewDAO.selectReviewPhotos(reviewId));
		return review;
	}
	//리뷰게시판 상세페이지 이전글
	@Override
	public ReviewVO getPrevReview(Long reviewId) throws Exception {
	    return reviewDAO.selectPrevReview(reviewId);
	}
	//리뷰게시판 상세페이지 다음글
	@Override
	public ReviewVO getNextReview(Long reviewId) throws Exception {
	    return reviewDAO.selectNextReview(reviewId);
	}

	@Override
	public void addReviewWithImages(ReviewVO review, List<MultipartFile> images, String uploadDir) throws Exception {
		reviewDAO.insertReview(review); // reviewId 생성
		Long reviewId = review.getReviewId();
		String reviewFolderPath = uploadDir + File.separator + reviewId;
		File dir = new File(reviewFolderPath);
		if (!dir.exists()) dir.mkdirs();

		if (images != null) {
			for (MultipartFile file : images) {
				if (!file.isEmpty()) {
					 String ext = getExtension(file.getOriginalFilename());
	                    if (!isImageExt(ext)) continue; // 이미지 확장자만
	                    String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
	                    File dest = new File(dir, fileName);
	                    file.transferTo(dest);
	                    String photoUrl = "/resources/review/" + reviewId + "/" + fileName;
	                    reviewDAO.insertReviewPhoto(reviewId, photoUrl);
				}
			}
		}
	}

	@Override
	public void updateReviewWithImages(ReviewVO review, List<MultipartFile> images, String uploadDir) throws Exception {
		reviewDAO.updateReview(review);
		Long reviewId = review.getReviewId();
		// 기존 이미지 DB/폴더 삭제
		reviewDAO.deleteReviewPhotos(reviewId);

		// 새 이미지 저장
		String reviewFolderPath = uploadDir + File.separator + reviewId;
		File dir = new File(reviewFolderPath);
		if (!dir.exists()) dir.mkdirs();

		if (images != null) {
			for (MultipartFile file : images) {
				if (!file.isEmpty()) {
					String ext = getExtension(file.getOriginalFilename());
					if (!isImageExt(ext)) continue;
					String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
					File dest = new File(dir, fileName);
					file.transferTo(dest);
					String photoUrl = "/resources/review/" + reviewId + "/" + fileName;
					reviewDAO.insertReviewPhoto(reviewId, photoUrl);
				}
			}
		}
	}

	//리뷰게시판 삭제하기
	@Override
	public void deleteReview(Long reviewId, String uploadDir) throws Exception {
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
}