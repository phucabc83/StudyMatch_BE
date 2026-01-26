package com.example.microservice.entity;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;

import java.time.Instant;

@Entity
@Table(name = "group_invitations")
public class GroupInvitation {
    @Id
    @Column(name = "invitation_id", nullable = false)
    private Integer id;

    @Column(name = "group_id", nullable = false)
    private Integer groupId;

    @Column(name = "inviter_id", nullable = false)
    private Integer inviterId;

    @Column(name = "invitee_id", nullable = false)
    private Integer inviteeId;

    @ColumnDefault("'pending'")
    @Lob
    @Column(name = "status")
    private String status;

    @ColumnDefault("current_timestamp()")
    @Column(name = "created_at", nullable = false)
    private Instant createdAt;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getGroupId() {
        return groupId;
    }

    public void setGroupId(Integer groupId) {
        this.groupId = groupId;
    }

    public Integer getInviterId() {
        return inviterId;
    }

    public void setInviterId(Integer inviterId) {
        this.inviterId = inviterId;
    }

    public Integer getInviteeId() {
        return inviteeId;
    }

    public void setInviteeId(Integer inviteeId) {
        this.inviteeId = inviteeId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Instant getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Instant createdAt) {
        this.createdAt = createdAt;
    }

}