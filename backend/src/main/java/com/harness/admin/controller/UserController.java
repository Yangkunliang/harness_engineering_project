package com.harness.admin.controller;

import com.harness.admin.dto.ApiResponse;
import com.harness.admin.dto.UserCreateRequest;
import com.harness.admin.entity.User;
import com.harness.admin.repository.UserRepository;
import com.harness.admin.service.UserService;
import javax.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final UserRepository userRepository;

    @PostMapping
    @PreAuthorize("hasRole('SUPER_ADMIN')")
    public ApiResponse<User> createUser(@Valid @RequestBody UserCreateRequest request) {
        try {
            User user = userService.createUser(request);
            return ApiResponse.success("用户创建成功", user);
        } catch (Exception e) {
            return ApiResponse.error(e.getMessage());
        }
    }

    @GetMapping
    @PreAuthorize("hasRole('SUPER_ADMIN')")
    public ApiResponse<List<User>> getAllUsers() {
        List<User> users = userRepository.findAll();
        return ApiResponse.success(users);
    }

    @GetMapping("/{username}")
    @PreAuthorize("hasRole('SUPER_ADMIN')")
    public ApiResponse<User> getUserByUsername(@PathVariable String username) {
        try {
            User user = userService.findByUsername(username);
            return ApiResponse.success(user);
        } catch (Exception e) {
            return ApiResponse.error(e.getMessage());
        }
    }
}
