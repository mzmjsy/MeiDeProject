package com.md.domain.module;

import java.util.Date;
import java.util.List;

/**
 * @author mz
 */
public class Module {
    private String nid;
    private String vcode;
    private Integer nlevel;
    private String vtitle;
    private String vurl;
    private String vparentcode;
    private String nsort;
    private Date createTime;
    private List<Module> moduleList;
    /**
     * 按钮事件标志：add——新增，edit——修改，delete——删除
     */
    private String flag;

    public String getNid() {
        return nid;
    }

    public void setNid(String nid) {
        this.nid = nid;
    }

    public String getVcode() {
        return vcode;
    }

    public void setVcode(String vcode) {
        this.vcode = vcode;
    }

    public Integer getNlevel() {
        return nlevel;
    }

    public void setNlevel(Integer nlevel) {
        this.nlevel = nlevel;
    }

    public String getVtitle() {
        return vtitle;
    }

    public void setVtitle(String vtitle) {
        this.vtitle = vtitle;
    }

    public String getVurl() {
        return vurl;
    }

    public void setVurl(String vurl) {
        this.vurl = vurl;
    }

    public String getVparentcode() {
        return vparentcode;
    }

    public void setVparentcode(String vparentcode) {
        this.vparentcode = vparentcode;
    }

    public String getNsort() {
        return nsort;
    }

    public void setNsort(String nsort) {
        this.nsort = nsort;
    }

    public List<Module> getModuleList() {
        return moduleList;
    }

    public void setModuleList(List<Module> moduleList) {
        this.moduleList = moduleList;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }
}
