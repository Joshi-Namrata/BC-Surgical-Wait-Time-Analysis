create table bc_healthcare.surgical_wait_time (
  fiscal_year character varying(50),
  health_authority character varying(100),
  hospital_name character varying(100),
  procedure_group character varying(100),
  waiting character varying(50),
  completed character varying(50),
  completed_50th_percentile character varying(50),
  completed_90th_percentile character varying(50)
);

