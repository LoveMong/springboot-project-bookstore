package com.bookstore.home.service;


import com.bookstore.admin.domain.BookDto;
import com.bookstore.common.utils.SearchCondition;
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


    /**
     * 인기 도서 리스트 출력(도서 평균 평점 높은순)
     * @return 인기 도서 리스트
     */
    public List<BookDto> searchBookListGrade() {
        return homeMapper.searchBookListGrade();
    }


    /**
     * 베스트셀러 도서 리스트 출력(도서 판매량순)
     * @return 베스트셀러 도서 리스트
     */
    public List<BookDto> searchBookListBest() {
        return homeMapper.searchBookListBest();
    }


    /**
     * 신간 도서 리스트 출력(도서 최근 등록순)
     * @return 신간 도서 리스트
     */
    public List<BookDto> searchBookListNew() {
        return homeMapper.searchBookListNew();
    }


    /**
     * 도서 상세 페이지 출력
     * @param bookNum 해당 도서 번호
     * @return 해당 도서 정보
     */
    public BookDto bookSearchDetail(int bookNum) {
        return homeMapper.bookSearchDetail(bookNum);
    }


    /**
     * 도서 리뷰 리스트 출력(페이징 처리)
     * @param map 페이징 조건(시작 페이지, 한 페이지에 출력할 리뷰 개수)
     * @return (조건 처리된)도서 리뷰 리스트
     */
    public List<ReviewDto> searchBookReview(Map map) {
        return homeMapper.searchBookReview(map);
    }


    /**
     * 도서 리뷰 삭제
     * @param reviewDto 해당 리뷰 정보
     * @return 삭제된 도서 개수(성공 시 -> 1 반환)
     */
    public int deleteReview(ReviewDto reviewDto) {

        int result = homeMapper.deleteReview(reviewDto.getReviewNum());

        if (result != 1) {
            return 0;
        } else {
            homeMapper.updateBookGrade(reviewDto.getBookNum(), bookGradeAverage(reviewDto)); // 새로운 평균 점수 반영
        }

        return result;
    }


    /**
     * 도서 리뷰 수정
     * @param reviewDto 수정할 리뷰 내용
     * @return 수정된 리뷰 개수(성공 시 -> 1 반환)
     */
    public int updateReview(ReviewDto reviewDto) {

        int result = homeMapper.updateReview(reviewDto);

        if (result != 1) {
            return 0;
        } else {
            homeMapper.updateBookGrade(reviewDto.getBookNum(), bookGradeAverage(reviewDto)); // 새로운 평균 점수 반영
        }

        return result;
    }


    /**
     * 리뷰 전체 개수 확인
     * @return 리뷰 전체 개수
     */
    public int countReview(int bookNum) {
        return homeMapper.countReview(bookNum);
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

        int result = homeMapper.enrollReview(reviewDto);

        if (result == 1) {
            homeMapper.updateBookGrade(reviewDto.getBookNum(), bookGradeAverage(reviewDto)); // 새로운 평균 점수 반영
        } else {
            result = 0;
        }

        return result;
    }


    /**
     * 검색 조건에 해당하는 도서 개수
     * @param sc 검색 조건
     * @return 검색된 도서 개수
     */
    public int searchBookListResultCnt(SearchCondition sc) {
        return homeMapper.searchBookListResultCnt(sc);
    }


    /**
     * 검색 조건에 해당하는 도서 리스트
     * @param sc 검색 조건
     * @return 검색된 도서 리스트
     */
    public List<BookDto> searchBookList(SearchCondition sc) {
        return homeMapper.searchBookList(sc);
    }


    /**
     * 도서 검색(베스트, 신간, 인기 도서)
     * @param sc 검색 조건
     * @return 검색 도서
     */
    public List<BookDto> searchBookListSelect(SearchCondition sc) throws Exception {

        String option = sc.getSelectOption();

        switch (option) {
            case "BEST":
                return homeMapper.searchBookListBest();
            case "NEW":
                return homeMapper.searchBookListNew();
            case "GRADE":
                return homeMapper.searchBookListGrade();
            default:
                throw new Exception("SEARCH_ERR");
        }

    }


    /**
     * 도서 평균평점 계산
     * @param reviewDto 도서번호, 도서평점 등 리뷰 정보
     * @return 도서 평균 평점
     */
    private double bookGradeAverage(ReviewDto reviewDto) {

        Map<String, Object> reviewSumAndCount = homeMapper.reviewSumAndCount(reviewDto); // 도서 평균 평점을 구하기 위한 Sum/Count

        double sum;

        if (reviewSumAndCount.get("sum") == null) {
            return 0;
        } else {
            sum = Float.parseFloat(String.valueOf(reviewSumAndCount.get("sum"))); // 해당 도서 평점의 합
        }

        int count = Integer.parseInt(String.valueOf(reviewSumAndCount.get("count"))); // 해당 도서 평점의 전체 개수

        return sum / count;

    }

}
