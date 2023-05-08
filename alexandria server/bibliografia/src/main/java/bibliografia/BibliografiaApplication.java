package bibliografia;

import org.modelmapper.ModelMapper;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.net.InetAddress;
import java.net.UnknownHostException;

@SpringBootApplication
public class BibliografiaApplication {

	@Bean
	public ModelMapper modelMapper()
	{
		return new ModelMapper();
	}
	public static void main(String[] args) throws UnknownHostException {
		SpringApplication.run(BibliografiaApplication.class, args);
		System.out.println("IP Server: "+InetAddress.getLocalHost().getHostAddress()+"\nPorta: 8090");
	}

}
