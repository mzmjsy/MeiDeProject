package com.md.persistence.module;

import com.md.domain.module.Dictionary;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author mz
 */
public interface DictionaryMapper {
    /**
     * 获取字典类型数据
     * @param dictionary
     * @return
     */
    public List<Dictionary> findDictTypeInfo(Dictionary dictionary);

    /**
     * 保存字典类型数据
     * @param dictionary
     */
    public void saveDictType(Dictionary dictionary);

    /**
     * 修改字段类型数据
     * @param dictionary
     */
    public void updateDictType(Dictionary dictionary);

    /**
     * 删除字段类型数据
     * @param list
     */
    public void deleteDictType(@Param(value="list")List<Dictionary> list);
}
