package com.emse.spring.parking_proj.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Configuration class for handling Cross-Origin Resource Sharing (CORS) settings.
 * It allows configuring CORS policies for the application.
 */
@Configuration
public class CorsConfig {

    /**
     * Configures CORS mappings to allow cross-origin requests.
     *
     * @return a {@link WebMvcConfigurer} instance with CORS configuration.
     */
    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**") // Allows all paths
                        .allowedOrigins("*") // Permits any origin (use only for testing)
                        .allowedMethods("GET", "POST", "DELETE", "PUT", "OPTIONS") // HTTP methods allowed
                        .allowedHeaders("*") // Allows all headers
                        .allowCredentials(false); // Temporarily disables credentials
            }
        };
    }
}