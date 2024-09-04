CREATE EXTENSION btree_gist;
DROP INDEX IF EXISTS "tenant_attr"."ttble_idx";
CREATE INDEX "ttble_idx" ON "tenant_attr".t_tble(tenant_id, id);
CREATE INDEX "ttble_idx_2" ON "tenant_attr".t_tble USING GIN (tenant_attributes);