package com.example.simpleserver;

import java.util.Date;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
public class SimpleServerApplication {

	public static void main(String[] args) {
		SpringApplication.run(SimpleServerApplication.class, args);
	}
}

@RestController
class SimpleServerController {
    @RequestMapping("/helloUser")
    public String helloUser(){
	     System.out.println("Inside helloUser()");
	     return "HAPPY HOLIDAYS GREEN user!!! : " + new Date() + "\n";
    }

}
