-- Create campaigns table
CREATE TABLE campaigns(
    campaign_id BIGSERIAL,
    company_id BIGINT,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NULL,
    PRIMARY KEY(id, company_id)
);
SELECT CREATE_DISTRIBUTED_TABLE('campaigns', 'company_id');
-- Create companies table
CREATE TABLE companies(
    company_id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    image_url TEXT NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NULL
);
SELECT CREATE_DISTRIBUTED_TABLE(
        'companies',
        'company_id',
        COLOCATE_WITH := 'campaigns'
    );
-- Create ads table
CREATE TABLE ads(
    ads_id BIGSERIAL,
    company_id BIGINT,
    campaign_id BIGINT,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    media_type_id BIGINT,
    media_url TEXT NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NULL,
    PRIMARY KEY(id, campaign_id)
);
SELECT CREATE_DISTRIBUTED_TABLE(
        'ads',
        'campaign_id',
        COLOCATE_WITH := 'campaigns'
    );
-- Create media_types table
CREATE TABLE media_types(
    media_type_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NULL
);
SELECT CREATE_REFERENCE_TABLE('media_types');
-- Query with citus partition join
SET citus.enable_repartition_joins = TRUE;