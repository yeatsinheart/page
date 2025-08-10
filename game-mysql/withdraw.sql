
CREATE TABLE withdraw_payment (
    id VARCHAR(20) NOT NULL COMMENT '提现方式ID',
    name VARCHAR(100) NOT NULL COMMENT '提现方式名称，如银行卡、支付宝提现',
    code VARCHAR(50) NOT NULL COMMENT '唯一编码',
    description TEXT DEFAULT NULL COMMENT '提现方式描述',
    status BIT(1) DEFAULT b'1' COMMENT '状态，1=启用，0=禁用',
    created_at BIGINT NOT NULL COMMENT '创建时间戳（毫秒）',
    updated_at BIGINT NOT NULL COMMENT '更新时间戳（毫秒）',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='提现方式';

CREATE TABLE withdraw_developer (
    id VARCHAR(20) NOT NULL COMMENT '提现产商ID',
    name VARCHAR(100) NOT NULL COMMENT '提现产商名称，如银行、第三方支付平台',
    open_config VARCHAR(20) NOT NULL COMMENT '游戏请求方式[get,post-json,post-form,local-html]',
    request_config VARCHAR(255) NOT NULL COMMENT '请求配置，通常为json或url等字符串',
    history_config VARCHAR(255) NOT NULL COMMENT '游戏记录配置，通常为json或url等字符串',
    contact_info VARCHAR(255) DEFAULT NULL COMMENT '联系方式',
    status BIT(1) DEFAULT b'1' COMMENT '状态，1=启用，0=禁用',
    created_at BIGINT NOT NULL COMMENT '创建时间戳（毫秒）',
    updated_at BIGINT NOT NULL COMMENT '更新时间戳（毫秒）',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='提现产商';

CREATE TABLE withdraw_channel (
    id VARCHAR(20) NOT NULL COMMENT '提现通道ID',
    developer_id VARCHAR(20) NOT NULL COMMENT '关联提现产商ID',
    payment_id VARCHAR(20) NOT NULL COMMENT '关联提现方式ID',
    name VARCHAR(100) NOT NULL COMMENT '提现通道名称',
    exchange_rate DECIMAL(18,8) NOT NULL DEFAULT 1 COMMENT '提现汇率，默认1',
    status BIT(1) DEFAULT b'1' COMMENT '状态，1=启用，0=禁用',
    config JSON DEFAULT NULL COMMENT '提现通道配置信息',
    created_at BIGINT NOT NULL COMMENT '创建时间戳（毫秒）',
    updated_at BIGINT NOT NULL COMMENT '更新时间戳（毫秒）',
    PRIMARY KEY (id),
    INDEX idx_developer (developer_id),
    INDEX idx_payment (payment_id),
    CONSTRAINT fk_withdraw_channel_developer FOREIGN KEY (developer_id) REFERENCES withdraw_developer(id),
    CONSTRAINT fk_withdraw_channel_payment FOREIGN KEY (payment_id) REFERENCES withdraw_payment(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='提现通道，关联提现产商和提现方式';
