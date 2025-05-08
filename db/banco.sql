-- Tabela de Clientes
CREATE TABLE clientes (
  id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
  email VARCHAR UNIQUE NOT NULL,
  password VARCHAR NOT NULL,
  registration_number VARCHAR,
  role VARCHAR CHECK (role IN ('student', 'admin')) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Horários de Check-in
CREATE TABLE checkin_schedules (
  id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
  check_time TIME NOT NULL,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Áreas de Estacionamento
CREATE TABLE parking_areas (
  id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Vagas de Estacionamento
CREATE TABLE parking_spots (
  id SERIAL PRIMARY KEY,
  area_id INTEGER REFERENCES parking_areas(id),
  code VARCHAR UNIQUE NOT NULL,
  type VARCHAR CHECK (type IN ('comum', 'preferencial', 'elétrica')) NOT NULL,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Registros de Check-in
CREATE TABLE checkin_records (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES clientes(id),
  schedule_id INTEGER NOT NULL REFERENCES checkin_schedules(id),
  check_date DATE NOT NULL,
  parking_spot_id INTEGER REFERENCES parking_spots(id),
  status VARCHAR CHECK (status IN ('present', 'absent', 'late')),
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Reservas Agendadas
CREATE TABLE scheduled_reservations (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES clientes(id),
  parking_spot_id INTEGER NOT NULL REFERENCES parking_spots(id),
  checkin_schedule_id INTEGER NOT NULL REFERENCES checkin_schedules(id),
  date DATE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Notificações
CREATE TABLE notifications (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES clientes(id),
  checkin_record_id INTEGER REFERENCES checkin_records(id),
  message TEXT NOT NULL,
  is_read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
