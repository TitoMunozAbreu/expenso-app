--------------------------------------------------------------------
-- EXPENSO APP
-- SCHEMA
-- VERSION 0.1
--------------------------------------------------------------------

-- 1. Establecer el esquema como predeterminado.
CREATE SCHEMA IF NOT EXISTS expenso_db;
SET search_path TO expenso_db, public;

-- 2. Activar la extensión para la generación automática de UUIDs.
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

--------------------------------------------------------------------
-- Main Entities
--------------------------------------------------------------------

CREATE TABLE app_user
(
    id                  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name          VARCHAR(255) NOT NULL,
    last_name           VARCHAR(255) NOT NULL,
    email               VARCHAR(255) NOT NULL,
    password            VARCHAR(255),
    role                VARCHAR(50)  NOT NULL,
    auth_provider       VARCHAR(50), -- Ej: 'google' o 'local'
    provider_id         VARCHAR(255),
    profile_picture_url VARCHAR(255),
    registration_date   TIMESTAMP,
    verify              BOOLEAN,
    active              BOOLEAN,
    deleted_at          TIMESTAMP,
    CONSTRAINT unique_email UNIQUE (email)
);

-- Tipos de transacciones: Gasto o Ingreso
CREATE TABLE transaction_type
(
    id   UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(50) NOT NULL UNIQUE -- 'EXPENSE' o 'INCOME'
);

-- Grupo de gastos: Fijo o Variable
CREATE TABLE expense_group
(
    id   UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(50) NOT NULL UNIQUE -- 'FIXED' o 'VARIABLE'
);

-- Categorías: Supermercado, Sueldo, Alquiler, etc.
CREATE TABLE category
(
    id                  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name                VARCHAR(100) NOT NULL,
    transaction_type_id UUID         NOT NULL,
    expense_group_id    UUID,
    UNIQUE (name, transaction_type_id),
    CONSTRAINT fk_category_transaction_type FOREIGN KEY (transaction_type_id) REFERENCES transaction_type (id),
    CONSTRAINT fk_category_expense_group FOREIGN KEY (expense_group_id) REFERENCES expense_group (id)
);

-- Transacciones registradas por el usuario
CREATE TABLE transaction
(
    id               UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    amount           DECIMAL(10, 2) NOT NULL,
    transaction_date DATE           NOT NULL,
    description      TEXT,
    category_id      UUID           NOT NULL,
    user_id          UUID,
    CONSTRAINT fk_transaction_category FOREIGN KEY (category_id) REFERENCES category (id),
    CONSTRAINT fk_transaction_user FOREIGN KEY (user_id) REFERENCES app_user (id)
);