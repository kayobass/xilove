CREATE TABLE IF NOT EXISTS guilds_config (
    guild_id BIGINT PRIMARY KEY,
    timezone TEXT NOT NULL,
    report_channel_id BIGINT,
    ignored_channels BIGINT[] NOT NULL DEFAULT '{}',
    digest_enabled BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    last_weekly_report_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


CREATE TABLE IF NOT EXISTS messages_meta (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    guild_id BIGINT NOT NULL,
    channel_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    char_length INT NOT NULL DEFAULT 0
);

CREATE INDEX IF NOT EXISTS idx_messages_guild_date
    ON messages_meta (guild_id, created_at);

CREATE INDEX IF NOT EXISTS idx_messages_guild_user
    ON messages_meta (guild_id, user_id, created_at);


CREATE TABLE IF NOT EXISTS members_traffic (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    guild_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    event_type SMALLINT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    CHECK (event_type IN (-1, 1))
);

CREATE INDEX IF NOT EXISTS idx_members_traffic_guild_date
    ON members_traffic (guild_id, created_at);


CREATE TABLE IF NOT EXISTS opt_outs (
    user_id BIGINT PRIMARY KEY,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);