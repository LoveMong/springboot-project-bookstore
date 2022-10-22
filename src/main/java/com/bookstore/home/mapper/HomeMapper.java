package com.bookstore.home.mapper;

import com.bookstore.admin.domain.BookDto;
import com.bookstore.home.domain.ReviewDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface HomeMapper {

    List<BookDto> searchBookListGrade();

    List<BookDto> searchBookListBest();

    List<BookDto> searchBookListNew();

    BookDto bookSearchDetail(int bookNum);

    List<ReviewDto> searchBookReview(Map map);

    int deleteReview(int reviewNum);

    int updateReview(ReviewDto reviewDto);

    int countReview();

}
