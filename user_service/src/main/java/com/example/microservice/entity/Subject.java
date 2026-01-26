package com.example.microservice.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "subjects")
public class Subject {
    @Id
    @Column(name = "subject_id", nullable = false)
    private Integer id;

    @Size(max = 100)
    @NotNull
    @Column(name = "subject_name", nullable = false, length = 100)
    private String subjectName;

    @Lob
    @Column(name = "description")
    private String description;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}