package com.example.microservice.services.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "student_profiles")
public class StudentProfile {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "profile_id")
    private Integer id;

    @OneToOne
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    private User user;

    @Column(name = "student_code", nullable = false, unique = true, length = 20)
    private String studentCode;

    @Column(length = 100)
    private String major;

    @Column(columnDefinition = "TEXT")
    private String bio;

    @Enumerated(EnumType.STRING)
    @Column(name = "learning_style")
    private LearningStyle learningStyle;

    private Float gpa;


    public enum LearningStyle {
        VISUAL,
        AUDITORY,
        READING,
        KINESTHETIC,
        SOCIAL,
        SOLITARY
    }

}
