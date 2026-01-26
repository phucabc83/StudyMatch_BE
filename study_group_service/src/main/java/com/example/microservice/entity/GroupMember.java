package com.example.microservice.entity;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;

import java.time.Instant;

@Entity
@Table(name = "group_members")
public class GroupMember {
    @EmbeddedId
    private GroupMemberId id;

    @ColumnDefault("'member'")
    @Lob
    @Column(name = "role")
    private String role;

    @ColumnDefault("current_timestamp()")
    @Column(name = "joined_at", nullable = false)
    private Instant joinedAt;

    public GroupMemberId getId() {
        return id;
    }

    public void setId(GroupMemberId id) {
        this.id = id;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Instant getJoinedAt() {
        return joinedAt;
    }

    public void setJoinedAt(Instant joinedAt) {
        this.joinedAt = joinedAt;
    }

}