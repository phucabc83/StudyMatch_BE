package com.example.microservice.entity;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import org.hibernate.annotations.ColumnDefault;

import java.time.Instant;

@Entity
@Table(name = "conversation_participants")
public class ConversationParticipant {
    @EmbeddedId
    private ConversationParticipantId id;

    @ColumnDefault("current_timestamp()")
    @Column(name = "joined_at", nullable = false)
    private Instant joinedAt;

    @Column(name = "left_at")
    private Instant leftAt;

    @ColumnDefault("0")
    @Column(name = "is_muted")
    private Boolean isMuted;

    @ColumnDefault("0")
    @Column(name = "is_pinned")
    private Boolean isPinned;

    @Column(name = "last_read_at")
    private Instant lastReadAt;

    public ConversationParticipantId getId() {
        return id;
    }

    public void setId(ConversationParticipantId id) {
        this.id = id;
    }

    public Instant getJoinedAt() {
        return joinedAt;
    }

    public void setJoinedAt(Instant joinedAt) {
        this.joinedAt = joinedAt;
    }

    public Instant getLeftAt() {
        return leftAt;
    }

    public void setLeftAt(Instant leftAt) {
        this.leftAt = leftAt;
    }

    public Boolean getIsMuted() {
        return isMuted;
    }

    public void setIsMuted(Boolean isMuted) {
        this.isMuted = isMuted;
    }

    public Boolean getIsPinned() {
        return isPinned;
    }

    public void setIsPinned(Boolean isPinned) {
        this.isPinned = isPinned;
    }

    public Instant getLastReadAt() {
        return lastReadAt;
    }

    public void setLastReadAt(Instant lastReadAt) {
        this.lastReadAt = lastReadAt;
    }

}