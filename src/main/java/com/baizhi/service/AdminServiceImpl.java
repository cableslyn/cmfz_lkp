package com.baizhi.service;

import com.baizhi.dao.AdminDao;
import com.baizhi.entity.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.UUID;

@Service("adminService")
@Transactional
public class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminDao adminDao;
    @Override
    public void login(Admin admin, String code, HttpServletRequest request) {
        String  code1 = (String) request.getSession().getAttribute("code");
        if (code.equals(code1)){
            Admin admin1 = adminDao.selectOne(admin);
            request.getSession().setAttribute("admin",admin1);
            if (admin1 == null){
                throw new RuntimeException("用户名不存在");
            }else if(!admin1.getPassword().equals(admin.getPassword())){
                throw new RuntimeException("密码错误");
            }
        }else {
            throw new RuntimeException("验证码错误");
        }
    }

    @Override
    public void regist(Admin admin,String sms,HttpServletRequest request) {
        admin.setId(UUID.randomUUID().toString());
        System.out.println("要注册的用户："+admin);
        String code = (String) request.getSession().getAttribute("code");
        System.out.println("code="+code);
        System.out.println("sms="+sms);
        if (!code.equals(sms)){
            throw new RuntimeException("验证码错误");
        }
        if (admin.getUsername()==null||admin.getPassword()==null||admin.getNickname()==null||admin.getUsername().equals("")||admin.getPassword().equals("")||admin.getNickname().equals("")){
            throw new RuntimeException("注册信息不能为空");
        }else{
            adminDao.insert(admin);
        }
    }
}
