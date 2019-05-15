package com.spz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spz.entity.Roles;
import com.spz.entity.UserRoles;
import com.spz.entity.Users;
import com.spz.service.UserRolesService;
import com.spz.service.UsersService;
import com.spz.util.Result;

@Controller
public class UsersController {
	
	@Autowired UsersService usersService;
	
	@Autowired UserRolesService userRolesService;
	
	@RequestMapping(value="/moduls",method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> getModuls(Integer u_id) {
		return usersService.selectUserModuls(u_id);
	}
	
	@RequestMapping(value="/selectUser",method=RequestMethod.POST)
	@ResponseBody
	public String selectUser(Users users) {
		return usersService.selectUsersByUsers(users);
	}
	
	@RequestMapping(value="/insertUser",method=RequestMethod.POST)
	@ResponseBody
	public String insertUser(Users users) {
		Integer num=null;
		if(users.getU_id()==null) {
			num=usersService.insertUsers(users);
			return Result.toClient(num > 0 ? true :false, num > 0 ? "��ӳɹ�" : "���ʧ��");
		}else {
			num=usersService.updateUsers(users);
			return Result.toClient(num > 0 ? true :false, num > 0 ? "�޸ĳɹ�" : "�޸�ʧ��");
		}
	}
	
	@RequestMapping(value="/deleteUser",method=RequestMethod.POST)
	@ResponseBody
	public Integer deleteUser(Integer u_id) {
		return usersService.deleteUsers(u_id);
	}
	
	@RequestMapping(value="/selectRoles",method=RequestMethod.POST)
	@ResponseBody
	public List<Roles> selectRoles(Integer u_id) {
		if(u_id==null) {
			return  usersService.selectRolesAll();
		}else{
			return  usersService.selectRolesAllbyU_id(u_id);
		}
	}
	
	@RequestMapping(value="/insertRoles",method=RequestMethod.POST)
	@ResponseBody
	public Integer insertRoles(UserRoles userRoles) {
		return userRolesService.insertUserRoles(userRoles);
	}
	
	@RequestMapping(value="/deleteRoles",method=RequestMethod.POST)
	@ResponseBody
	public Integer deleteRoles(UserRoles userRoles) {
		return userRolesService.deleteUserRoles(userRoles);
	}
	
	@RequestMapping(value="/lockUser",method=RequestMethod.POST)
	@ResponseBody
	public Integer lockUser(Users users) {
		return usersService.updateUsers(users);
	}
}
