package com.baizhi;

import com.baizhi.dao.AdminDao;
import com.baizhi.dao.UserDao;
import com.baizhi.service.UserService;
import io.goeasy.GoEasy;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class DefaultMapperApplicationTests {

    @Autowired
    private AdminDao adminDao;
    @Autowired
    private UserDao userDao;
    @Autowired
    private UserService userService;
    @Test
    void contextLoads() {
       /* List<Admin> admins = adminDao.selectAll();
        for (Admin admin : admins) {
            System.out.println(admin);
        }*/
       /* for (Integer integer : userService.selectUserCount("男")) {
            System.out.println(integer);
        }*/
        //第一个参数：REST Host
//第二个参数：发布消息的App Key
        GoEasy goEasy = new GoEasy( "http://rest-hangzhou.goeasy.io", "BC-1ccdaa0f28804547bef4454f960e5bef");
//第一个参数：channel的名称
//第二个参数：发布的内容
                goEasy.publish("lkp_channel", "Hello, GoEasy!");
    }

}
