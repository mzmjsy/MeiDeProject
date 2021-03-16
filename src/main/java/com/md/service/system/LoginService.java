package com.md.service.system;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.md.domain.module.Module;
import com.md.domain.system.Account;
import com.md.persistence.module.ModuleMapper;
import com.md.persistence.system.LoginMapper;
import com.md.util.CommonData;
import com.md.util.StaticDataConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * @author
 */
@Service
public class LoginService {
    @Autowired
    private LoginMapper loginMapper;
    @Autowired
    private ModuleMapper moduleMapper;

    /**
     * 校验登录
     * @param account
     * @return
     * @throws Exception
     */
    public String validateLogin(Account account) throws Exception {
        String result = StaticDataConstant.TRUE;
        try {
            List<Account> accountInfoList = loginMapper.getAccountInfo(account);

            if (accountInfoList.isEmpty() || 0 == accountInfoList.size()) {
                result = "请输入正确的账号或密码";
            } else if (null == account.getUsername()) {
                result = "账号不能为空";
            } else if (accountInfoList.size() >= 2) {
                result = "该账号存在多个，请找管理员处理";
            }
        } catch (Exception e) {
            result = "登录时报错";
            e.printStackTrace();
        }

        return result;
    }

    /**
     * 获取账号信息
     * @param account
     * @return
     * @throws Exception
     */
    public Account getAccount(Account account) throws Exception {
        try {
            List<Account> accountInfoList = loginMapper.getAccountInfo(account);

            if (!accountInfoList.isEmpty() && null != accountInfoList) {
                return accountInfoList.get(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * 根据账号查找信息
     * @param account
     * @return
     * @throws Exception
     */
    public String checkAccountByName(Account account) throws Exception {
        String result = StaticDataConstant.SUCCESS;
        try {
            account.setPassword(null);
            List<Account> accountInfoList = loginMapper.getAccountInfo(account);

            if (1 <= accountInfoList.size()) {
                result = StaticDataConstant.ONE;
            }
        } catch (Exception e) {
            result = StaticDataConstant.ERROR;
            e.printStackTrace();
        }

        return result;
    }

    /**
     * 获取所有节点
     * @author mz
     * @return
     * @throws Exception
     */
    public List<Module> getAllModuleInfo() throws Exception {
        try {
            //一级节点
            List<Module> listModule1 = moduleMapper.getModuleInfoByLevel(1);

            //二级节点
            List<Module> listModule2 = moduleMapper.getModuleInfoByLevel(2);

            //三级节点
            List<Module> listModule3 = moduleMapper.getModuleInfoByLevel(3);

            //组合二级节点和三级节点
            listModule2 = convertData(listModule2, listModule3);

            //组合一级节点和二级节点
            listModule1 = convertData(listModule1, listModule2);

            return listModule1;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * 保存注册的账号信息
     * @param data
     * @throws Exception
     */
    public String saveAccountInfo(String data) throws Exception {
        String result = StaticDataConstant.SUCCESS;
        try {
            Account account = JSON.toJavaObject(JSONObject.parseObject(data), Account.class);
            account.setId(CommonData.getUUID());
            account.setNickname(CommonData.getUUID().substring(0, 20));
            loginMapper.saveAccountInfo(account);
        } catch (Exception e) {
            result = StaticDataConstant.ERROR;
            e.printStackTrace();
        }

        return result;
    }

    /**
     * 修改用户信息
     * @param data
     * @return
     * @throws Exception
     */
    public String updateAccountInfo(String data) throws Exception {
        String result = StaticDataConstant.SUCCESS;
        try {
            Account account = JSON.toJavaObject(JSONObject.parseObject(data), Account.class);
            Account a = new Account();
            a.setNickname(account.getNickname());
            List<Account> accountInfoList = loginMapper.getAccountInfo(a);

            if (!accountInfoList.isEmpty() || accountInfoList.size() >= 1) {
                result = StaticDataConstant.ONE;
            } else {
                loginMapper.updateAccountInfo(account);
            }
        } catch (Exception e) {
            result = StaticDataConstant.ERROR;
            e.printStackTrace();
        }

        return result;
    }

    /**
     * 组合父节点和子节点数据
     * @param listModuleParent  父节点
     * @param listModuleChild   子节点
     * @return
     */
    public List<Module> convertData(List<Module> listModuleParent, List<Module> listModuleChild) {
        for (Module moduleParent : listModuleParent) {
            List<Module> lm = new ArrayList<Module>();
            for (Module moduleChild : listModuleChild) {
                if (moduleParent.getVcode().equals(moduleChild.getVparentcode())) {
                    lm.add(moduleChild);
                }
            }
            moduleParent.setModuleList(lm);
        }

        return listModuleParent;
    }
}
