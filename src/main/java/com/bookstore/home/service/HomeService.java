package com.bookstore.home.service;


import com.bookstore.admin.domain.BookDto;
import com.bookstore.home.domain.ReviewDto;
import com.bookstore.home.mapper.HomeMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class HomeService {


    private final HomeMapper homeMapper;


    public List<BookDto> searchBookListGrade() {
        return homeMapper.searchBookListGrade();
    }

    public List<BookDto> searchBookListBest() {
        return homeMapper.searchBookListBest();
    }

    public List<BookDto> searchBookListNew() {
        return homeMapper.searchBookListNew();
    }

    public BookDto bookSearchDetail(int bookNum) {
        return homeMapper.bookSearchDetail(bookNum);
    }

    public List<ReviewDto> searchBookReview(Map map) {
        return homeMapper.searchBookReview(map);
    }

    // 도서 리뷰 삭제
    public int deleteReview(int reviewNum) {
        return homeMapper.deleteReview(reviewNum);
    }

    // 도서 리뷰 수정
    public int updateReview(ReviewDto reviewDto) {

        Map<String, Object> reviewSumAndCount = homeMapper.reviewSumAndCount(reviewDto);

        float sum = Float.parseFloat(String.valueOf(reviewSumAndCount.get("sum")));
        int count = Integer.parseInt(String.valueOf(reviewSumAndCount.get("count")));

        double bookGradeAverage = sum / count;


        homeMapper.updateBookGrade(reviewDto.getBookNum(), bookGradeAverage);

        return homeMapper.updateReview(reviewDto);
    }


    /**
     *
     * @return
     */
    public int countReview() {
        return homeMapper.countReview();
    }


    /**
     * 도서 리뷰 등록
     * @param reviewDto 등록할 리뷰 정보
     * @return 등록 성공 여부 정보
     */
    public int enrollReview(ReviewDto reviewDto) {

        if (homeMapper.purchaseConfirm(reviewDto) != 1) {
            return 2; // 2 -> "구매 후 리뷰 등록이 가능합니다."
        } else if (homeMapper.reviewDuplicateConfirm(reviewDto) != 0) {
            return 3; // 3 -> "구매 후 리뷰는 한번만 등록 가능합니다."
        }

        return homeMapper.enrollReview(reviewDto);
    }




}
