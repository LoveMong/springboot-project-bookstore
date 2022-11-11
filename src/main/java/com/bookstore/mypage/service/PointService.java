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

    /**
     * 지정된 조건기준 포인트 내역 개수 조회
     * @param sc 조회 조건
     * @return 개수
     */
    public int searchPointResultCnt(SearchCondition sc) {
        return pointMapper.searchPointResultCnt(sc);
    }

    /**
     * 지정된 조건기준 포인트 내역 조회
     * @param sc 조회 조건
     * @return 포인트 내역 리스트
     */
    public List<PointDto> searchPointList(SearchCondition sc) {
        return pointMapper.searchPointList(sc);
    }

    /**
     * 포인트 충전 진행
     * @param pointDto 충전할 포인트 정보
     */
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
