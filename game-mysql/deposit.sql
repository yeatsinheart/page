CREATE TABLE deposit_payment (
    id VARCHAR(20) NOT NULL COMMENT '充值方式ID',
    name VARCHAR(100) NOT NULL COMMENT '充值方式名称，如支付宝、微信',
    code VARCHAR(50) NOT NULL COMMENT '唯一编码，便于程序识别',
    description TEXT DEFAULT NULL COMMENT '充值方式描述',
    status BIT(1) DEFAULT b'1' COMMENT '状态，1=启用，0=禁用',
    created_at BIGINT NOT NULL COMMENT '创建时间戳（毫秒）',
    updated_at BIGINT NOT NULL COMMENT '更新时间戳（毫秒）',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='充值方式';

CREATE TABLE deposit_developer (
    id VARCHAR(20) NOT NULL COMMENT '充值产商ID',
    name VARCHAR(100) NOT NULL COMMENT '充值产商名称，如某支付服务商',
    open_config VARCHAR(20) NOT NULL COMMENT '游戏请求方式[get,post-json,post-form,local-html]',
    request_config VARCHAR(255) NOT NULL COMMENT '请求配置，通常为json或url等字符串',
    history_config VARCHAR(255) NOT NULL COMMENT '游戏记录配置，通常为json或url等字符串',
    contact_info VARCHAR(255) DEFAULT NULL COMMENT '联系方式',
    status BIT(1) DEFAULT b'1' COMMENT '状态，1=启用，0=禁用',
    created_at BIGINT NOT NULL COMMENT '创建时间戳（毫秒）',
    updated_at BIGINT NOT NULL COMMENT '更新时间戳（毫秒）',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='充值产商';

CREATE TABLE deposit_channel (
    id VARCHAR(20) NOT NULL COMMENT '充值通道ID',
    developer_id VARCHAR(20) NOT NULL COMMENT '关联充值产商ID',
    payment_id VARCHAR(20) NOT NULL COMMENT '关联充值方式ID',
    name VARCHAR(100) NOT NULL COMMENT '充值通道名称',
    exchange_rate DECIMAL(18,8) NOT NULL DEFAULT 1 COMMENT '充值汇率，默认1',
    status BIT(1) DEFAULT b'1' COMMENT '状态，1=启用，0=禁用',
    config JSON DEFAULT NULL COMMENT '充值通道配置信息，如回调地址等',
    created_at BIGINT NOT NULL COMMENT '创建时间戳（毫秒）',
    updated_at BIGINT NOT NULL COMMENT '更新时间戳（毫秒）',
    PRIMARY KEY (id),
    INDEX idx_developer (developer_id),
    INDEX idx_payment (payment_id),
    CONSTRAINT fk_deposit_channel_developer FOREIGN KEY (developer_id) REFERENCES deposit_developer(id),
    CONSTRAINT fk_deposit_channel_payment FOREIGN KEY (payment_id) REFERENCES deposit_payment(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='充值通道，关联充值产商和充值方式';
