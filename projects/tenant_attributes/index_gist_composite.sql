CREATE EXTENSION btree_gist;
DROP INDEX IF EXISTS "tenant_attr"."ttble_idx";
CREATE INDEX "ttble_idx" ON "tenant_attr".t_tble USING GIN (tenant_id, tenant_attributes, id);