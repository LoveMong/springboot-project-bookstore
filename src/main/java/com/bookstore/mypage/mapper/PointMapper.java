package com.bookstore.mypage.mapper;


import com.bookstore.common.utils.SearchCondition;
import com.bookstore.mypage.domain.PointDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PointMapper {

    int searchPointResultCnt(SearchCondition sc);

    List<PointDto> searchPointList(SearchCondition sc);

    void chargePoint(PointDto pointDto);

    void updateMemberPoint(PointDto pointDto);

}
