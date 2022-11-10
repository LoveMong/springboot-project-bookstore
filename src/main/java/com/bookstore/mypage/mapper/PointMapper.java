package com.bookstore.mypage.mapper;


import com.bookstore.common.utils.SearchCondition;
import com.bookstore.mypage.domain.PointDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PointMapper {

    // 지정된 조건 기준 포인트 리스트 개수 조회
    int searchPointResultCnt(SearchCondition sc);

    // 지정된 조건 기준 포인트 리스트 조회
    List<PointDto> searchPointList(SearchCondition sc);

    // 포인트 충전
    void chargePoint(PointDto pointDto);

    // 고객 포인트 정보 수정
    void updateMemberPoint(PointDto pointDto);

}
