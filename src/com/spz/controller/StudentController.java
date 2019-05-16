package com.spz.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spz.entity.Student;
import com.spz.service.StudentService;
@Controller
public class StudentController {
	
	@Resource
	private StudentService studentService;
	
	@RequestMapping(value="/selectAll")
	@ResponseBody
	public String selectAll(Student student) {
		return studentService.selectAll(student);
		
	}
	@RequestMapping(value="/insertStu",method=RequestMethod.POST)
	@ResponseBody
	public Integer insertStu(Student student) {
		
		return studentService.insertStu(student);
		
	}
  
}
