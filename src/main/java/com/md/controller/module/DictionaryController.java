package com.md.controller.module;

import com.md.constants.module.DictionaryConstant;
import com.md.domain.module.Dictionary;
import com.md.service.module.DictionaryService;
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
 * @author 马振
 */
@Controller
@RequestMapping(value="/dictionary")
public class DictionaryController {
    @Autowired
    private DictionaryService dictionaryService;

    /**
     * 获取字典类型信息数据
     * @param modelMap
     * @param dictionary
     * @return
     * @throws CrudException
     */
    @RequestMapping(value="/findDictTypeInfo")
    public ModelAndView findDictTypeInfo(ModelMap modelMap, Dictionary dictionary, String data) throws CrudException {
        DynamicDataSource.setDataSource(DataSourceInstances.IMS);
        modelMap.put("listDictType", dictionaryService.findDictTypeInfo(dictionary));
        modelMap.put("dictionary", dictionary);
        return new ModelAndView(DictionaryConstant.LISTDICTTYPE, modelMap);
    }

    /**
     * 跳转到新增页面
     * @param modelMap
     * @return
     * @throws CrudException
     */
    @RequestMapping(value="/addDictType")
    public ModelAndView addDictType(ModelMap modelMap) throws CrudException {
        DynamicDataSource.setDataSource(DataSourceInstances.IMS);
        return new ModelAndView(DictionaryConstant.ADDDICTTYPE, modelMap);
    }

    /**
     * 新增或修改数据字典类型
     * @param dictionary
     * @return
     * @throws Exception
     */
    @RequestMapping(value="saveDictType")
    @ResponseBody
    public String saveModule(Dictionary dictionary) throws Exception {
        DynamicDataSource.setDataSource(DataSourceInstances.IMS);
        return dictionaryService.saveDictType(dictionary);
    }
}
