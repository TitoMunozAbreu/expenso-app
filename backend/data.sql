--------------------------------------------------------------------
-- EXPENSO APP
-- MOCK DATA
-- VERSION 0.1
--------------------------------------------------------------------

-- Cambiar al esquema
SET search_path TO expenso_db, public;

-- 1. Insertar usuarios
INSERT INTO app_user (id, first_name, last_name, email, password, role, auth_provider, registration_date, verify, active)
VALUES
    (uuid_generate_v4(), 'Ana', 'Martínez', 'ana@example.com', 'hashed_password', 'USER', 'local', now(), true, true),
    (uuid_generate_v4(), 'Luis', 'Pérez', 'luis@example.com', 'hashed_password', 'USER', 'local', now(), true, true);

-- 2. Insertar tipos de transacción
INSERT INTO transaction_type (id, name)
VALUES
    (uuid_generate_v4(), 'EXPENSE'),
    (uuid_generate_v4(), 'INCOME');

-- Guardar IDs en variables temporales (útiles para las relaciones)
-- En muchos RDBMS como PostgreSQL esto lo harías con WITH o plpgsql, pero aquí lo haremos manualmente

-- 3. Insertar grupos de gasto
INSERT INTO expense_group (id, name)
VALUES
    (uuid_generate_v4(), 'FIXED'),
    (uuid_generate_v4(), 'VARIABLE');

-- 4. Insertar categorías

-- Primero recupera los UUIDs de EXPENSE y sus grupos para usarlos
-- Supongamos que los IDs están copiados manualmente aquí desde la base:

-- UUIDs simulados:
-- transaction_type
-- EXPENSE: '00000000-0000-0000-0000-000000000001'
-- INCOME:  '00000000-0000-0000-0000-000000000002'

-- expense_group
-- FIXED:    '00000000-0000-0000-0000-000000000010'
-- VARIABLE: '00000000-0000-0000-0000-000000000011'

-- Inserta categorías de gastos fijos y variables
INSERT INTO category (id, name, transaction_type_id, expense_group_id)
VALUES
    (uuid_generate_v4(), 'Alquiler',  '22e0ba2a-b488-44af-99d3-75faa82f2ca9', 'dcd4fa3b-74f0-49fe-9b6f-307cb6ba3f84'),
    (uuid_generate_v4(), 'Internet',  '22e0ba2a-b488-44af-99d3-75faa82f2ca9', 'dcd4fa3b-74f0-49fe-9b6f-307cb6ba3f84'),
    (uuid_generate_v4(), 'Supermercado', '22e0ba2a-b488-44af-99d3-75faa82f2ca9', '3b205cd1-2cc1-4f8a-8167-b4bc3ae59b79'),
    (uuid_generate_v4(), 'Transporte', '22e0ba2a-b488-44af-99d3-75faa82f2ca9', '3b205cd1-2cc1-4f8a-8167-b4bc3ae59b79');

-- Inserta categorías de ingresos
INSERT INTO category (id, name, transaction_type_id, expense_group_id)
VALUES
    (uuid_generate_v4(), 'Sueldo', '3279f6b0-6634-44f0-9353-7107ac834b78', null),
    (uuid_generate_v4(), 'Freelance', '3279f6b0-6634-44f0-9353-7107ac834b78', null);

-- 5. Insertar transacciones (simuladas)
-- Asumimos los IDs de usuario, categoría e ingreso/gasto están copiados o puedes hacer un SELECT previo.

-- Ejemplo transacciones:
-- usuario_id: '00000000-0000-0000-0000-00000000A001' (Ana)
-- categoria_id: '00000000-0000-0000-0000-00000000C001' (Supermercado)

INSERT INTO transaction (id, amount, transaction_date, description, category_id, user_id)
VALUES
    (uuid_generate_v4(), 55.30, '2025-05-01', 'Compra semanal supermercado', '2e3ce4e8-87b7-40b0-9ad5-30762bfe6759', 'd30e6f42-b8ee-4ee1-bf17-2ae8eb835eb6'),
    (uuid_generate_v4(), 30.00, '2025-05-03', 'Recarga transporte', '6fd062c0-b6c8-43be-9a03-f77dd9742afa', 'd30e6f42-b8ee-4ee1-bf17-2ae8eb835eb6'),
    (uuid_generate_v4(), 1200.00, '2025-05-01', 'Nómina mensual', '4439c5c1-4978-4db3-beba-e3ac085cf50c', 'd30e6f42-b8ee-4ee1-bf17-2ae8eb835eb6'),
    (uuid_generate_v4(), 45.00, '2025-05-04', 'Pago internet', 'ccd389eb-3824-4491-b2ea-225e0f7fca5b', 'd30e6f42-b8ee-4ee1-bf17-2ae8eb835eb6');
