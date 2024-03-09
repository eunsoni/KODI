package service;

import java.util.concurrent.Executor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service("emailservice")
public class EmailService {

	@Autowired
	private JavaMailSender javaMailSender;
	
	@Autowired
	private Executor executor; 

	@Async
	public void sendEmail(String to, String subject, String body) {
		executor.execute(() -> { 
			SimpleMailMessage message = new SimpleMailMessage();
			message.setTo(to);
			message.setSubject(subject);
			message.setText(body);
			javaMailSender.send(message);
	});
	}

}
