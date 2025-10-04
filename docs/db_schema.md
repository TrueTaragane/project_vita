# Automation DB Schema

## 🗄️ Overview

The Vita Automation Database stores configuration data, historical events, device states, and user preferences for the smart home system. It uses SQLite for local installations and supports PostgreSQL for enterprise deployments.

## 🏗️ Entity Relationship Diagram

```
[Users] 1---* [Devices]
   |              |
   |              |
[Rules] *------* [Device_States]
   |              |
   |              |
[Events] *-----* [Notifications]
   |
   |
[Scenes] *-----* [Device_Groups]
```

## 📋 Tables

### Users
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | INTEGER | PRIMARY KEY | Unique user identifier |
| username | TEXT | UNIQUE, NOT NULL | User login name |
| password_hash | TEXT | NOT NULL | Hashed password |
| email | TEXT | UNIQUE | Contact email |
| created_at | DATETIME | NOT NULL | Account creation timestamp |
| last_login | DATETIME | | Last login timestamp |
| permissions | TEXT | | JSON-encoded permissions |

### Devices
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | INTEGER | PRIMARY KEY | Unique device identifier |
| name | TEXT | NOT NULL | Human-readable device name |
| type | TEXT | NOT NULL | Device category (light, sensor, etc.) |
| model | TEXT | | Device model information |
| vendor | TEXT | | Manufacturer name |
| location | TEXT | | Physical location in home |
| mqtt_topic | TEXT | UNIQUE | MQTT topic for device communication |
| status | TEXT | | Current device status |
| last_seen | DATETIME | | Last communication timestamp |

### Device_States
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | INTEGER | PRIMARY KEY | Unique state identifier |
| device_id | INTEGER | FOREIGN KEY | Reference to Devices table |
| attribute | TEXT | NOT NULL | State attribute (power, brightness, etc.) |
| value | TEXT | NOT NULL | Current attribute value |
| timestamp | DATETIME | NOT NULL | When state was recorded |
| source | TEXT | | What triggered the state change |

### Rules
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | INTEGER | PRIMARY KEY | Unique rule identifier |
| name | TEXT | NOT NULL | Rule name |
| description | TEXT | | Rule description |
| yaml_config | TEXT | NOT NULL | YAML configuration of the rule |
| enabled | BOOLEAN | DEFAULT TRUE | Whether rule is active |
| created_by | INTEGER | FOREIGN KEY | Reference to Users table |
| created_at | DATETIME | NOT NULL | Rule creation timestamp |
| last_modified | DATETIME | | Last modification timestamp |

### Events
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | INTEGER | PRIMARY KEY | Unique event identifier |
| type | TEXT | NOT NULL | Event type (motion, door_open, etc.) |
| device_id | INTEGER | FOREIGN KEY | Reference to Devices table |
| value | TEXT | | Event value/data |
| timestamp | DATETIME | NOT NULL | When event occurred |
| processed | BOOLEAN | DEFAULT FALSE | Whether event was processed |

### Notifications
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | INTEGER | PRIMARY KEY | Unique notification identifier |
| event_id | INTEGER | FOREIGN KEY | Reference to Events table |
| type | TEXT | NOT NULL | Notification type (email, sms, etc.) |
| recipient | TEXT | NOT NULL | Notification recipient |
| message | TEXT | NOT NULL | Notification content |
| sent_at | DATETIME | | When notification was sent |
| status | TEXT | | Delivery status |

### Scenes
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | INTEGER | PRIMARY KEY | Unique scene identifier |
| name | TEXT | NOT NULL | Scene name |
| description | TEXT | | Scene description |
| yaml_config | TEXT | NOT NULL | YAML configuration of the scene |
| created_by | INTEGER | FOREIGN KEY | Reference to Users table |
| created_at | DATETIME | NOT NULL | Scene creation timestamp |

### Device_Groups
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | INTEGER | PRIMARY KEY | Unique group identifier |
| name | TEXT | NOT NULL | Group name |
| description | TEXT | | Group description |
| device_ids | TEXT | | JSON array of device IDs |

## 🔧 Indexes

```sql
CREATE INDEX idx_device_states_device_id ON Device_States(device_id);
CREATE INDEX idx_device_states_timestamp ON Device_States(timestamp);
CREATE INDEX idx_events_timestamp ON Events(timestamp);
CREATE INDEX idx_events_processed ON Events(processed);
CREATE INDEX idx_rules_enabled ON Rules(enabled);
```

## 🔁 Triggers

```sql
CREATE TRIGGER update_device_last_seen
AFTER INSERT ON Device_States
FOR EACH ROW
BEGIN
    UPDATE Devices 
    SET last_seen = NEW.timestamp 
    WHERE id = NEW.device_id;
END;
```

## 📊 Views

```sql
CREATE VIEW device_status_summary AS
SELECT 
    d.name,
    d.type,
    ds.attribute,
    ds.value,
    ds.timestamp
FROM Devices d
JOIN Device_States ds ON d.id = ds.device_id
WHERE ds.timestamp = (
    SELECT MAX(timestamp) 
    FROM Device_States 
    WHERE device_id = d.id
);
```

## 🔐 Security Considerations

### Data Encryption
- Sensitive data encrypted at rest
- TLS for database connections
- Role-based access control

### Backup Strategy
- Daily automated backups
- Point-in-time recovery
- Offsite backup storage

### Performance Optimization
- Query optimization for frequent operations
- Connection pooling for high-concurrency scenarios
- Read replicas for reporting queries