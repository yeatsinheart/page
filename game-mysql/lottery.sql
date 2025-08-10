CREATE TABLE lottery_category (
    id VARCHAR(20) NOT NULL COMMENT '彩票分类ID',
    name VARCHAR(100) NOT NULL COMMENT '彩票分类名称，如数字彩、六合彩等',
    description TEXT DEFAULT NULL COMMENT '分类描述',
    img1x1 VARCHAR(255) DEFAULT NULL COMMENT '分类1:1图片',
    img3x4 VARCHAR(255) DEFAULT NULL COMMENT '分类3:4图片',
    created_at BIGINT NOT NULL COMMENT '创建时间戳',
    updated_at BIGINT NOT NULL COMMENT '更新时间戳',
    is_deleted BIT(1) DEFAULT b'0' COMMENT '软删除',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='彩票分类';

CREATE TABLE lottery (
    id VARCHAR(20) NOT NULL COMMENT '彩票ID',
    category_id VARCHAR(20) NOT NULL COMMENT '彩票分类ID，关联lottery_category.id',
    name VARCHAR(100) NOT NULL COMMENT '彩票名称，如“福彩3D”、“北京赛车”',
    code VARCHAR(50) DEFAULT NULL COMMENT '彩票编码（系统内部使用）',
    status VARCHAR(20) DEFAULT 'active' COMMENT '彩票状态，如active, maintenance, inactive',
    open_time VARCHAR(50) DEFAULT NULL COMMENT '开奖时间规则，如“每天20:00”等',
    img1x1 VARCHAR(255) DEFAULT NULL COMMENT '彩票1:1图片',
    img3x4 VARCHAR(255) DEFAULT NULL COMMENT '彩票3:4图片',
    description TEXT DEFAULT NULL COMMENT '彩票描述',
    created_at BIGINT NOT NULL COMMENT '创建时间戳',
    updated_at BIGINT NOT NULL COMMENT '更新时间戳',
    is_deleted BIT(1) DEFAULT b'0' COMMENT '软删除',
    PRIMARY KEY (id),
    INDEX idx_category_id (category_id),
    CONSTRAINT fk_lottery_category FOREIGN KEY (category_id) REFERENCES lottery_category(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='彩票';

CREATE TABLE play_mode (
    id VARCHAR(20) NOT NULL COMMENT '玩法分类ID',
    lottery_id VARCHAR(20) NOT NULL COMMENT '彩票ID，关联lottery.id',
    name VARCHAR(100) NOT NULL COMMENT '玩法分类名称，如“直选”、“组选”等',
    code VARCHAR(50) DEFAULT NULL COMMENT '玩法分类编码',
    description TEXT DEFAULT NULL COMMENT '玩法描述',
    img1x1 VARCHAR(255) DEFAULT NULL COMMENT '玩法分类图片',
    status VARCHAR(20) DEFAULT 'active' COMMENT '状态',
    created_at BIGINT NOT NULL COMMENT '创建时间戳',
    updated_at BIGINT NOT NULL COMMENT '更新时间戳',
    is_deleted BIT(1) DEFAULT b'0' COMMENT '软删除',
    PRIMARY KEY (id),
    INDEX idx_lottery_id (lottery_id),
    CONSTRAINT fk_play_mode_lottery FOREIGN KEY (lottery_id) REFERENCES lottery(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='玩法分类';

CREATE TABLE play (
    id VARCHAR(20) NOT NULL COMMENT '玩法ID',
    play_mode_id VARCHAR(20) NOT NULL COMMENT '玩法分类ID，关联play_mode.id',
    name VARCHAR(100) NOT NULL COMMENT '玩法名称，如“直选单式”、“组选和值”',
    code VARCHAR(50) DEFAULT NULL COMMENT '玩法编码',
    odds DECIMAL(10,4) DEFAULT NULL COMMENT '赔率',
    min_bet_amount DECIMAL(10,2) DEFAULT NULL COMMENT '最小投注额',
    max_bet_amount DECIMAL(10,2) DEFAULT NULL COMMENT '最大投注额',
    status VARCHAR(20) DEFAULT 'active' COMMENT '玩法状态',
    description TEXT DEFAULT NULL COMMENT '玩法描述',
    created_at BIGINT NOT NULL COMMENT '创建时间戳',
    updated_at BIGINT NOT NULL COMMENT '更新时间戳',
    is_deleted BIT(1) DEFAULT b'0' COMMENT '软删除',
    PRIMARY KEY (id),
    INDEX idx_play_mode_id (play_mode_id),
    CONSTRAINT fk_play_play_mode FOREIGN KEY (play_mode_id) REFERENCES play_mode(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='玩法';

CREATE TABLE lottery_issue (
    id VARCHAR(50) NOT NULL COMMENT '期号ID（唯一）',
    lottery_id VARCHAR(20) NOT NULL COMMENT '彩票ID',
    issue_number VARCHAR(50) NOT NULL COMMENT '期号',
    start_time BIGINT NOT NULL COMMENT '销售开始时间戳',
    end_time BIGINT NOT NULL COMMENT '销售结束时间戳',
    open_time BIGINT DEFAULT NULL COMMENT '开奖时间戳',
    status VARCHAR(20) DEFAULT 'pending' COMMENT '期号状态（pending, opened, canceled）',
    result TEXT DEFAULT NULL COMMENT '开奖结果JSON或文本',
    created_at BIGINT NOT NULL COMMENT '创建时间戳',
    updated_at BIGINT NOT NULL COMMENT '更新时间戳',
    is_deleted BIT(1) DEFAULT b'0' COMMENT '软删除',
    PRIMARY KEY (id),
    INDEX idx_lottery_id (lottery_id),
    CONSTRAINT fk_issue_lottery FOREIGN KEY (lottery_id) REFERENCES lottery(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='彩票期号';

CREATE TABLE bet_record (
    id VARCHAR(50) NOT NULL COMMENT '投注记录ID',
    user_id VARCHAR(50) NOT NULL COMMENT '用户ID',
    lottery_id VARCHAR(20) NOT NULL COMMENT '彩票ID',
    issue_id VARCHAR(50) NOT NULL COMMENT '期号ID',
    play_id VARCHAR(20) NOT NULL COMMENT '玩法ID',
    bet_amount DECIMAL(12,2) NOT NULL COMMENT '投注金额',
    bet_content TEXT NOT NULL COMMENT '投注内容（号码等）',
    odds DECIMAL(10,4) NOT NULL COMMENT '投注赔率',
    win_amount DECIMAL(12,2) DEFAULT 0 COMMENT '中奖金额',
    status VARCHAR(20) DEFAULT 'pending' COMMENT '投注状态（pending, win, lose, canceled）',
    created_at BIGINT NOT NULL COMMENT '投注时间戳',
    updated_at BIGINT NOT NULL COMMENT '更新时间戳',
    PRIMARY KEY (id),
    INDEX idx_user_id (user_id),
    INDEX idx_lottery_id (lottery_id),
    INDEX idx_issue_id (issue_id),
    INDEX idx_play_id (play_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='投注记录';
