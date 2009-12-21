CREATE TABLE "archivos" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "usuario_id" integer, "nombre" varchar(255), "descripcion" text, "lista_hojas" text, "created_at" datetime, "updated_at" datetime, "archivo_excel_file_name" varchar(255), "archivo_excel_file_size" integer, "prelectura" boolean DEFAULT 'f', "archivo_excel_updated_at" datetime, "fecha_modificacion" datetime, "fecha_archivo" datetime);
CREATE TABLE "areas" ("id" INTEGER PRIMARY KEY  NOT NULL ,"hoja_id" integer,"nombre" varchar(255),"celda_inicial" varchar(255),"celda_final" varchar(255),"tipo" varchar(255),"rango" integer,"fija" boolean,"iterar_fila" boolean,"encabezado" text,"titular" text,"fin" text,"descartar" text,"created_at" datetime,"updated_at" datetime);
CREATE TABLE "hojas" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "archivo_id" integer, "nombre" varchar(255), "numero" integer, "fecha_archivo" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "usuarios" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "nombre" varchar(50), "paterno" varchar(30), "materno" varchar(30), "email" varchar(255), "login" varchar(20), "password_salt" varchar(255), "crypted_password" varchar(255), "persistence_token" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20090916192851');

INSERT INTO schema_migrations (version) VALUES ('20091028192054');

INSERT INTO schema_migrations (version) VALUES ('20091028201135');

INSERT INTO schema_migrations (version) VALUES ('20091030145122');

INSERT INTO schema_migrations (version) VALUES ('20091105151445');

INSERT INTO schema_migrations (version) VALUES ('20091109164356');

INSERT INTO schema_migrations (version) VALUES ('20091110144310');

INSERT INTO schema_migrations (version) VALUES ('20091123150839');