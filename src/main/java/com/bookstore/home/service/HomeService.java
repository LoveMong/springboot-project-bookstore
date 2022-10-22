package com.bookstore.home.service;


import com.bookstore.admin.domain.BookDto;
import com.bookstore.home.domain.ReviewDto;
import com.bookstore.home.mapper.HomeMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
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
        return homeMapper.updateReview(reviewDto);
    }

    public int countReview() {
        return homeMapper.countReview();
    }






}
