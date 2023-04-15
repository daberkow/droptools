package com.bendb.dropwizard.jooq.jersey;

import com.google.common.base.Preconditions;
import org.jooq.Configuration;

import jakarta.ws.rs.core.Feature;
import jakarta.ws.rs.core.FeatureContext;

import javax.annotation.Nonnull;
import java.util.SortedMap;

public class DSLContextFeature implements Feature {
    private final SortedMap<String, Configuration> configurations;

    public DSLContextFeature(@Nonnull SortedMap<String, Configuration> configurations) {
        this.configurations = Preconditions.checkNotNull(configurations, "configurations");
    }

    @Override
    public boolean configure(FeatureContext context) {
        context.register(new JooqBinder(configurations));
        return true;
    }
}
