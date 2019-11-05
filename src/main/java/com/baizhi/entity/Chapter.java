package com.baizhi.entity;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Id;
import java.util.Date;

@Data
@NoArgsConstructor
public class Chapter {
    @Id
    private String id;
    private String size;
    private String duration;
    private String name;
    @JsonFormat(pattern = "yyyy/MM/dd",timezone = "GMT+8")
    private Date createDate;
    private String albumId;

}
