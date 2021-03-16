package com.md.util;

import org.apache.axis.utils.ClassUtils;
import org.apache.poi.util.SystemOutLogger;

import java.util.UUID;

/**
 * @author mz
 * 公共类
 */
public class CommonData {
    /**
     * 获取UUID
     * @return
     */
    public static String getUUID() {
        String uuid = UUID.randomUUID().toString();

        return uuid.replace("-", "");
    }

    /**
     * 获取当前路径
     * @return
     */
    public static String getPath() {
        String filePath = ClassUtils.getDefaultClassLoader().getResource("").getPath();

        return filePath;
    }

    public static void main(String[] args) {
        System.out.println(getPath());
    }
}
