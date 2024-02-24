package com.ict.project.util;

import java.time.DayOfWeek;
import java.time.LocalDate;

public class DateStatic {
    public static int dayOfWeek(String startDate) {
        int year = Integer.parseInt(startDate.substring(0, 4));
        int month = Integer.parseInt(startDate.substring(4, 6));
        int day = Integer.parseInt(startDate.substring(6));
        LocalDate date = LocalDate.of(year, month, day);
        DayOfWeek dayOfWeek = date.getDayOfWeek();
        int dayOfWeekNumber = dayOfWeek.getValue();

        return dayOfWeekNumber;
    }

}
