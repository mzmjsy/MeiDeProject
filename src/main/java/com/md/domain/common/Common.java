package com.md.domain.common;

/**
 * @author mz
 */
public class Common {
    private String table;
    private String column;
    private String param;

    public String getTable() {
        return table;
    }

    public void setTable(String table) {
        this.table = table;
    }

    public String getColumn() {
        return column;
    }

    public void setColumn(String column) {
        this.column = column;
    }

    public String getParam() {
        return param;
    }

    public void setParam(String param) {
        this.param = param;
    }

    /**
     * 赋值
     */
    public void setData(String table, String column, String param){
        this.table = table;
        this.column = column.replace("_", "");
        this.param = param;
    }
}
