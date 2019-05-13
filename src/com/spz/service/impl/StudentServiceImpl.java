package com.spz.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.spz.dao.StudentMapper;
import com.spz.entity.Fenye;
import com.spz.entity.Student;
import com.spz.service.StudentService;
@Service
public class StudentServiceImpl implements StudentService {
	
	@Resource
	private StudentMapper studentMapper;
	
	@Override
	public String selectAll(Student student) {
		// TODO Auto-generated method stub
		Fenye<Student> fy = new Fenye<Student>();
		student.setPage((student.getPage()-1)*student.getRows());
		fy.setRows(studentMapper.selectStudent(student));
		fy.setTotal(studentMapper.CountStudent(student));
		return new Gson().toJson(fy);
	}

	@Override
	public Integer insertStu(Student student) {
		// TODO Auto-generated method stub
		return studentMapper.insertStudent(student);
	}

}
