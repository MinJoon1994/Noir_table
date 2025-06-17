package com.noir.review.vo;

import java.sql.Date;
import java.util.List;

public class ReviewVO {

	private Long reviewId;
	private String title;
	private String content;
	private int rating;
	private int reservationId;
	private List<String> photoUrls; // 멀티 이미지 지원

	// 예약 정보
    private Date reservationDate;
    private String mealType;
	

	public Long getReviewId() {
		return reviewId;
	}
	public void setReviewId(Long reviewId) {
		this.reviewId = reviewId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public int getReservationId() {
		return reservationId;
	}
	public void setReservationId(int reservationId) {
		this.reservationId = reservationId;
	}
	public List<String> getPhotoUrls()
	{ 
		return photoUrls;
	}
    public void setPhotoUrls(List<String> photoUrls)
    {
    	this.photoUrls = photoUrls;
    }

    public Date getReservationDate() {
		return reservationDate;
	}
	public void setReservationDate(Date reservationDate) {
		this.reservationDate = reservationDate;
	}
	public String getMealType() {
		return mealType;
	}
	public void setMealType(String mealType) {
		this.mealType = mealType;
	}
    @Override
    public String toString() {
        return "ReviewVO{" +
                "reviewId=" + reviewId +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", rating=" + rating +
                ", reservationId=" + reservationId +
                ", reservationDate=" + reservationDate +
                ", mealType='" + mealType + '\'' +
                ", photoUrls=" + photoUrls +
                '}';
    }
	
}
