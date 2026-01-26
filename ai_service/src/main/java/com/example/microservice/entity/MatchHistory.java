package com.example.microservice.entity;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;

import java.time.Instant;

@Entity
@Table(name = "match_history")
public class MatchHistory {
    @Id
    @Column(name = "match_id", nullable = false)
    private Integer id;

    @Column(name = "user_id", nullable = false)
    private Integer userId;

    @Column(name = "suggested_group_id")
    private Integer suggestedGroupId;

    @Column(name = "match_score")
    private Float matchScore;

    @Lob
    @Column(name = "action")
    private String action;

    @ColumnDefault("current_timestamp()")
    @Column(name = "created_at", nullable = false)
    private Instant createdAt;

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

    public Integer getSuggestedGroupId() {
        return suggestedGroupId;
    }

    public void setSuggestedGroupId(Integer suggestedGroupId) {
        this.suggestedGroupId = suggestedGroupId;
    }

    public Float getMatchScore() {
        return matchScore;
    }

    public void setMatchScore(Float matchScore) {
        this.matchScore = matchScore;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public Instant getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Instant createdAt) {
        this.createdAt = createdAt;
    }

}