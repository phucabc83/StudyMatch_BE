package microservice.service.feign_client;


import microservice.service.model.UserDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@FeignClient("USER-SERVICE")
public interface UserClient {

    @GetMapping("/users")
    List<UserDTO> getAllUser();

    @GetMapping("/users/{id}")
    UserDTO getUserById(@PathVariable Long id);


}
