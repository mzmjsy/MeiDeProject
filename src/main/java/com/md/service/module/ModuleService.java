package com.md.service.module;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.md.domain.module.Module;
import com.md.persistence.module.ModuleMapper;
import com.md.util.StaticDataConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author mz
 */
@Service
public class ModuleService {
    @Autowired
    private ModuleMapper moduleMapper;

    /**
     * 组合数据
     * @return
     * @throws Exception
     */
    public JSONArray getAllModuleInfo() throws Exception {
        try {
            JSONObject jsonObject = new JSONObject();
            JSONArray jsonArray = new JSONArray();
            JSONArray jsonArray1 = new JSONArray();

            //一级节点
            List<Module> listModule1 = moduleMapper.getModuleInfoByLevel(1);

            //二级节点
            List<Module> listModule2 = moduleMapper.getModuleInfoByLevel(2);

            //三级节点
            List<Module> listModule3 = moduleMapper.getModuleInfoByLevel(3);

            //组合二级、三级节点
            JSONArray jsonArray2 = convertData(listModule2, listModule3);

            //组合一节、二级节点
            for (Module m :listModule1) {
                jsonArray = new JSONArray();
                jsonObject = classToJson(m);

                for (int i = 0; i < jsonArray2.size(); i++) {
                    if (m.getVcode().equals(jsonArray2.getJSONObject(i).getString("parentCode"))) {
                        jsonArray.add(jsonArray2.getJSONObject(i));
                    }
                }

                jsonObject.put("children", jsonArray);
                jsonArray1.add(jsonObject);
            }

            return jsonArray1;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * 校验编码是否存在
     * @param module
     * @return
     * @throws Exception
     */
    public Module getModuleByCode(Module module) throws Exception {
        Module m = new Module();
        try {
            List<Module> listModule = moduleMapper.getAllModuleInfo(module);

            if (!listModule.isEmpty() && listModule.size() > 0) {
                m = listModule.get(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return m;
    }

    /**
     * 保存节点信息
     * @param module
     * @throws Exception
     */
    public String editModuleInfo(Module module) throws Exception {
        String flag = StaticDataConstant.SUCCESS;
        try {
            String event = module.getFlag();
            if (StaticDataConstant.ADD.equals(event)) {
                //判断编码是否重复，是则返回1
                if (0 == moduleMapper.getAllModuleInfo(module).size()) {
                    module.setNid(String.valueOf(moduleMapper.getMaxId()));

                    moduleMapper.saveModuleInfo(module);
                } else {
                    flag = StaticDataConstant.ONE;
                }
            } else if (StaticDataConstant.EDIT.equals(event)) {
                moduleMapper.updateModuleInfo(module);
            } else if (StaticDataConstant.DELETE.equals(event)) {
                moduleMapper.deleteModuleInfo(module);
            }
        } catch (Exception e) {
            flag = StaticDataConstant.ERROR;
            e.printStackTrace();
        }

        return flag;
    }

    /**
     * 组合二级节点及三级节点数据
     * @param listModuleParent  二级节点数据
     * @param listModuleChild   三级节点数据
     * @return
     * @throws Exception
     */
    public JSONArray convertData(List<Module> listModuleParent, List<Module> listModuleChild) {
        JSONArray jsonArray = new JSONArray();
        JSONArray childArray = new JSONArray();
        for (Module module : listModuleParent) {
            childArray = new JSONArray();
            JSONObject jsonObject = classToJson(module);

            for (Module m : listModuleChild) {
                if (module.getVcode().equals(m.getVparentcode())) {
                    JSONObject obj = classToJson(m);

                    childArray.add(obj);
                }
            }

            jsonObject.put("children", childArray);
            jsonArray.add(jsonObject);
        }

        return jsonArray;
    }

    /**
     * 将Module实体类转为JSON
     * @param module    module实体
     * @return
     */
    public JSONObject classToJson(Module module) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", module.getNid());
        jsonObject.put("code", module.getVcode());
        jsonObject.put("url", module.getVurl());
        jsonObject.put("level", module.getNlevel());
        jsonObject.put("parentCode", module.getVparentcode());
        jsonObject.put("createTime", module.getCreateTime());
        jsonObject.put("title", module.getVtitle());

        return jsonObject;
    }
}
