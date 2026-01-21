package com.example.microservice.services.entity;


import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(
        name = "friend_connections",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = {"requester_id", "receiver_id"})
        }
)
public class FriendConnection {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "connection_id")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "requester_id", nullable = false)
    private User requester;

    @ManyToOne
    @JoinColumn(name = "receiver_id", nullable = false)
    private User receiver;

    @Enumerated(EnumType.STRING)
    private FriendStatus status;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    public enum FriendStatus {
        PENDING,
        ACCEPTED,
        BLOCKED
    }

}
