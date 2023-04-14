package com.bendb.dropwizard.jooq;

import org.jooq.Converter;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.Temporal;

/**
 * A {@link org.jooq.Converter} for {@link DateTime} objects.
 */
public class JodaDateTimeConverter implements Converter<Timestamp, LocalDateTime> {
    @Override
    public LocalDateTime from(Timestamp timestamp) {
        return timestamp != null
                ? new LocalDateTime(timestamp.getTime())
                : null;
    }

    @Override
    public Timestamp to(LocalDateTime dateTime) {
        return dateTime != null
                ? new Timestamp(dateTime.toLocalTime().toNanoOfDay())
                : null;
    }

    @Override
    public Class<Timestamp> fromType() {
        return Timestamp.class;
    }

    @Override
    public Class<LocalDateTime> toType() {
        return LocalDateTime.class;
    }
}
