v1.0.4（v1.0.3 之后至本版本）

修改内容
1. 新增 test_board.proto 通用配牌请求、响应、动作和盘面字段，供 admin 与玩法服务配套使用。
2. deployment_agent.proto 增加 START_SERVICE 动作及代理启服能力声明，支持 admin 派发启服任务。

部署前准备
1. 配套 game v1.0.4、slotadmin v1.0.4，按各项目生成入口同步协议产物，不手工修改生成代码或重新编号既有协议。
2. monitor 更新后才能接收启服任务；配牌需配套 SuperAce、admin 前后端和配牌菜单授权迁移。
3. 本仓库没有独立进程或数据库迁移；金币调整复用原有 api_wallet.proto，新增审计表及权限等准备详见 slotadmin v1.0.4 标签。各环境运行配置、验证和生产审批仍按项目规则执行。
