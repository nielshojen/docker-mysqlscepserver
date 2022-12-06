CREATE TABLE serials (
    serial BIGINT NOT NULL AUTO_INCREMENT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (serial)
);

CREATE TABLE certificates (
    serial BIGINT NOT NULL,
    name             VARCHAR(1024) NULL,
    not_valid_before DATETIME NOT NULL,
    not_valid_after  DATETIME NOT NULL,
    certificate_pem  TEXT NOT NULL,
    revoked          BOOLEAN NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (serial),
    FOREIGN KEY (serial)
        REFERENCES serials (serial),
    ADD CONSTRAINT certificates_chk_1 CHECK (SUBSTRING(certificate_pem FROM 1 FOR 27) = '-----BEGIN CERTIFICATE-----')
    ADD CONSTRAINT certificates_chk_2 CHECK (name IS NULL OR name != '')
);

CREATE TABLE ca_keys (
    serial BIGINT NOT NULL,
    key_pem  TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (serial),
    FOREIGN KEY (serial)
        REFERENCES certificates (serial),
    ADD CONSTRAINT ca_keys_chk_1 CHECK (SUBSTRING(key_pem  FROM 1 FOR  5) = '-----')
);

CREATE TABLE challenges (
    challenge CHAR(32),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (challenge)
);
