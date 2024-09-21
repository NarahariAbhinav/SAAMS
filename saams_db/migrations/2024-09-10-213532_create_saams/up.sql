-- Your SQL goes here
CREATE TYPE SEX AS ENUM (
	'Male', 
	'Female'
);

CREATE TABLE "companies"(
	"id" SMALLSERIAL NOT NULL PRIMARY KEY,
	"name" VARCHAR NOT NULL,
	"code" VARCHAR NOT NULL,
	"address" VARCHAR NOT NULL,
	"city" VARCHAR NOT NULL,
	"state" VARCHAR NOT NULL,
	"pincode" VARCHAR NOT NULL,
	"email" VARCHAR NOT NULL,
	"phone" VARCHAR NOT NULL,
	"fax" VARCHAR NOT NULL,
	"created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "departments"(
	"id" SMALLSERIAL NOT NULL PRIMARY KEY,
	"name" VARCHAR NOT NULL,
	"code" VARCHAR NOT NULL,
	"created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "shifts"(
	"id" SMALLSERIAL NOT NULL PRIMARY KEY,
	"name" VARCHAR NOT NULL,
	"code" VARCHAR NOT NULL,
	"created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "designations"(
	"id" SMALLSERIAL NOT NULL PRIMARY KEY,
	"name" VARCHAR NOT NULL,
	"code" VARCHAR NOT NULL,
	"created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "roles"(
	"id" SMALLSERIAL NOT NULL PRIMARY KEY,
	"name" VARCHAR NOT NULL,
	"code" VARCHAR NOT NULL,
	"created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "privileges"(
	"id" SMALLSERIAL NOT NULL PRIMARY KEY,
	"name" VARCHAR NOT NULL,
	"code" VARCHAR NOT NULL,
	"created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "roles_privileges"(
	"id" SMALLSERIAL NOT NULL PRIMARY KEY,
	"role_id" INT2 NOT NULL,
	"privilege_id" INT2 NOT NULL,
	"created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY ("role_id") REFERENCES "roles"("id"),
	FOREIGN KEY ("privilege_id") REFERENCES "privileges"("id")
);

CREATE TABLE "users"(
	"id" SERIAL NOT NULL PRIMARY KEY,
	"user_name" VARCHAR NOT NULL,
	"password" VARCHAR NOT NULL,
	"first_name" VARCHAR NOT NULL,
	"last_name" VARCHAR NOT NULL,
	"email" VARCHAR NOT NULL,
	"phone" VARCHAR NOT NULL,
	"sex" SEX NOT NULL,
	"date_of_birth" DATE NOT NULL,
	"date_of_joining" DATE NOT NULL,
	"role_id" INT2 NOT NULL,
	"company_id" INT2 NOT NULL,
	"designation_id" INT2 NOT NULL,
	"department_id" INT2 NOT NULL,
	"shift_id" INT2 NOT NULL,
	"created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY ("role_id") REFERENCES "roles"("id"),
	FOREIGN KEY ("company_id") REFERENCES "companies"("id"),
	FOREIGN KEY ("designation_id") REFERENCES "designations"("id"),
	FOREIGN KEY ("department_id") REFERENCES "departments"("id"),
	FOREIGN KEY ("shift_id") REFERENCES "shifts"("id")
);
