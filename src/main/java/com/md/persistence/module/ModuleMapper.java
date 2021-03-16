package com.md.persistence.module;

import com.md.domain.module.Module;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author mz
 */
public interface ModuleMapper {

    /**
     * 根据级别获取数据
     * @param level
     * @return
     */
    public List<Module> getModuleInfoByLevel(@Param("level")int level);

    /**
     * 获取所有数据
     * @param module
     * @return
     */
    public List<Module> getAllModuleInfo(Module module);

    /**
     * 获取id最大值 + 1
     * @return
     */
    public int getMaxId();

    /**
     * 保存
     * @param module
     */
    public void saveModuleInfo(Module module);

    /**
     * 修改
     * @param module
     */
    public void updateModuleInfo(Module module);

    /**
     * 删除
     * @param module
     */
    public void deleteModuleInfo(Module module);
}
