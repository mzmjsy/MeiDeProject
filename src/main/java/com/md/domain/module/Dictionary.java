package com.md.domain.module;

import com.alibaba.fastjson.JSONArray;

/**
 * @author mz
 */
public class Dictionary {
    private String id;
    private String dictTypeId;
    private String dictTypeName;
    private String flag;
    private String content;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDictTypeId() {
        return dictTypeId;
    }

    public void setDictTypeId(String dictTypeId) {
        this.dictTypeId = dictTypeId;
    }

    public String getDictTypeName() {
        return dictTypeName;
    }

    public void setDictTypeName(String dictTypeName) {
        this.dictTypeName = dictTypeName;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setData(String dictTypeId, String dictTypeName) {
        this.dictTypeId = dictTypeId;
        this.dictTypeName = dictTypeName;
    }
}
