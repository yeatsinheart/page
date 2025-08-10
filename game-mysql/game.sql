CREATE TABLE game_developer (
    id VARCHAR(20) NOT NULL COMMENT '游戏产商ID',
    open_config VARCHAR(20) NOT NULL COMMENT '游戏请求方式[get,post-json,post-form,local-html]',
    request_config VARCHAR(255) NOT NULL COMMENT '请求配置，通常为json或url等字符串',
    history_config VARCHAR(255) NOT NULL COMMENT '游戏记录配置，通常为json或url等字符串',
    enable BIT(1) DEFAULT b'0' COMMENT '是否运营，0=否，1=是',
    status VARCHAR(20) DEFAULT 'on' COMMENT '状态：on maintain',
    remark TEXT DEFAULT NULL COMMENT '备注',
    created_at BIGINT NOT NULL COMMENT '创建时间戳（毫秒）',
    updated_at BIGINT NOT NULL COMMENT '更新时间戳（毫秒）',
    is_deleted BIT(1) DEFAULT b'0' COMMENT '软删除标识，0=正常，1=删除',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='游戏产商';

CREATE TABLE game_category (
    id VARCHAR(20) NOT NULL COMMENT '游戏分类ID',
    name VARCHAR(100) NOT NULL COMMENT '游戏分类名称',
    img1x1 VARCHAR(255) DEFAULT NULL COMMENT '分类1:1比例图片地址',
    img3x4 VARCHAR(255) DEFAULT NULL COMMENT '分类3:4比例图片地址',
    games JSON DEFAULT NULL COMMENT '所有游戏，按权重排序，',
    brands JSON DEFAULT NULL COMMENT '所有品牌，按权重排序，自动根据游戏数据更新，',
    description TEXT DEFAULT NULL COMMENT '分类描述',
    is_deleted BIT(1) DEFAULT b'0' COMMENT '软删除标识，0=正常，1=删除',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='游戏分类';

CREATE TABLE game_brand (
    id VARCHAR(20) NOT NULL COMMENT '游戏品牌ID',
    name VARCHAR(100) NOT NULL COMMENT '品牌名称',
    img1x1 VARCHAR(255) DEFAULT NULL COMMENT '品牌1:1比例图片地址',
    img3x4 VARCHAR(255) DEFAULT NULL COMMENT '品牌3:4比例图片地址',
    categories JSON DEFAULT NULL COMMENT '所有游戏分类，按权重排序',
    description TEXT DEFAULT NULL COMMENT '品牌介绍',
    website VARCHAR(255) DEFAULT NULL COMMENT '品牌官网链接',
    created_at BIGINT NOT NULL COMMENT '创建时间戳（毫秒）',
    updated_at BIGINT NOT NULL COMMENT '更新时间戳（毫秒）',
    is_deleted BIT(1) DEFAULT b'0' COMMENT '软删除标识，0=正常，1=删除',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='游戏品牌';

CREATE TABLE game (
    id VARCHAR(20) NOT NULL COMMENT '游戏ID',
    name VARCHAR(100) NOT NULL COMMENT '游戏名称',
    game_developer_id VARCHAR(20) NOT NULL COMMENT '游戏产商ID，关联game_developer.id',
    game_brand_id VARCHAR(20) NOT NULL COMMENT '游戏品牌ID，关联game_brand.id',
    img1x1 VARCHAR(255) DEFAULT NULL COMMENT '游戏1:1比例图片地址',
    img3x4 VARCHAR(255) DEFAULT NULL COMMENT '游戏3:4比例图片地址',
    description TEXT DEFAULT NULL COMMENT '游戏介绍',
    status VARCHAR(20) DEFAULT 'active' COMMENT '游戏状态（active, inactive, maintenance）',
    PRIMARY KEY (id),
    INDEX idx_game_developer_id (game_developer_id),
    INDEX idx_game_brand_id (game_brand_id),
    CONSTRAINT fk_game_developer FOREIGN KEY (game_developer_id) REFERENCES game_developer(id),
    CONSTRAINT fk_game_brand FOREIGN KEY (game_brand_id) REFERENCES game_brand(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='游戏';

CREATE TABLE game_play_mode (
    id VARCHAR(20) NOT NULL COMMENT '玩法分类ID',
    name VARCHAR(100) NOT NULL COMMENT '玩法名称',
    img1x1 VARCHAR(255) DEFAULT NULL COMMENT '玩法1:1比例图片地址',
    games JSON DEFAULT NULL COMMENT '包含的所有游戏，按权重排序',
    description TEXT DEFAULT NULL COMMENT '玩法介绍',
    created_at BIGINT NOT NULL COMMENT '创建时间戳（毫秒）',
    updated_at BIGINT NOT NULL COMMENT '更新时间戳（毫秒）',
    is_deleted BIT(1) DEFAULT b'0' COMMENT '软删除标识，0=正常，1=删除',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='玩法分类（彩种）';

CREATE TABLE game_developer_agent (
    tenant_id VARCHAR(20) NOT NULL COMMENT '租户ID，关联租户系统,或者share共用',
    game_developer_id VARCHAR(20) NOT NULL COMMENT '游戏产商ID，关联game_developer.id',
    agent_config VARCHAR(2000) NOT NULL COMMENT '账户配置，json字符串',
    balance_mode VARCHAR(50) NOT NULL COMMENT '扣钱方式:预存deposit，回调接口帐变api',
    status VARCHAR(20) DEFAULT 'active' COMMENT '账号状态（active, frozen等）',
    created_at BIGINT NOT NULL COMMENT '创建时间戳（毫秒）',
    updated_at BIGINT NOT NULL COMMENT '更新时间戳（毫秒）',
    PRIMARY KEY (tenant_id, game_developer_id),
    CONSTRAINT fk_account_developer FOREIGN KEY (game_developer_id) REFERENCES game_developer(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='游戏产商代理账号';


我要做的是一个游戏接入服务，游戏之间关系层级：游戏分类->品牌->玩法分类->游戏
界面上，大概逻辑，游戏分类->品牌 游戏分类->游戏 品牌->游戏 品牌->游戏分类 品牌->玩法分类

