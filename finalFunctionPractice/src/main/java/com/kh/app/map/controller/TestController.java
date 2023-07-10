package com.kh.app.map.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping ("map")
public class TestController {
	@GetMapping ("show")
	public String test() {
		return "show-map";
	}
}
