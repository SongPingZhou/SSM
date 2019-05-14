package com.spz.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spz.entity.Student;
import com.spz.service.ConsultingManagerService;

@Controller
public class ConsultingManagerController {
	@Autowired 
	private ConsultingManagerService consultingManagerService;
	
	@RequestMapping(value="/selectStuAll")
	@ResponseBody
	public String selectStuAll(Student student) {
		return consultingManagerService.selectStuAll(student);
	}
	
	@RequestMapping(value="/deleteStu")
	@ResponseBody
	public Integer deleteStu(Integer s_id) {
		return consultingManagerService.deleteStu(s_id);
	}
	
	
	@RequestMapping(value="/updateStu")
	@ResponseBody
	public Integer updateStu(Student student) {
		return consultingManagerService.updateStu(student);
	}
	
	
	@RequestMapping(value="/insertStu")
	@ResponseBody
	public Integer insertStu(Student student) {
		System.out.println(student.toString());
		return consultingManagerService.insertStu(student);
	}
	
	
	@RequestMapping(value="/selectStuByid")
	@ResponseBody
	public Student selectStuByid(Integer s_id) {
		System.out.println(s_id.toString());
		return consultingManagerService.selectStuByid(s_id);
	}
}
