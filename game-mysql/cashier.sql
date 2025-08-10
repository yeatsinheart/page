
CREATE TABLE cashier_payment (
    id VARCHAR(20) NOT NULL COMMENT '支付方式ID',
    account_type VARCHAR(50) NOT NULL COMMENT '账号类型，如银行卡、支付宝账号',
    link_count INT NOT NULL DEFAULT 1 COMMENT '最多可绑定账号数量',
    link_view VARCHAR(255) DEFAULT NULL COMMENT '绑定账号界面标识或路由',
    detail_view VARCHAR(255) DEFAULT NULL COMMENT '绑定详情界面标识或路由',
    status BIT(1) DEFAULT b'1' COMMENT '状态，1=启用，0=禁用',
    created_at BIGINT NOT NULL COMMENT '创建时间戳（毫秒）',
    updated_at BIGINT NOT NULL COMMENT '更新时间戳（毫秒）',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付方式';

CREATE TABLE cashier_account (
    id VARCHAR(36) NOT NULL COMMENT '绑定账号ID，UUID',
    tenant_id VARCHAR(20) NOT NULL COMMENT '租户ID',
    user_id VARCHAR(50) NOT NULL COMMENT '用户ID',
    account_type VARCHAR(50) NOT NULL COMMENT '账号类型，如银行卡、支付宝账号',
    account_identifier VARCHAR(255) NOT NULL COMMENT '绑定账号标识，如银行卡号、支付宝账号',
    account_name VARCHAR(100) DEFAULT NULL COMMENT '账户持有人姓名',
    bank_name VARCHAR(100) DEFAULT NULL COMMENT '银行名称，若为银行卡',
    branch_name VARCHAR(100) DEFAULT NULL COMMENT '开户行支行名称',
    status BIT(1) DEFAULT b'1' COMMENT '状态，1=启用，0=禁用',
    created_at BIGINT NOT NULL COMMENT '绑定时间戳（毫秒）',
    updated_at BIGINT NOT NULL COMMENT '更新时间戳（毫秒）',
    PRIMARY KEY (id),
    INDEX idx_tenant_user (tenant_id, user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户绑定的支付账户信息';

CREATE TABLE cashier_exchange_rate (
    id VARCHAR(36) NOT NULL COMMENT '汇率记录ID，UUID',
    from_currency VARCHAR(10) NOT NULL COMMENT '源币种，如USD',
    to_currency VARCHAR(10) NOT NULL COMMENT '目标币种，如CNY',
    rate DECIMAL(18,8) NOT NULL COMMENT '汇率值',
    updated_at BIGINT NOT NULL COMMENT '更新时间戳（毫秒）',
    PRIMARY KEY (id),
    UNIQUE KEY unique_currency_pair (from_currency, to_currency)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='汇率记录';