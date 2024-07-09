DROP INDEX IF EXISTS "tenant_attr"."ttble_idx";
CREATE INDEX "ttble_idx" ON "tenant_attr".t_tble(tenant_id, id);