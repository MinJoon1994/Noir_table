package com.noir.review.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.noir.review.vo.ReviewVO;

@Repository
public class ReviewDAOImpl implements ReviewDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ReviewVO> selectReviewsByPaging(int offset, int limit) throws Exception {
	    Map<String, Object> param = new HashMap<>();
	    param.put("offset", offset);
	    param.put("limit", limit);
	    return sqlSession.selectList("mapper.review.selectReviewsByPaging", param);
	}

	@Override
	public int selectReviewCount() throws Exception {
	    return sqlSession.selectOne("mapper.review.selectReviewCount");
	}

	@Override
	public ReviewVO selectReviewById(Long reviewId) throws Exception {
		return sqlSession.selectOne("mapper.review.selectReviewById", reviewId);
	}
	//이전글
	@Override
	public ReviewVO selectPrevReview(Long reviewId) throws Exception {
	    return sqlSession.selectOne("mapper.review.selectPrevReview", reviewId);
	}
	//다음글
	@Override
	public ReviewVO selectNextReview(Long reviewId) throws Exception {
	    return sqlSession.selectOne("mapper.review.selectNextReview", reviewId);
	}

	@Override
	public void insertReview(ReviewVO review) throws Exception {
		sqlSession.insert("mapper.review.insertReview", review);
	}

	@Override
	public void updateReview(ReviewVO review) throws Exception {
		sqlSession.update("mapper.review.updateReview", review);
	}

	@Override
	public void deleteReview(Long reviewId) throws Exception {
		sqlSession.delete("mapper.review.deleteReview", reviewId);
	}

	@Override
	public List<String> selectReviewPhotos(Long reviewId) throws Exception {
		return sqlSession.selectList("mapper.review.selectReviewPhotos", reviewId);
	}

	@Override
	public void insertReviewPhoto(Long reviewId, String photoUrl) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("reviewId", reviewId);
		param.put("photoUrl", photoUrl);
		sqlSession.insert("mapper.review.insertReviewPhoto", param);
	}

	@Override
	public void deleteReviewPhotos(Long reviewId) throws Exception {
		sqlSession.delete("mapper.review.deleteReviewPhotos", reviewId);
	}

}	