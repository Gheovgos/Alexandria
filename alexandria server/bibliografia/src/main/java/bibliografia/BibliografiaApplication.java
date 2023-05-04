package bibliografia;

import org.modelmapper.ModelMapper;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.net.InetAddress;

@SpringBootApplication
public class BibliografiaApplication {

	@Bean
	public ModelMapper modelMapper()
	{
		return new ModelMapper();
	}
	public static void main(String[] args)
	{
		SpringApplication.run(BibliografiaApplication.class, args);
		System.out.println("IP Server: "+InetAddress.getLoopbackAddress().getHostAddress());
	}

}
