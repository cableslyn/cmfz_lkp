package com.baizhi.controller;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import com.baizhi.entity.Star;
import com.baizhi.entity.User;
import com.baizhi.service.StarService;
import com.baizhi.service.UserService;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("user")
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private StarService starService;

    @RequestMapping("findUserByStarId")
    @ResponseBody
    public Map<String ,Object> findUserByStarId(Integer page,Integer rows,String starId){
        return userService.findAll(page,rows,starId);
    }


    @RequestMapping("userExport")
    @ResponseBody
    public void userExport(HttpServletRequest request, HttpServletResponse response){
        List<User> list = userService.findAll();
        String realPath = request.getServletContext().getRealPath("back/user-img");
        String realPath1 = request.getServletContext().getRealPath("back/star_img");
        for (User user : list) {
            Star one = starService.findOne( user.getStarId());
            System.out.println(one);
            one.setPhoto(realPath1+"/"+one.getPhoto());
            user.setPhoto(realPath+"/"+user.getPhoto());
            user.setStar(one);
            System.out.println(user.getPhoto());
        }
        Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams("所有用户列表","用户"), com.baizhi.entity.User.class, list);
        String fileName = "用户报表("+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+").xls";
        try {
            fileName = new String(fileName.getBytes("gbk"),"iso-8859-1");
            //设置 response
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("content-disposition","attachment;filename="+ fileName);
            workbook.write(response.getOutputStream());
            workbook.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @RequestMapping("userCount")
    @ResponseBody
    public Map<String,Object> userConut(){
        Map<String, Object> map = new HashMap<>();
        Integer[] men = userService.selectUserCount("男");
        Integer[] women = userService.selectUserCount("女");
        map.put("men",men);
        map.put("women",women);
        return map;
    }

}
