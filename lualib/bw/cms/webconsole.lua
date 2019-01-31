local skynet = require "skynet.manager"

local web

local M = {}
function M.init(args)
    local port = assert(args.port)
    local users = assert(args.users)
    web = skynet.newservice("web/webserver", "gate", args.server or "bw.cms.server",
        args.handler or "bw.cms.handler", port, 10)
    skynet.call(web, "lua", "start", users)

    skynet.call(web, "lua", "set_menu", args.menu or {
        {name = "skynet", title = "Skynet", icon = "&#xe665;", lv = 2, children = {
            {title = "节点信息", icon = "&#xe857", lv = 2, href = "page/skynet/node_info.html"},
            {title = "所有服务", icon = "&#xe62d;", lv = 2, href = "page/skynet/all_service.html"},
            {title = "注入调试", icon = "&#xe631;", lv = 2, href = "page/skynet/inject.html"},
            {title = "GM", icon = "&#xe64e;", lv = 2, href = "page/skynet/gm.html"},
        }},
        {name = "user", title = "用户管理", icon = "&#xe770;", lv = 1, children = {
            {title = "数据统计", icon = "&#xe62c;", lv = 1, href = "page/stat.html"},
            {title = "GM", icon = "&#xe64e;", lv = 2, href = "page/skynet/gm.html"},
        }},
        {name = "update", title = "更新", icon = "&#xe609;", lv = 2, children = {
            {title = "客户端更新", icon = "&#xe62f;", lv = 2, href = "page/client_update"},
            {title = "服务端热更", icon = "&#xe62f;", lv = 2, href = "page/server_update"},
        }},
    })
end

return M
