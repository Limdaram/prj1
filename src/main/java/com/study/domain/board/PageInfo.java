package com.study.domain.board;

import lombok.Data;

@Data
public class PageInfo {
    private int currentPageNumber;
    private int lastPageNumber;
    private int leftPageNumber;
    private int rightPageNumber;
    public int previousPageNumber;
    public int nextPageNumber;
    public boolean hasPreviousButton;
    public boolean hasNextButton;
}
