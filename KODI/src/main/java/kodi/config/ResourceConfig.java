package kodi.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class ResourceConfig implements WebMvcConfigurer {

	@Value("${file.upload.path:/local/image/**}")
	private String connectPath;
	
	@Value("${file.upload.location:file:///usr/mydir/KODI_project/KODI/src/main/resources/static/image/db/}")
	private String resourcePath;

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler(connectPath).addResourceLocations(resourcePath);
	}
}
