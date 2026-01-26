package com.example.microservice.entity;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;

import java.time.Instant;

@Entity
@Table(name = "interaction_metrics")
public class InteractionMetric {
    @Id
    @Column(name = "metric_id", nullable = false)
    private Integer id;

    @Column(name = "user_id", nullable = false)
    private Integer userId;

    @Column(name = "target_id", nullable = false)
    private Integer targetId;

    @Lob
    @Column(name = "target_type", nullable = false)
    private String targetType;

    @ColumnDefault("0")
    @Column(name = "message_count")
    private Integer messageCount;

    @ColumnDefault("0")
    @Column(name = "video_call_duration_minutes")
    private Float videoCallDurationMinutes;

    @Column(name = "last_interaction_at")
    private Instant lastInteractionAt;

    @ColumnDefault("current_timestamp()")
    @Column(name = "updated_at", nullable = false)
    private Instant updatedAt;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getTargetId() {
        return targetId;
    }

    public void setTargetId(Integer targetId) {
        this.targetId = targetId;
    }

    public String getTargetType() {
        return targetType;
    }

    public void setTargetType(String targetType) {
        this.targetType = targetType;
    }

    public Integer getMessageCount() {
        return messageCount;
    }

    public void setMessageCount(Integer messageCount) {
        this.messageCount = messageCount;
    }

    public Float getVideoCallDurationMinutes() {
        return videoCallDurationMinutes;
    }

    public void setVideoCallDurationMinutes(Float videoCallDurationMinutes) {
        this.videoCallDurationMinutes = videoCallDurationMinutes;
    }

    public Instant getLastInteractionAt() {
        return lastInteractionAt;
    }

    public void setLastInteractionAt(Instant lastInteractionAt) {
        this.lastInteractionAt = lastInteractionAt;
    }

    public Instant getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Instant updatedAt) {
        this.updatedAt = updatedAt;
    }

}