package com.bendb.dropwizard.jooq.jersey;

import org.glassfish.hk2.api.Factory;
import org.jooq.Configuration;
import org.jooq.DSLContext;
import org.jooq.impl.DSL;

import java.time.Clock;
import java.time.LocalDate;

/**
 * Bind
 */
public class DSLContextFactory implements Factory<DSLContext> {
    private final Configuration configuration;

    public DSLContextFactory(Configuration configuration) {
        this.configuration = configuration;
        this.configuration.derive(Clock.systemDefaultZone());
    }

    @Override
    public DSLContext provide() {
        var test = configuration.clock();
        return DSL.using(configuration);
    }

    @Override
    public void dispose(DSLContext instance) {
    }
}
