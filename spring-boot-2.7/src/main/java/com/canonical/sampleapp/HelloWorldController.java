package com.canonical.sampleapp;

import java.util.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorldController {
	@Value("${greeting:Hello}")
	private String greeting;

	@GetMapping(value = "/hello-world", produces = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, String> helloWorld() {
		return Collections.singletonMap("response", String.format("%s, World!", greeting));
	}
}
