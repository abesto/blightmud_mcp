--
-- MUD Client Protocol 2.1
-- (http://www.moo.mud.org/mcp2/mcp2.html)
--
-- Author: lisdude <lisdude@lisdude.com>
--
min_version = 2.1;
max_version = 2.1;
debug_mcp = false;

advertisement_regex = "^#\\$#mcp version: (.+) to: (.+)$";
negotiate_can_regex = "^#\\$#mcp-negotiate-can (.+) package: (.+) min-version: (.+) max-version: (.+)$";

supported_packages = {};   -- Packages that the client supports.
negotiated_packages = {};  -- Packages that both the client and server support.

blight:load("mcp/mcp_utils.lua");      -- useful utility functions
blight:load("mcp/mcp_negotiate.lua");  -- mcp-negotiate package
blight:load("mcp/mcp_client.lua");     -- dns-com-vmoo-client package
blight:load("mcp/mcp_simpleedit.lua"); -- dns-org-mud-moo-simpleedit package

-- Begin registration with the server. This process sends the authentication key
-- and negotiates what packages are available. This is a bit odd because we have to
-- register the negotiation trigger outside of the actual negotiation package.
-- Why? Because we have to be able to negotiate to negotiate the negotiate package. Twisty.
function mcp_register(version)
    auth_key = generate_auth_key();
    blight:send("#$#mcp authentication-key: " .. auth_key .. " version: " .. min_version .. " to: " .. max_version);
    blight:add_trigger(negotiate_can_regex, { gag = not debug_mcp }, negotiate_can);
end

-- The callback function for the MCP advertisement message. This will determine
-- if the client and server both support a common MCP version. If so, the 'mcp_version'
-- variable is set to the highest version supported by both and actual MCP registration begins.
-- If no supported versions are found, a message is printed and nothing else happens.
function mcp_register_trigger(matches)
    mcp_version = supported_version(min_version, max_version, tonumber(matches[2]), tonumber(matches[3]));
    if mcp_version == false then
        blight:output(">>> Unsupported MCP versions: " .. matches[2] .. " to " .. matches[3] .. " <<<");
    else
        mcp_register(mcp_version);
    end
end

blight:add_trigger(advertisement_regex, { gag = not debug_mcp }, mcp_register_trigger);
