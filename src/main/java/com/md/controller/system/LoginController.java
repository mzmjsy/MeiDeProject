package com.md.controller.system;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.md.constants.system.LoginConstant;
import com.md.domain.system.Account;
import com.md.service.system.LoginService;
import com.md.util.DataSourceInstances;
import com.md.util.DynamicDataSource;
import com.md.util.StaticDataConstant;
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
@RequestMapping(value="/login")
public class LoginController {
    @Autowired
    private LoginService loginService;

    /**
     * 登录
     * @param modelMap
     * @param account
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/loginIn")
    public ModelAndView loginIn(ModelMap modelMap, Account account) throws Exception {
        DynamicDataSource.setDataSource(DataSourceInstances.IMS);

        String url = LoginConstant.MAIN;
        //验证用户名及密码是否正确
        String validateLogin = loginService.validateLogin(account);

        if (!StaticDataConstant.TRUE.equals(validateLogin)) {
            url = LoginConstant.LOGIN;
            modelMap.put("info", validateLogin);
        }

        modelMap.put("user", loginService.getAccount(account));

        modelMap.put("listModule", loginService.getAllModuleInfo());

        return new ModelAndView(url, modelMap);
    }

    /**
     * 跳转到注册页面
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/register")
    public ModelAndView register(ModelMap modelMap) throws Exception {
        return new ModelAndView(LoginConstant.REGISTER, modelMap);
    }

    /**
     * 保存注册的账号信息
     * @param data
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/saveAccount")
    @ResponseBody
    public String saveAccount(String data) throws Exception {
        Account account = JSON.toJavaObject(JSONObject.parseObject(data), Account.class);
        String result = loginService.checkAccountByName(account);
        if (StaticDataConstant.SUCCESS.equals(result)) {
            result = loginService.saveAccountInfo(data);
        }
        return result;
    }

    /**
     * 跳转到用户信息修改页面
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateAccount")
    public ModelAndView updateAccount(ModelMap modelMap, Account account, String flag) throws Exception {
        String url = LoginConstant.UPDATE_ACCOUNT;
        if (StaticDataConstant.PASSWORD.equals(flag)) {
            url = LoginConstant.UPDATE_PASSWORD;
        }
        modelMap.put("account", loginService.getAccount(account));
        return new ModelAndView(url, modelMap);
    }

    /**
     * 保存修改的用户信息
     * @param data
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/saveUpdateAccount")
    @ResponseBody
    public String saveUpdateAccount(String data) throws Exception {
        return loginService.updateAccountInfo(data);
    }
}
