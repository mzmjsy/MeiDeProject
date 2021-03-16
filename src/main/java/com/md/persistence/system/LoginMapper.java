package com.md.persistence.system;

import com.md.domain.system.Account;

import java.util.List;

/**
 * @author mz
 */
public interface LoginMapper {

    /**
     * 获取用户信息
     * @author mz
     * @param account
     * @return
     */
    public List<Account> getAccountInfo(Account account);

    /**
     * 保存注册的账号信息
     * @param account
     */
    public void saveAccountInfo(Account account);

    /**
     * 修改用户信息
     * @param account
     */
    public void updateAccountInfo(Account account);
}
