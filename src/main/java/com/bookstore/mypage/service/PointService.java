package com.bookstore.mypage.service;

import com.bookstore.common.utils.SearchCondition;
import com.bookstore.mypage.domain.PointDto;
import com.bookstore.mypage.mapper.PointMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class PointService {

    private final PointMapper pointMapper;

    public int searchPointResultCnt(SearchCondition sc) {
        return pointMapper.searchPointResultCnt(sc);
    }

    public List<PointDto> searchPointList(SearchCondition sc) {
        return pointMapper.searchPointList(sc);
    }

    @Transactional(rollbackFor = Exception.class)
    public void chargePoint(PointDto pointDto) throws Exception {

        try {
            pointMapper.chargePoint(pointDto);
            pointMapper.updateMemberPoint(pointDto);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("ChargePoint_ERR");
        }

    }


}
