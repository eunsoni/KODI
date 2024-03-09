package config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class ResourceConfig implements WebMvcConfigurer {

	private String connectPath = "/local/image/**";
	private String resourcePath = "file:///usr/mydir/KODI_project/KODI/src/main/resources/static/image/db/";

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler(connectPath).addResourceLocations(resourcePath);
	}
}
