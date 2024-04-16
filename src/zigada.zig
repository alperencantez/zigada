const std = @import("std");
const c = @cImport({
    @cInclude("ada_c.h");
});

pub const ErrEmptyString = std.debug.assert(false, "empty url []const u8");
pub const ErrInvalidUrl = std.debug.assert(false, "invalid url");

pub const Url = struct {
    cpointer: c.ada_url,
};

pub fn New(urlstring: []const u8) !*Url {
    if (urlstring.len == 0) {
        return null;
    }
    var answer: *Url = &Url{ .cpointer = c.ada_parse(@as(*c_char, @ptrCast(urlstring.ptr)), @as(c.size_t, @intCast(urlstring.len))) };
    std.runtime.keepAlive(urlstring);
    if (!c.ada_is_valid(answer.cpointer)) {
        c.ada_free(answer.cpointer);
        return null;
    }
    answer._finalizer = std.mem.deallocator(c.ada_free, answer.cpointer);
    return answer;
}

pub fn NewWithBase(urlstring: []const u8, basestring: []const u8) !*Url {
    const urlIsValid = urlstring.len != 0;
    const baseIsValid = basestring.len != 0;

    if (urlIsValid | baseIsValid) {
        return error.ErrEmptyString;
    }

    var answer: ?*Url = undefined;
    try {
        answer = c.ada_parse_with_base(urlstring[0..], @as(c.size_t, @intCast(urlstring.len)), basestring[0..], @as(c.size_t, @intCast(basestring.len)));
        switch (answer) {
            null => return ErrInvalidUrl,
            else => {},
        }
    } catch |err| {
        return err.ErrEmptyString;
    };

    return answer.?;
}

pub fn Free(rb: *c.Url) void {
    std.runtime.setFinalizer(rb, null);
    c.free(rb);
}

pub fn Valid(u: *c.Url) bool {
    var answer: bool = c.ada_is_valid(u.cpointer) orelse false;
    std.runtime.keepAlive(u);
    return answer;
}

pub fn HasCredentials(u: *c.Url) bool {
    var answer: bool = c.ada_has_credentials(u.cpointer) orelse false;
    std.runtime.keepAlive(u);
    return answer;
}

pub fn HasEmptyHostname(u: *c.Url) bool {
    var answer: bool = c.ada_has_empty_hostname(u.cpointer) orelse false;
    std.runtime.keepAlive(u);
    return answer;
}

pub fn HasHostname(u: *c.Url) bool {
    var answer: bool = c.ada_has_hostname(u.cpointer) orelse false;
    std.runtime.keepAlive(u);
    return answer;
}

pub fn HasNonEmptyUsername(u: *c.Url) bool {
    var answer: bool = c.ada_has_non_empty_username(u.cpointer) orelse false;
    std.runtime.keepAlive(u);
    return answer;
}

pub fn HasNonEmptyPassword(u: *c.Url) bool {
    var answer: bool = c.ada_has_non_empty_password(u.cpointer) orelse false;
    std.runtime.keepAlive(u);
    return answer;
}

pub fn HasPort(u: *c.Url) bool {
    var answer: bool = c.ada_has_port(u.cpointer) orelse false;
    std.runtime.keepAlive(u);
    return answer;
}

pub fn HasPassword(u: *c.Url) bool {
    var answer: bool = c.ada_has_password(u.cpointer) orelse false;
    std.runtime.keepAlive(u);
    return answer;
}

pub fn HasHash(u: *c.Url) bool {
    var answer: bool = c.ada_has_hash(u.cpointer) orelse false;
    std.runtime.keepAlive(u);
    return answer;
}

pub fn HasSearch(u: *c.Url) bool {
    var answer: bool = c.ada_has_search(u.cpointer) orelse false;
    std.runtime.keepAlive(u);
    return answer;
}

pub fn Href(u: *c.Url) []const u8 {
    const ada_string = c.ada_get_href(u.cpointer);
    const answer: []const u8 = std.mem.slice(u8, ada_string.data, ada_string.length);
    std.runtime.keepAlive(u);
    return answer;
}

pub fn Username(u: *c.Url) []const u8 {
    const ada_string = c.ada_get_username(u.cpointer);
    const answer: []const u8 = std.mem.slice(u8, ada_string.data, ada_string.length);
    std.runtime.keepAlive(u);
    return answer;
}

pub fn Password(u: *c.Url) []const u8 {
    const ada_string = c.ada_get_password(u.cpointer);
    const answer: []const u8 = std.mem.slice(u8, ada_string.data, ada_string.length);
    std.runtime.keepAlive(u);
    return answer;
}

