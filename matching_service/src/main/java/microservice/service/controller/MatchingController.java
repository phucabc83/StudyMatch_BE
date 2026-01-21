package microservice.service.controller;


import microservice.service.model.UserDTO;
import microservice.service.service.MatchingLogic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/match")
public class MatchingController {
    final MatchingLogic matchingLogic;

    public MatchingController(MatchingLogic matchingLogic) {
        this.matchingLogic = matchingLogic;
    }

    @GetMapping("/suggest/{userId}")
    public ResponseEntity<List<UserDTO>> getSuggestions(@PathVariable Long userId) {
        List<UserDTO> users = matchingLogic.findMatches(userId);

        if(users.isEmpty()) return ResponseEntity.noContent().build();

        return ResponseEntity.ok(matchingLogic.findMatches(userId));
    }

}
