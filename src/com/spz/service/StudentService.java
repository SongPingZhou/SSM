package com.spz.service;

import com.spz.entity.Student;

public interface StudentService {
	
	String selectAll(Student student);
	
	Integer insertStu(Student student);
}
