package com.spz.controller;

import java.util.List;
import java.util.TreeSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spz.dao.RolesMapper;
import com.spz.entity.Roles;
import com.spz.entity.UserRoles;
import com.spz.service.RolesModulesService;
import com.spz.service.RolesService;
import com.spz.service.UserRolesService;
import com.spz.util.Result;

@Controller
public class RolesController {

	@Autowired private RolesService rolesService;
	
	@Autowired private RolesModulesService rolesModulesService;
	
	@Autowired private UserRolesService  userRolesService;
	
	@RequestMapping(value="/selectAllRoles",method=RequestMethod.POST)
	@ResponseBody
	public String selectAllRoles(Roles roles) {
		return rolesService.selectRolesByRole(roles);
	}
	
	@RequestMapping(value="/addEditRoles",method=RequestMethod.POST)
	@ResponseBody
	public String addEditRoles(Roles roles) {
		Integer num=null;
		if(roles.getR_id()==null) {
			num=rolesService.insertRoles(roles);
			return Result.toClient(num>0 ? true : false, num>0 ? "添加成功" : "添加失败");
		}else {
			num=rolesService.updateRoles(roles);
			return Result.toClient(num>0 ? true : false, num>0 ? "修改成功" : "修改失败");
		}
	}
	
	@RequestMapping(value="/deleteRolesById",method=RequestMethod.POST)
	@ResponseBody
	public String deleteRolesById(Integer r_id) {
		//删除角色之前首先判断是否被员工引用，如果被引用的时候不能删除
		List<UserRoles> byR_id = userRolesService.selectByR_id(r_id);
		if(byR_id.size()>0) {
			return Result.toClient(true, "该角色正在被员工引用，请解除后再进行删除！");
		}else {
			Integer roles = rolesService.deleteRoles(r_id);
			return Result.toClient(roles>0 ? true :false, roles>0 ? "删除成功" : "删除失败");
		}
	}
	
	@RequestMapping(value="/setupQuanXian",method=RequestMethod.POST)
	@ResponseBody
	public String setupQuanXian(String arr,Integer r_id) {
		//拿到角色的id去角色和模块的中间表删除所有角色的模块，然后去添加新的模块信息
		String[] split = arr.split(",");
		if(split.length==1) {
			 Integer modules = rolesModulesService.deleteRoleModules(r_id);
			 return Result.toClient(true, modules>0 ? "设置成功" : "设置失败");
		}
		TreeSet<String> tr = new TreeSet<String>();
		for (int i = 0; i < split.length; i++) {
			tr.add(split[i]);
		}
		String[] s2 = new String[tr.size()];
		for (int i = 0; i < s2.length; i++) {
			s2[i] = tr.pollFirst();// 从TreeSet中取出元素重新赋给数组
		}
		Integer integer = rolesModulesService.deleteRoleModules(r_id);
		for(int i=0;i<s2.length;i++) {
			integer= rolesModulesService.insertRoleModules(r_id, Integer.parseInt(s2[i]));
		}
		return Result.toClient(true, integer>0 ? "设置成功" : "设置失败");
	}
	
	@RequestMapping(value="/selectByName",method=RequestMethod.POST)
	@ResponseBody
	public String selectByName(Roles roles) {
		Roles byName = rolesService.selectRolesByName(roles);
		if(byName==null) {
			return Result.toClient(true, "");
		}else{
			return Result.toClient(false, "用户已经存在");
		}
	}
	
}
