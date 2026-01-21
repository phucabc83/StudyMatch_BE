package microservice.service.service;

import microservice.service.feign_client.UserClient;
import microservice.service.model.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class MatchingLogic {

    @Autowired
    private UserClient userClient; // Chiếc "điện thoại" Feign đã tạo ở bước trước

    public List<UserDTO> findMatches(Long currentUserId) {
        // 1. Lấy thông tin của chính mình
        UserDTO currentUser = userClient.getUserById(currentUserId);

        // 2. Lấy danh sách tất cả sinh viên khác (Giả sử có hàm getAllUsers)
        List<UserDTO> allUsers = userClient.getAllUser();

        // 3. Thuật toán Basic: Lọc những người có cùng style_learn
        return allUsers.stream()
                .filter(user -> !user.getId().equals(currentUserId)) // Không tự gợi ý chính mình
                .collect(Collectors.toList());


    }
}
