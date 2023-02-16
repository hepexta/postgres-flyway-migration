create or replace function raise_truncate_error() returns trigger as
$$
begin
    if (lower(tg_op) = 'truncate') then
        RAISE EXCEPTION 'Truncate operation is restricted';
    end if;
    return null;
end;
$$ language plpgsql;

create or replace function process_sample_group_history() returns trigger as
$trigger_sample_group_history$
begin
    if (lower(tg_op) = 'delete') then
        insert into sample_group_history (sample_group_id, sample_group_name, sample_group_description, created_by,
                                          	created_at, updated_by, updated_at, active, deleted)
        select old.sample_group_id,
               old.sample_group_name,
               old.sample_group_description,
               old.created_by,
               old.created_at,
               old.updated_by,
               now(),
               old.active;
               true;
        return old;
    else if (lower(tg_op) = 'update') then
        insert into sample_group_history (sample_group_id, sample_group_name, sample_group_description, created_by,
                                                  	created_at, updated_by, updated_at, active)
                select new.sample_group_id,
                       new.sample_group_name,
                       new.sample_group_description,
                       new.created_by,
                       new.created_at,
                       new.updated_by,
                       new.updated_at,
                       new.active;
                return new;
    else if (lower(tg_op) = 'insert') then
        insert into sample_group_history (sample_group_id, sample_group_name, sample_group_description, created_by,
                                                  	created_at, updated_by, updated_at, active)
                select new.sample_group_id,
                       new.sample_group_name,
                       new.sample_group_description,
                       new.created_by,
                       new.created_at,
                       new.updated_by,
                       new.updated_at,
                       new.active;
                return new;
    end if;
    return null;
end;
$trigger_sample_group_history$ language plpgsql;

create trigger process_sample_group_history
    before insert or update or delete
    on sample_group
    for each row
execute procedure process_sample_group_history();

create trigger process_sample_group_history_truncate
    before truncate
    on sample_group
execute procedure raise_truncate_error();