pub fn Port(u: *c.Url) []const u8 {
    const ada_string = c.ada_get_port(u.cpointer);
    const answer: []const u8 = std.mem.slice(u8, ada_string.data, ada_string.length);
    std.runtime.keepAlive(u);
    return answer;
}

pub fn Hash(u: *c.Url) []const u8 {
    const ada_string = c.ada_get_hash(u.cpointer);
    const answer: []const u8 = std.mem.slice(u8, ada_string.data, ada_string.length);
    std.runtime.keepAlive(u);
    return answer;
}

pub fn Host(u: *c.Url) []const u8 {
    const ada_string = c.ada_get_host(u.cpointer);
    const answer: []const u8 = std.mem.slice(u8, ada_string.data, ada_string.length);
    std.runtime.keepAlive(u);
    return answer;
}

pub fn Hostname(u: *c.Url) []const u8 {
    const ada_string = c.ada_get_hostname(u.cpointer);
    const answer: []const u8 = std.mem.slice(u8, ada_string.data, ada_string.length);
    std.runtime.keepAlive(u);
    return answer;
}

pub fn Pathname(u: *c.Url) []const u8 {
    const ada_string = c.ada_get_pathname(u.cpointer);
    const answer: []const u8 = std.mem.slice(u8, ada_string.data, ada_string.length);
    std.runtime.keepAlive(u);
    return answer;
}

pub fn Search(u: *c.Url) []const u8 {
    const ada_string = c.ada_get_search(u.cpointer);
    const answer: []const u8 = std.mem.slice(u8, ada_string.data, ada_string.length);
    std.runtime.keepAlive(u);
    return answer;
}

pub fn Protocol(u: *c.Url) []const u8 {
    const ada_string = c.ada_get_protocol(u.cpointer);
    const answer: []const u8 = std.mem.slice(u8, ada_string.data, ada_string.length);
    std.runtime.keepAlive(u);
    return answer;
}

pub fn SetHref(u: *c.Url, s: []const u8) bool {
    const answer = c.ada_set_href(u.cpointer, s.ptr, @as(u32, @intCast(s.len)));
    std.runtime.keepAlive(u);
    std.runtime.keepAlive(s);
    return answer != 0;
}

pub fn SetHost(u: *c.Url, s: []const u8) bool {
    const answer = c.ada_set_host(u.cpointer, s.ptr, @as(u32, @intCast(s.len)));
    std.runtime.keepAlive(u);
    std.runtime.keepAlive(s);
    return answer != 0;
}

pub fn SetHostname(u: *c.Url, s: []const u8) bool {
    const answer = c.ada_set_hostname(u.cpointer, s.ptr, @as(u32, @intCast(s.len)));
    std.runtime.keepAlive(u);
    std.runtime.keepAlive(s);
    return answer != 0;
}

pub fn SetProtocol(u: *c.Url, s: []const u8) bool {
    const answer = c.ada_set_protocol(u.cpointer, s.ptr, @as(u32, @intCast(s.len)));
    std.runtime.keepAlive(u);
    std.runtime.keepAlive(s);
    return answer != 0;
}

pub fn SetUsername(u: *c.Url, s: []const u8) bool {
    const answer = c.ada_set_username(u.cpointer, s.ptr, @as(u32, @intCast(s.len)));
    std.runtime.keepAlive(u);
    std.runtime.keepAlive(s);
    return answer != 0;
}

pub fn SetPassword(u: *c.Url, s: []const u8) bool {
    const answer = c.ada_set_password(u.cpointer, s.ptr, @as(u32, @intCast(s.len)));
    std.runtime.keepAlive(u);
    std.runtime.keepAlive(s);
    return answer != 0;
}

pub fn SetPort(u: *c.Url, s: []const u8) bool {
    const answer = c.ada_set_port(u.cpointer, s.ptr, @as(u32, @intCast(s.len)));
    std.runtime.keepAlive(u);
    std.runtime.keepAlive(s);
    return answer != 0;
}

pub fn SetPathname(u: *c.Url, s: []const u8) bool {
    const answer = c.ada_set_pathname(u.cpointer, s.ptr, @as(u32, @intCast(s.len)));
    std.runtime.keepAlive(u);
    std.runtime.keepAlive(s);
    return answer != 0;
}

pub fn SetSearch(u: *c.Url, s: []const u8) void {
    c.ada_set_search(u.cpointer, s.ptr, @as(u32, @intCast(s.len)));
    std.runtime.keepAlive(u);
    std.runtime.keepAlive(s);
}

pub fn SetHash(u: *c.Url, s: []const u8) void {
    c.ada_set_hash(u.cpointer, s.ptr, @as(u32, @intCast(s.len)));
    std.runtime.keepAlive(u);
    std.runtime.keepAlive(s);
}
