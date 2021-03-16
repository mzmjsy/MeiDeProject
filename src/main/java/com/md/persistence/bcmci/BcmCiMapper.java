package com.md.persistence.bcmci;

import com.md.domain.bcmci.BcmCi;

import java.util.List;

/**
 * @author mz
 */
public interface BcmCiMapper {
    /**
     * 根据交货日期查询各生产厂家的理论净重
     * @param bcmCi
     * @return
     */
    public List<BcmCi> getWeightByDate(BcmCi bcmCi);
}
