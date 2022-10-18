package com.bookstore.admin.mapper;

import com.bookstore.admin.domain.BookDto;
import com.bookstore.common.utils.SearchCondition;
import com.bookstore.member.domain.MemberDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface AdminMapper {

    // 도서 등록
    int enrollBook(BookDto bookDto);

    // 도서 리스트 개수 확인
    int countBookList();

    // 도서 상세 정보 출력
    BookDto searchBookDetailByBookNum(int bookNum);

    // 검색된 조건에 해당하는 도서 리스트
    List<BookDto> bookList(Map<String, Integer> map);

    // 검색된 조건에 해당하는 도서 개수
    int searchBookResultCnt(SearchCondition sc);

    // 검색된 조건에 해당하는 도서 객체 리스트
    List<BookDto> searchBookSelectPage(SearchCondition sc);

    // 도서 수정
    void bookUpdate(BookDto bookDto);

    // 도서 삭제
    int bookRemove(int bookNum);

    // 검색된 조건에 해당하는 회원 수
    int searchMemberResultCnt(SearchCondition sc);

    // 검색된 조건에 해당하는 회원 객체 리스트
    List<MemberDto> searchMemberSelectPage(SearchCondition sc);

}
