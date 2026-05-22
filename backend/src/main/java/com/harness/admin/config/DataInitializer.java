package com.harness.admin.config;

import com.harness.admin.entity.User;
import com.harness.admin.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@RequiredArgsConstructor
@Slf4j
public class DataInitializer implements CommandLineRunner {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Value("${admin.init.username}")
    private String initUsername;

    @Value("${admin.init.password}")
    private String initPassword;

    @Value("${admin.init.role}")
    private String initRole;

    @Override
    @Transactional
    public void run(String... args) {
        if (!userRepository.existsByUsername(initUsername)) {
            User superAdmin = User.builder()
                    .username(initUsername)
                    .password(passwordEncoder.encode(initPassword))
                    .realName("系统管理员")
                    .role(initRole)
                    .enabled(true)
                    .accountNonLocked(true)
                    .accountNonExpired(true)
                    .credentialsNonExpired(true)
                    .superAdmin(true)
                    .build();

            userRepository.save(superAdmin);
            log.info("========================================");
            log.info("  超级管理员账号已初始化成功！");
            log.info("  用户名: {}", initUsername);
            log.info("  密码: {}", initPassword);
            log.info("  角色: {}", initRole);
            log.info("========================================");
        } else {
            log.info("  超级管理员账号已存在，跳过初始化");
        }
    }
}
