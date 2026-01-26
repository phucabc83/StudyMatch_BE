package com.example.microservice.entity;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import org.hibernate.annotations.ColumnDefault;

import java.time.Instant;

@Entity
@Table(name = "message_read_receipts")
public class MessageReadReceipt {
    @EmbeddedId
    private MessageReadReceiptId id;

    @ColumnDefault("current_timestamp()")
    @Column(name = "read_at", nullable = false)
    private Instant readAt;

    public MessageReadReceiptId getId() {
        return id;
    }

    public void setId(MessageReadReceiptId id) {
        this.id = id;
    }

    public Instant getReadAt() {
        return readAt;
    }

    public void setReadAt(Instant readAt) {
        this.readAt = readAt;
    }

}