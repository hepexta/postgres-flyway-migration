create table sample_group_history (
	sample_group_id uuid not null,
	sample_group_name text not null,
	sample_group_description text,
	created_by text not null,
	created_at timestamptz not null,
	updated_dy text not null,
	updated_at timestamptz not null,
	active boolean not null default false,
	deleted boolean not null
 );

create index idx_sample_group_history_sample_group_id on sample_group_history (sample_group_id)

COMMENT ON TABLE sample_group_history IS 'Sample Group';
COMMENT ON COLUMN sample_group_history.sample_group_id IS 'Sample Group Identifier';
COMMENT ON COLUMN sample_group_history.sample_group_name IS 'Sample Group Name';
COMMENT ON COLUMN sample_group_history.sample_group_description IS 'Sample Group Description';
COMMENT ON COLUMN sample_group_history.created_by IS 'Who created the record (if available)';
COMMENT ON COLUMN sample_group_history.created_at IS 'When the record was created';
COMMENT ON COLUMN sample_group_history.updated_dy IS 'Who updated the record (if available)';
COMMENT ON COLUMN sample_group_history.updated_at IS 'When the record was updated';
COMMENT ON COLUMN sample_group_history.active IS 'Active flag';
COMMENT ON COLUMN sample_group_history.deleted IS 'Deleted flag';

create table param_history ( 
	param_id uuid not null,
	param_sysname text not null,
	param_name text not null,
	description text,
	created_by text not null,
	created_at timestamptz not null,
	updated_by text not null,
	updated_at timestamptz not null,
	active boolean not null default false,
    deleted boolean not null
 );
 
create index idx_param_history_param_id on param_history (param_id)

COMMENT ON TABLE param_history IS 'Params';
COMMENT ON COLUMN param_history.param_id IS 'Param Primary Identifier';
COMMENT ON COLUMN param_history.param_name IS 'Param Name';
COMMENT ON COLUMN param_history.description IS 'Param Description';
COMMENT ON COLUMN param_history.created_by IS 'Who created the record (if available)';
COMMENT ON COLUMN param_history.created_at IS 'When the record was created';
COMMENT ON COLUMN param_history.updated_dy IS 'Who updated the record (if available)';
COMMENT ON COLUMN param_history.updated_at IS 'When the record was updated';
COMMENT ON COLUMN param_history.active IS 'Active flag';
COMMENT ON COLUMN param_history.deleted IS 'Deleted flag';

CREATE TABLE param_property_history ( 
	param_property_id uuid NOT NULL,
	param_id uuid NOT NULL,
	property_name text NOT NULL,
	property_value text NOT NULL,
	created_by text NOT NULL,
	created_at timestamptz DEFAULT now() NOT NULL,
	updated_by text NOT NULL,
	updated_at timestamptz DEFAULT now() NOT NULL,
	active boolean not null default false,
    deleted boolean not null
 );

create index idx_param_property_history_param_property_id on param_property_history (param_property_id)

COMMENT ON TABLE param_property_history IS 'Param Property';
COMMENT ON COLUMN param_property_history.param_property_id IS 'Param Property Identifier';
COMMENT ON COLUMN param_property_history.param_id IS 'Param Identifier';
COMMENT ON COLUMN param_property_history.property_name IS 'Param connection property';
COMMENT ON COLUMN param_property_history.property_value IS 'Param property value';
COMMENT ON COLUMN param_property_history.created_by IS 'Who created the record (if available)';
COMMENT ON COLUMN param_property_history.created_at IS 'When the record was created';
COMMENT ON COLUMN param_property_history.updated_dy IS 'Who updated the record (if available)';
COMMENT ON COLUMN param_property_history.updated_at IS 'When the record was updated';
COMMENT ON COLUMN param_property_history.active IS 'Active flag';
COMMENT ON COLUMN param_property_history.deleted IS 'Deleted flag';
