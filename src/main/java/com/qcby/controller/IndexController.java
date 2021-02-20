package com.qcby.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("")
public class IndexController {

    @RequestMapping("/{ip}")
    public String index(@PathVariable String ip) {
        return "" + ip + "";
    }
}
