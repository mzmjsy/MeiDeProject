package com.md.controller.bcmci;

import com.alibaba.fastjson.JSONArray;
import com.md.constants.bcmci.BcmCiConstant;
import com.md.domain.bcmci.BcmCi;
import com.md.service.bcmci.BcmCiService;
import com.md.util.CrudException;
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
@RequestMapping(value="/bcmCi")
public class BcmCiController {
    @Autowired
    private BcmCiService bcmCiService;

    /**
     * 跳转数据大屏
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value="showPic")
    public ModelAndView showPic(ModelMap modelMap) throws Exception {
        DynamicDataSource.setDataSource(DataSourceInstances.ERP);
        /*modelMap.put("netWeightList", bcmCiService.getWeightByDate(new BcmCi()));*/
        modelMap.put("netWeightList", new JSONArray());
        return new ModelAndView(BcmCiConstant.SHOWPIC, modelMap);
    }

    /**
     * 获取重量
     * @return
     * @throws CrudException
     */
    @RequestMapping(value="getWeightData")
    @ResponseBody
    public JSONArray getWeightData() throws CrudException {
        DynamicDataSource.setDataSource(DataSourceInstances.ERP);
        return bcmCiService.getWeightByDate(new BcmCi());
    }

    /**
     * 跳转世界地图
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value="showWorldMap")
    public ModelAndView showWorldMap(ModelMap modelMap) throws Exception {
        DynamicDataSource.setDataSource(DataSourceInstances.ERP);
        return new ModelAndView(BcmCiConstant.SHOWWORLDMAP, modelMap);
    }
}
