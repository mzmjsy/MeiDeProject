package com.md.controller.module;

import com.md.constants.module.ModuleConstant;
import com.md.domain.module.Module;
import com.md.service.module.ModuleService;
import com.md.service.system.LoginService;
import com.md.util.DataSourceInstances;
import com.md.util.DynamicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author mz
 */
@Controller
@RequestMapping(value="/module")
public class ModuleController {
    @Autowired
    private ModuleService moduleService;
    @Autowired
    private LoginService loginService;

    /**
     * 展示所有节点
     * @author mz
     * @return
     */
    @RequestMapping(value="/moduleInfo")
    public ModelAndView getModuleInfo(ModelMap modelMap) throws Exception {
        DynamicDataSource.setDataSource(DataSourceInstances.IMS);

        modelMap.put("moduleInfo", moduleService.getAllModuleInfo());
        return new ModelAndView(ModuleConstant.MODULELIST, modelMap);
    }

    /**
     * 跳转到节点新增页面
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/moduleEdit")
    public ModelAndView editModule(ModelMap modelMap) throws Exception {
        DynamicDataSource.setDataSource(DataSourceInstances.IMS);
        return new ModelAndView(ModuleConstant.MODULEEDIT, modelMap);
    }

    /**
     * 保存新增或修改的数据
     * @param module
     * @return
     * @throws Exception
     */
    @RequestMapping(value="saveModuleInfo")
    @ResponseBody
    public String saveModuleInfo(Module module) throws Exception {
        DynamicDataSource.setDataSource(DataSourceInstances.IMS);
        return moduleService.editModuleInfo(module);
    }
}
