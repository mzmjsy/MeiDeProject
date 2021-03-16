package com.md.util;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import java.util.*;

public class RegionUtil {
    /**
     * 各地区xml文件路径
     */
    private static final String LOCAL_LIST_PATH = CommonData.getPath() + "/config/LocList.xml";

    /**
     * 所有国家名称List
     */
    private static final List<Map<String, String>> COUNTRY_REGION = new ArrayList<Map<String, String>>();
    private static RegionUtil localutil;
    private SAXReader reader;
    private Document document;

    /**
     * 根元素
     */
    private Element rootElement;

    /**
     * 初始化
     */
    private RegionUtil() {
        //1.读取
        reader = new SAXReader();
        try {
            document = reader.read(LOCAL_LIST_PATH);
        } catch (DocumentException e) {
            e.printStackTrace();
        }
        //2.获得根元素
        rootElement = document.getRootElement();
        //3.初始化所有国家名称列表
        Iterator it = rootElement.elementIterator();
        Element ele = null;
        Map<String, String> map = null;
        while (it.hasNext()) {
            ele = (Element)it.next();
            map = new HashMap<String, String>();
            map.put("code", ele.attributeValue("Code"));
            map.put("name", ele.attributeValue("Name"));
            COUNTRY_REGION.add(map);
        }
    }

    /**
     * @author		mz
     * @TODO		功能：	获取所有国家名称
     * @time		2020-1-2 上午9:02:05
     * @return		List<String>
     */
    public List<Map<String, String>> getCountry() {
        return COUNTRY_REGION;
    }

    /**
     * @author  mz
     * @TODO    功能：根据国家名获取该国所有省份
     * @time    2020-1-2 上午9:07:21
     * @param   countryName	国家名
     * @return  List<Element>
     */
    private List<Element> provinces(String countryName){
        Iterator it = rootElement.elementIterator();
        List<Element> provinces = new ArrayList<Element>();
        Element ele = null;
        while (it.hasNext()) {
            ele = (Element)it.next();
            if (ele.attributeValue("Name").equals(countryName)) {
                provinces = ele.elements();
                break;
            }
        }
        return provinces;
    }

    /**
     * @author  mz
     * @TODO    功能：根据国家名获取该国所有省份
     * @time    2020-1-1 上午9:07:21
     * @param   countryName	国家名，从getCountry()从取出
     * @return  List<String>
     */
    public List<Map<String, String>> getProvinces(String countryName){
        List<Element> tmp = this.provinces(countryName);
        List<Map<String, String>> list = new ArrayList<Map<String, String>>();
        Map<String, String> map = null;
        for (int i = 0; i < tmp.size(); i++) {
            map = new HashMap<String, String>(1000);
            map.put("code", tmp.get(i).attributeValue("Code"));
            map.put("name", tmp.get(i).attributeValue("Name"));
            list.add(map);
        }
        return list;
    }

    /**
     *
     * @author  mz
     * @TODO    功能：根据国家名和省份名，获取该省城市名列表
     * @time    2020-1-2 上午9:15:24
     * @param   countryName     国家名
     * @param   provinceName    省份名称
     * @return
     */
    private List<Element> cities(String countryName, String provinceName){
        List<Element> provinces =  this.provinces(countryName);
        List<Element> cities = new ArrayList<Element>();
        //没有这个城市
        if (provinces == null || provinces.size() == 0){
            return cities;
        }

        for (int i = 0; i < provinces.size(); i++) {
            if (provinces.get(i).attributeValue("Name").equals(provinceName)) {
                cities = provinces.get(i).elements();
                break;
            }
        }
        return cities;
    }

    /**
     *
     * @author  mz
     * @TODO    功能：根据国家名和省份名获取城市列表
     * @time    2020-1-1 下午4:55:55
     * @param   countryName     国家名称
     * @param   provinceName    省份名称
     * @return  List<String>
     */
    public List<String> getCities(String countryName, String provinceName){
        List<Element> tmp =  this.cities(countryName, provinceName);
        List<String> cities = new ArrayList<String>();
        for (int i = 0; i < tmp.size(); i++) {
            cities.add(tmp.get(i).attributeValue("Name"));
        }
        return cities;
    }

    public static RegionUtil getInstance(){
        if (localutil == null) {
            localutil = new RegionUtil();
        }
        return localutil;
    }

    public static void main(String[] args) {
        RegionUtil lu = RegionUtil.getInstance();
        List<Map<String, String>> list = lu.getProvinces("中国");
        for(int i=0; i<list.size(); i++){
            System.out.print(list.get(i) + " ");
        }
    }
}
