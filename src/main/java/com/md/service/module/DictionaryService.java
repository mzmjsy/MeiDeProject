package com.md.service.module;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.md.domain.common.Common;
import com.md.domain.module.Dictionary;
import com.md.persistence.common.CommonMapper;
import com.md.persistence.module.DictionaryMapper;
import com.md.util.CrudException;
import com.md.util.StaticDataConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 马振
 */
@Service
public class DictionaryService {
    @Autowired
    private DictionaryMapper dictionaryMapper;
    @Autowired
    private CommonMapper commonMapper;

    /**
     * 获取所有字典类型数据
     * @param dictionary
     * @return
     * @throws CrudException
     */
    public JSONArray findDictTypeInfo(Dictionary dictionary) throws CrudException {
        try {
            JSONArray jsonArray = new JSONArray();
            List<Dictionary> listDictType = dictionaryMapper.findDictTypeInfo(dictionary);

            if (!listDictType.isEmpty() && listDictType.size() > 0) {
                jsonArray = JSON.parseArray(JSON.toJSONString(listDictType));
            }

            return jsonArray;
        } catch (Exception e) {
            e.printStackTrace();
            throw new CrudException(e);
        }
    }

    /**
     * 新增或修改数据字段类型
     * @param dictionary
     * @throws CrudException
     */
    public String saveDictType(Dictionary dictionary) throws CrudException {
        String flag = StaticDataConstant.SUCCESS;
        try {
            Common common = new Common();
            common.setData("EOS_DICT_TYPE", "DICT_TYPE_ID", dictionary.getDictTypeId());
            String event = dictionary.getFlag();

            if (StaticDataConstant.ADD.equals(event)) {
                //若查到的数据为0，说明库中没有，则新增
                if (0 == commonMapper.getCountById(common)) {
                    dictionaryMapper.saveDictType(dictionary);
                } else {
                    flag = StaticDataConstant.ONE;
                }
            } else if (StaticDataConstant.EDIT.equals(event)) {
                dictionaryMapper.updateDictType(dictionary);
            } else if (StaticDataConstant.DELETE.equals(event)) {
                List<Dictionary> list = new ArrayList<Dictionary>();
                list.add(dictionary);
                dictionaryMapper.deleteDictType(list);
            } else if (StaticDataConstant.BULK_DEL.equals(event)) {
                String content = dictionary.getContent();
                if (null != content) {
                    List<Dictionary> list = JSONArray.parseArray(content).toJavaList(Dictionary.class);
                    dictionaryMapper.deleteDictType(list);
                }
            }
        } catch (Exception e) {
            flag = StaticDataConstant.ERROR;
            e.printStackTrace();
            throw new CrudException(e);
        }

        return flag;
    }
}
