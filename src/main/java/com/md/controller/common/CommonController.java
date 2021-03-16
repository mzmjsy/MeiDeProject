package com.md.controller.common;

import com.md.constants.common.CommonConstant;
import com.md.util.DataSourceInstances;
import com.md.util.DynamicDataSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author 马振
 */
@Controller
@RequestMapping(value="/common")
public class CommonController {

    /**
     * 跳转到公共编辑页
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/edit")
    public ModelAndView editModule(ModelMap modelMap) throws Exception {
        DynamicDataSource.setDataSource(DataSourceInstances.IMS);
        return new ModelAndView(CommonConstant.EDIT, modelMap);
    }
}
