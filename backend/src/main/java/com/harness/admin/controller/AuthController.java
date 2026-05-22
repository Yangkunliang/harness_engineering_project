package com.harness.admin.controller;

import com.harness.admin.dto.ApiResponse;
import com.harness.admin.dto.LoginRequest;
import com.harness.admin.dto.LoginResponse;
import com.harness.admin.service.UserService;
import javax.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final UserService userService;

    @PostMapping("/login")
    public ApiResponse<LoginResponse> login(@Valid @RequestBody LoginRequest request) {
        try {
            LoginResponse response = userService.login(request);
            return ApiResponse.success("登录成功", response);
        } catch (Exception e) {
            return ApiResponse.error(401, "登录失败: " + e.getMessage());
        }
    }

    @GetMapping("/public-key")
    public ApiResponse<Map<String, String>> getPublicKey() {
        Map<String, String> result = new HashMap<>();
        result.put("publicKey", userService.getPublicKey());
        return ApiResponse.success(result);
    }
}
