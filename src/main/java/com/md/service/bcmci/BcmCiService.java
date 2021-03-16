package com.md.service.bcmci;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.md.domain.bcmci.BcmCi;
import com.md.persistence.bcmci.BcmCiMapper;
import com.md.util.CrudException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author mz
 */
@Service
public class BcmCiService {
    @Autowired
    private BcmCiMapper bcmCiMapper;

    /**
     * 根据交货日期查询各材质分类的理论净重并转为JSONArray
     * @param bcmCi
     * @return
     * @throws CrudException
     */
    public JSONArray getWeightByDate(BcmCi bcmCi) throws CrudException {
        try {
            List<BcmCi> listWeight = bcmCiMapper.getWeightByDate(bcmCi);
            return JSONArray.parseArray(JSONObject.toJSONString(listWeight));
        } catch (Exception e) {
            e.printStackTrace();
            throw new CrudException(e);
        }
    }
}
