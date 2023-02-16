create extension if not exists "uuid-ossp"

create table sample_group ( 
	sample_group_id uuid not null default iuuid_generate_v4(),
	sample_group_name text not null,
	sample_group_description text,
	created_by text not null,
	created_at timestamptz not null default now(),
	updated_by text not null,
	updated_at timestamptz not null default now(),
	active boolean not null,
	constraint pk_sample_group_group_id primary key (sample_group_id)
 );

alter table sample_group add constraint check_sample_group_name check ( ( length(sample_group_name) <= 100) );

COMMENT ON TABLE sample_group IS 'Sample Group';
COMMENT ON COLUMN sample_group.sample_group_id IS 'Sample Group Identifier';
COMMENT ON COLUMN sample_group.sample_group_name IS 'Sample Group Name';
COMMENT ON COLUMN sample_group.sample_group_description IS 'Sample Group Description';
COMMENT ON COLUMN sample_group.created_by IS 'Who created the record (if available)';
COMMENT ON COLUMN sample_group.created_at IS 'When the record was created';
COMMENT ON COLUMN sample_group.updated_by IS 'Who updated the record (if available)';
COMMENT ON COLUMN sample_group.updated_at IS 'When the record was updated';
COMMENT ON COLUMN sample_group.active IS 'Active flag';

create unique index idx_sample_group_sample_group_name on sample_group (lower(sample_group_name));
create index idx_sample_group_created_at on sample_group (created_at desc);

create table param ( 
	param_id uuid default iuuid_generate_v4() not null,
	param_sysname text not null,
	param_name text not null,
	description text,
	created_by text not null,
	created_at timestamptz default now() not null,
	updated_by text not null,
	updated_at timestamptz default now() not null,
	active boolean not null,
	constraint pk_param_param_id primary key ( param_id )
 );

COMMENT ON TABLE param IS 'Params';
COMMENT ON COLUMN param.param_id IS 'Param Primary Identifier';
COMMENT ON COLUMN param.param_name IS 'Param Name';
COMMENT ON COLUMN param.description IS 'Param Description';
COMMENT ON COLUMN param.created_by IS 'Who created the record (if available)';
COMMENT ON COLUMN param.created_at IS 'When the record was created';
COMMENT ON COLUMN param.updated_by IS 'Who updated the record (if available)';
COMMENT ON COLUMN param.updated_at IS 'When the record was updated';
COMMENT ON COLUMN param.active IS 'Active flag';

create unique index idx_param_param_sysname on param (lower(param_sysname))

CREATE TABLE param_property ( 
	param_property_id uuid default iuuid_generate_v4() NOT NULL,
	param_id uuid NOT NULL,
	property_name text NOT NULL,
	property_value text NOT NULL,
	created_by text NOT NULL,
	created_at timestamptz DEFAULT now() NOT NULL,
	updated_by text NOT NULL,
	updated_at timestamptz DEFAULT now() NOT NULL,
	active boolean not null,
	CONSTRAINT pk_template_rule_attribute_template_rule_attribute PRIMARY KEY ( param_property_id ),
	CONSTRAINT fk_param_property_param foreign KEY (param_id) references param,
	constraint check_param_property_name_length check ( ( length(property_name) <= 100) )
 );

CREATE INDEX unq_param_property_param_id ON param_property ( param_id );
create unique index idx_param_property_property_name on param_property (lower(property_name));

COMMENT ON TABLE param_property IS 'Param Property';
COMMENT ON COLUMN param_property.param_property_id IS 'Param Property Identifier';
COMMENT ON COLUMN param_property.param_id IS 'Param Identifier';
COMMENT ON COLUMN param_property.property_name IS 'Param connection property';
COMMENT ON COLUMN param_property.property_value IS 'Param property value';
COMMENT ON COLUMN param_property.created_by IS 'Who created the record (if available)';
COMMENT ON COLUMN param_property.created_at IS 'When the record was created';
COMMENT ON COLUMN param_property.updated_by IS 'Who updated the record (if available)';
COMMENT ON COLUMN param_property.updated_at IS 'When the record was updated';
COMMENT ON COLUMN param_property.active IS 'Active flag';
