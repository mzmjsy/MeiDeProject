package com.md.persistence.common;

import com.md.domain.common.Common;

/**
 * @author mz
 */
public interface CommonMapper {
    /**
     * 根据id获取该id的信息数量
     * @param common
     * @return
     */
    public int getCountById(Common common);
}
